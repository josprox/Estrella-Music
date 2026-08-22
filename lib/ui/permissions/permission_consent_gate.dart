import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/services/system/fcm_notification_service.dart';
import 'package:harmonymusic/services/system/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionConsentGate extends StatefulWidget {
  const PermissionConsentGate({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<PermissionConsentGate> createState() => _PermissionConsentGateState();
}

class _PermissionConsentGateState extends State<PermissionConsentGate>
    with WidgetsBindingObserver {
  RequiredPermissionStatus? _status;
  bool _requesting = false;
  bool _startedNotifications = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshPermissions();
    }
  }

  Future<void> _refreshPermissions() async {
    final status = await PermissionService.requiredPermissionStatus();
    if (!mounted) return;
    setState(() => _status = status);
    if (status.allGranted && !_startedNotifications) {
      _startedNotifications = true;
      unawaited(FcmNotificationService.initialize());
    }
  }

  Future<void> _requestPermission(RequiredAppPermission permission) async {
    if (_requesting) return;
    setState(() => _requesting = true);
    try {
      final current = _status?.statusOf(permission);
      if (current?.isPermanentlyDenied == true ||
          current?.isRestricted == true) {
        await openAppSettings();
      } else {
        await PermissionService.request(permission);
      }
    } finally {
      await _refreshPermissions();
      if (mounted) setState(() => _requesting = false);
    }
  }

  Future<void> _requestMissingPermissions() async {
    if (_requesting) return;
    setState(() => _requesting = true);
    try {
      var status = await PermissionService.requiredPermissionStatus();
      for (final permission in RequiredAppPermission.values) {
        final permissionStatus = status.statusOf(permission);
        if (permissionStatus.isGranted) continue;
        if (permissionStatus.isPermanentlyDenied ||
            permissionStatus.isRestricted) {
          await openAppSettings();
          break;
        }
        await PermissionService.request(permission);
        status = await PermissionService.requiredPermissionStatus();
        if (!status.statusOf(permission).isGranted) break;
      }
    } finally {
      await _refreshPermissions();
      if (mounted) setState(() => _requesting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!GetPlatform.isAndroid && !GetPlatform.isIOS) return widget.child;

    final status = _status;
    if (status?.allGranted == true) return widget.child;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.privacy_tip_rounded,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.current.permissionsConsentTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.current.permissionsConsentDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 28),
                  _PermissionCard(
                    icon: Icons.folder_rounded,
                    title: S.current.permissionsStorageTitle,
                    description: S.current.permissionsStorageDescription,
                    status: status?.storage,
                    onPressed: () =>
                        _requestPermission(RequiredAppPermission.storage),
                  ),
                  const SizedBox(height: 12),
                  _PermissionCard(
                    icon: Icons.notifications_rounded,
                    title: S.current.permissionsNotificationsTitle,
                    description: S.current.permissionsNotificationsDescription,
                    status: status?.notifications,
                    onPressed: () =>
                        _requestPermission(RequiredAppPermission.notifications),
                  ),
                  const SizedBox(height: 12),
                  _PermissionCard(
                    icon: Icons.mic_rounded,
                    title: S.current.permissionsMicrophoneTitle,
                    description: S.current.permissionsMicrophoneDescription,
                    status: status?.microphone,
                    onPressed: () =>
                        _requestPermission(RequiredAppPermission.microphone),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _requesting ? null : _requestMissingPermissions,
                    icon: _requesting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_circle_rounded),
                    label: Text(S.current.permissionsContinueButton),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.current.permissionsRequiredNotice,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.status,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final PermissionStatus? status;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final granted = status?.isGranted == true;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(description),
        ),
        trailing: granted
            ? Icon(Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.primary)
            : TextButton(
                onPressed: onPressed,
                child: Text(
                  status?.isPermanentlyDenied == true
                      ? S.current.permissionsOpenSettings
                      : S.current.permissionsAllow,
                ),
              ),
      ),
    );
  }
}
