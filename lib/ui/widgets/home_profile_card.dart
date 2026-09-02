import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/ui/profiles/profile_switcher.dart';
import 'package:estrella_music/ui/widgets/qr_server_scanner_dialog.dart';

class HomeProfileCard extends StatelessWidget {
  const HomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileManager>()) return const SizedBox.shrink();

    final profileManager = Get.find<ProfileManager>();
    final providerManager = Get.find<MusicProviderManager>();

    return Obx(() {
      final active = profileManager.activeProfile.value;
      final profiles = profileManager.profiles;
      final registration = active == null
          ? null
          : providerManager.registrationFor(active.providerId);
      final isLocal = registration?.trust == ProviderTrust.local;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLocal
                ? [const Color(0xFF0F4C5C), const Color(0xFF1B2A47)]
                : [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:
                  (isLocal ? const Color(0xFF0F4C5C) : const Color(0xFF4A00E0))
                      .withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      isLocal
                          ? Icons.phone_android_rounded
                          : Icons.cloud_done_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                active?.name ?? 'Perfil Actual',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                (registration?.displayName ?? 'Proveedor')
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isLocal
                              ? 'Reproducción y biblioteca en tu dispositivo'
                              : profileManager.activeProfileMaySync
                                  ? 'Streaming y sincronización autorizada'
                                  : 'Contenido del proveedor seleccionado',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Crear perfil',
                    icon: const Icon(Icons.add_circle_outline_rounded,
                        color: Colors.white, size: 26),
                    onPressed: () => _showCreateProfileDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 10),
              // List of profiles to easily switch
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: profiles.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == profiles.length) {
                      return ActionChip(
                        avatar: const Icon(Icons.add_rounded,
                            size: 16, color: Colors.white70),
                        label: const Text('Nuevo',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        backgroundColor: Colors.white.withValues(alpha: 0.12),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () => _showCreateProfileDialog(context),
                      );
                    }

                    final profile = profiles[index];
                    final isCurrent = profile.id == active?.id;

                    return ChoiceChip(
                      selected: isCurrent,
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      showCheckmark: false,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      avatar: Icon(
                        providerManager
                                    .registrationFor(profile.providerId)
                                    ?.trust ==
                                ProviderTrust.local
                            ? Icons.folder_rounded
                            : Icons.cloud_rounded,
                        size: 16,
                        color: isCurrent
                            ? const Color(0xFF14213D)
                            : Colors.white70,
                      ),
                      label: Text(
                        profile.name,
                        style: TextStyle(
                          color: isCurrent
                              ? const Color(0xFF14213D)
                              : Colors.white,
                          fontSize: 12.5,
                          fontWeight:
                              isCurrent ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                      onSelected: (selected) async {
                        if (!isCurrent) {
                          try {
                            await profileManager.switchProfile(profile.id);
                            await ProfileSwitcher.refreshActiveContext();
                          } catch (e) {
                            Get.snackbar('Perfil', 'No se pudo cambiar: $e');
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showCreateProfileDialog(BuildContext context) {
    final providerManager = Get.find<MusicProviderManager>();
    final profileManager = Get.find<ProfileManager>();
    final nameController = TextEditingController();
    final serverUrlController = TextEditingController();
    var selectedProvider = providerManager.localProviderId;
    String? folder;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          final isLocal =
              providerManager.registrationFor(selectedProvider)?.trust ==
                  ProviderTrust.local;
          return AlertDialog(
            backgroundColor: const Color(0xFF0F1E28),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.person_add_alt_1_rounded, color: Color(0xFFFF9F1C)),
                SizedBox(width: 10),
                Text('Crear Perfil Musical',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nombre del perfil',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xFF182836),
                    initialValue: selectedProvider,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Proveedor',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: [
                      for (final id in providerManager.availableProviderIds)
                        DropdownMenuItem(
                          value: id,
                          child: Text(
                            providerManager.registrationFor(id)?.displayName ??
                                id,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedProvider = val);
                    },
                  ),
                  if (isLocal) ...[
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final selected =
                            await FilePicker.platform.getDirectoryPath();
                        if (selected != null) {
                          setState(() => folder = selected);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      icon: const Icon(Icons.folder_open_rounded),
                      label: Text(folder ?? 'Carpeta personalizada (opcional)',
                          overflow: TextOverflow.ellipsis),
                    ),
                  ] else ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: serverUrlController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'URL del servidor (opcional)',
                              hintText: 'https://tu-servidor-o-receta.com',
                              hintStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.3)),
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              prefixIcon: const Icon(Icons.link_rounded,
                                  color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.06),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9F1C)
                                .withValues(alpha: 0.2),
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          tooltip: 'Escanear QR de servidor',
                          icon: const Icon(Icons.qr_code_scanner_rounded,
                              color: Color(0xFFFF9F1C)),
                          onPressed: () async {
                            final scanned =
                                await QrServerScannerDialog.scan(context);
                            if (scanned != null && scanned.isNotEmpty) {
                              setState(
                                  () => serverUrlController.text = scanned);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9F1C).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Aviso: Las reproducciones externas no nos hacemos responsables de cómo se usen.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFFFF9F1C),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.white60)),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F1C),
                ),
                onPressed: () async {
                  final name = nameController.text.trim();
                  final serverUrl = serverUrlController.text.trim();
                  Navigator.of(ctx).pop();
                  await profileManager.createProfile(
                    name: name.isEmpty ? 'Nuevo Perfil' : name,
                    providerId: selectedProvider,
                    settings: {
                      if (folder != null && isLocal) 'libraryRoots': [folder],
                      if (!isLocal && serverUrl.isNotEmpty)
                        'serverUrl': serverUrl,
                    },
                  );
                  await ProfileSwitcher.refreshActiveContext();
                },
                child: const Text('Crear y Activar',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}
