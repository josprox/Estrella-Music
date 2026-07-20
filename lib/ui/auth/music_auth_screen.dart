import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'widgets/animated_auth_background.dart';

enum _MusicAuthMode { welcome, login, register, forgotPassword }

class MusicAuthScreen extends StatefulWidget {
  const MusicAuthScreen({super.key});

  @override
  State<MusicAuthScreen> createState() => _MusicAuthScreenState();
}

class _MusicAuthScreenState extends State<MusicAuthScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _forgotFormKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmController = TextEditingController();
  final _recoveryEmailController = TextEditingController();

  _MusicAuthMode _mode = _MusicAuthMode.welcome;
  bool _isSubmitting = false;
  bool _agreePersonalData = true;

  AuthService get _authService => Get.find<AuthService>();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmController.dispose();
    _recoveryEmailController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isSubmitting || !(_loginFormKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSubmitting = true);
    final result = await _authService.login(
      email: _loginEmailController.text,
      password: _loginPasswordController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).auth_login_success)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_humanizeError(result['message']?.toString()))),
    );
  }

  Future<void> _handleRegister() async {
    if (_isSubmitting ||
        !(_registerFormKey.currentState?.validate() ?? false) ||
        !_agreePersonalData) {
      return;
    }

    setState(() => _isSubmitting = true);
    final result = await _authService.register(
      username: _usernameController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _registerEmailController.text,
      password: _registerPasswordController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['message']?.toString() ??
              (result['success'] == true
                  ? S.of(context).auth_register_success
                  : S.of(context).auth_register_error),
        ),
      ),
    );

    if (result['success'] == true) {
      setState(() => _mode = _MusicAuthMode.login);
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_isSubmitting || !(_forgotFormKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSubmitting = true);
    final result = await _authService.sendRecoveryEmail(
      email: _recoveryEmailController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['message']?.toString() ??
              (result['success'] == true
                  ? S.of(context).auth_recovery_email_sent
                  : S.of(context).auth_recovery_email_error),
        ),
      ),
    );

    if (result['success'] == true) {
      setState(() => _mode = _MusicAuthMode.login);
    }
  }

  String _humanizeError(String? errorKey) {
    switch (errorKey) {
      case 'AUTH_NOT_CONFIGURED':
        return S.current.auth_error_not_configured;
      case 'INVALID_CREDENTIALS':
        return S.current.auth_error_invalid_credentials;
      case 'ACCOUNT_NOT_VERIFIED':
        return S.current.auth_error_not_verified;
      default:
        return errorKey == null || errorKey.isEmpty
            ? S.current.auth_error_unknown
            : errorKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 940;
          if (isWide) {
            return Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const AnimatedAuthBackground(),
                      Container(color: Colors.black.withValues(alpha: 0.22)),
                      _BrandPanel(isConfigured: _authService.isConfigured),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: _buildSwitcher(isWide: true),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              const AnimatedAuthBackground(),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: _buildSwitcher(isWide: false),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSwitcher({required bool isWide}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _buildCurrentCard(isWide: isWide),
    );
  }

  Widget _buildCurrentCard({required bool isWide}) {
    final card = switch (_mode) {
      _MusicAuthMode.welcome => _WelcomeCard(
          key: const ValueKey('welcome'),
          onLogin: () => setState(() => _mode = _MusicAuthMode.login),
          onRegister: () => setState(() => _mode = _MusicAuthMode.register),
          isConfigured: _authService.isConfigured,
        ),
      _MusicAuthMode.login => _LoginCard(
          key: const ValueKey('login'),
          formKey: _loginFormKey,
          emailController: _loginEmailController,
          passwordController: _loginPasswordController,
          onSubmit: _handleLogin,
          onForgotPassword: () =>
              setState(() => _mode = _MusicAuthMode.forgotPassword),
          onBack: () => setState(() => _mode = _MusicAuthMode.welcome),
          isSubmitting: _isSubmitting,
        ),
      _MusicAuthMode.register => _RegisterCard(
          key: const ValueKey('register'),
          formKey: _registerFormKey,
          usernameController: _usernameController,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          emailController: _registerEmailController,
          passwordController: _registerPasswordController,
          confirmController: _registerConfirmController,
          agreePersonalData: _agreePersonalData,
          onAgreeChanged: (value) =>
              setState(() => _agreePersonalData = value ?? false),
          onSubmit: _handleRegister,
          onBack: () => setState(() => _mode = _MusicAuthMode.welcome),
          isSubmitting: _isSubmitting,
        ),
      _MusicAuthMode.forgotPassword => _ForgotPasswordCard(
          key: const ValueKey('forgot-password'),
          formKey: _forgotFormKey,
          emailController: _recoveryEmailController,
          onSubmit: _handleForgotPassword,
          onBack: () => setState(() => _mode = _MusicAuthMode.login),
          isSubmitting: _isSubmitting,
        ),
    };

    if (isWide) {
      return Container(
        key: ValueKey('wide-${_mode.name}'),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0F2130),
              Color(0xFF14303B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 26,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: card,
      );
    }

    return Container(
      key: ValueKey('mobile-${_mode.name}'),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 26,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: card,
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel({required this.isConfigured});

  final bool isConfigured;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.graphic_eq_rounded,
              color: Colors.white,
              size: 92,
            ),
            const SizedBox(height: 28),
            Text(
              'Estrella Music',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 14),
            Text(
              S.of(context).auth_brand_description_1,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              isConfigured
                  ? S.of(context).auth_brand_description_2
                  : S.of(context).auth_brand_not_configured,
              style: TextStyle(
                color: isConfigured
                    ? const Color(0xFFFFD166)
                    : const Color(0xFFFF8C42),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.isConfigured,
  });

  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final bool isConfigured;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).auth_welcome_title,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          S.of(context).auth_welcome_subtitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        if (!isConfigured)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C42).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFF8C42).withValues(alpha: 0.35),
              ),
            ),
            child: const Text(
              'No se detectó configuración del backend. Revisa el archivo .env antes de iniciar sesión.',
              style: TextStyle(color: Colors.white, height: 1.4),
            ),
          ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF102534),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  S.of(context).auth_btn_login,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: ElevatedButton(
                onPressed: onRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F1C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  S.of(context).auth_btn_register,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.onForgotPassword,
    required this.onBack,
    required this.isSubmitting,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;
  final VoidCallback onBack;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).auth_btn_login,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Usa la misma cuenta del ecosistema que ya te funcionaba.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _AuthTextField(
            controller: emailController,
            label: S.of(context).email,
            hint: S.of(context).auth_hint_email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) {
                return 'Ingresa tu correo.';
              }
              if (text.contains(' ')) {
                return 'El correo no debe llevar espacios.';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
                return 'Ingresa un correo válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _AuthTextField(
            controller: passwordController,
            label: S.of(context).password_text,
            hint: 'Tu contraseña',
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            validator: (value) {
              if ((value ?? '').isEmpty) {
                return 'Ingresa tu contraseña.';
              }
              return null;
            },
          ),
          const SizedBox(height: 22),
          _PrimaryButton(
            label: S.of(context).auth_btn_login,
            loading: isSubmitting,
            onPressed: onSubmit,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: onBack, child: Text(S.of(context).back)),
              TextButton(
                onPressed: onForgotPassword,
                child: Text(S.of(context).auth_forgot_password),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmController,
    required this.agreePersonalData,
    required this.onAgreeChanged,
    required this.onSubmit,
    required this.onBack,
    required this.isSubmitting,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final bool agreePersonalData;
  final ValueChanged<bool?> onAgreeChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).auth_btn_register,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          _AuthTextField(
            controller: usernameController,
            label: S.of(context).username,
            hint: 'tu_usuario',
            icon: Icons.person_outline,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.length < 3) {
                return 'El usuario debe tener al menos 3 caracteres.';
              }
              if (text.contains(' ')) {
                return 'El usuario no debe llevar espacios.';
              }
              if (text.contains('.')) {
                return 'El usuario no debe llevar puntos.';
              }
              if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(text)) {
                return 'Usa solo letras, números o guion bajo.';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _AuthTextField(
            controller: firstNameController,
            label: S.of(context).auth_first_name,
            hint: 'Tu nombre',
            icon: Icons.badge_outlined,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.length < 3) return 'Ingresa tu nombre completo.';
              return null;
            },
          ),
          const SizedBox(height: 14),
          _AuthTextField(
            controller: lastNameController,
            label: S.of(context).auth_last_name,
            hint: 'Tus apellidos',
            icon: Icons.badge_rounded,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.length < 3) return 'Ingresa tus apellidos.';
              return null;
            },
          ),
          const SizedBox(height: 14),
          _AuthTextField(
            controller: emailController,
            label: S.of(context).email,
            hint: S.of(context).auth_hint_email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
                return 'Ingresa un correo válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _AuthTextField(
            controller: passwordController,
            label: S.of(context).password_text,
            hint: 'Crea una contraseña segura',
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            validator: (value) {
              final text = value ?? '';
              if (text.length < 8) return 'Debe tener al menos 8 caracteres.';
              final hasUppercase = text.contains(RegExp(r'[A-Z]'));
              final hasLowercase = text.contains(RegExp(r'[a-z]'));
              final hasNumber = text.contains(RegExp(r'[0-9]'));
              final hasSymbol =
                  text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
              if (!hasUppercase || !hasLowercase || !hasNumber || !hasSymbol) {
                return 'Incluye mayúscula, minúscula, número y símbolo.';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          _AuthTextField(
            controller: confirmController,
            label: S.of(context).auth_confirm_password,
            hint: 'Repite tu contraseña',
            icon: Icons.lock_reset_rounded,
            obscureText: true,
            validator: (value) {
              if ((value ?? '') != passwordController.text) {
                return 'Las contraseñas no coinciden.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: agreePersonalData,
                onChanged: onAgreeChanged,
                activeColor: const Color(0xFFFF9F1C),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    S.of(context).auth_agree_personal_data,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _PrimaryButton(
            label: S.of(context).auth_btn_register,
            loading: isSubmitting,
            onPressed: onSubmit,
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: onBack, child: Text(S.of(context).back)),
        ],
      ),
    );
  }
}

class _ForgotPasswordCard extends StatelessWidget {
  const _ForgotPasswordCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSubmit,
    required this.onBack,
    required this.isSubmitting,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).auth_forgot_password,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).auth_forgot_password_subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _AuthTextField(
            controller: emailController,
            label: S.of(context).email,
            hint: S.of(context).auth_hint_email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              final text = value?.trim() ?? '';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
                return S.of(context).auth_error_invalid_email;
              }
              return null;
            },
          ),
          const SizedBox(height: 22),
          _PrimaryButton(
            label: S.of(context).auth_btn_send_email,
            loading: isSubmitting,
            onPressed: onSubmit,
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: onBack, child: Text(S.of(context).back)),
        ],
      ),
    );
  }
}

class _AuthTextField extends StatefulWidget {
  const _AuthTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  State<_AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<_AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: _obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: Icon(widget.icon, color: Colors.white70),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
              )
            : null,
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.18)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF9F1C)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE71D36)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE71D36)),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9F1C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  key: const ValueKey('label'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
