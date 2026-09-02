import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/profiles/music_profile.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';
import 'package:estrella_music/ui/screens/Library/library_controller.dart';
import 'package:estrella_music/ui/widgets/qr_server_scanner_dialog.dart';

class ProfileSwitcher extends StatelessWidget {
  const ProfileSwitcher({super.key, this.expanded = true});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final manager = Get.find<ProfileManager>();
    return Obx(() {
      final active = manager.activeProfile.value;
      return PopupMenuButton<String>(
        tooltip: 'Cambiar perfil musical',
        onSelected: (value) async {
          if (value == '__manage__') {
            await showDialog<void>(
              context: context,
              builder: (_) => const _ManageProfilesDialog(),
            );
            return;
          }
          try {
            await manager.switchProfile(value);
            await refreshActiveContext();
          } catch (error) {
            Get.snackbar('Perfil no disponible', error.toString());
          }
        },
        itemBuilder: (_) => [
          for (final profile in manager.profiles)
            PopupMenuItem(
              value: profile.id,
              child: Row(
                children: [
                  Icon(
                    profile.id == active?.id
                        ? Icons.check_rounded
                        : profile.availability ==
                                MusicProfileAvailability.available
                            ? Icons.music_note_rounded
                            : Icons.error_outline_rounded,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(profile.name)),
                ],
              ),
            ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: '__manage__',
            child: Row(
              children: [
                Icon(Icons.manage_accounts_outlined, size: 20),
                SizedBox(width: 10),
                Text('Administrar perfiles'),
              ],
            ),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.library_music_rounded, size: 20),
              if (expanded) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    active?.name ?? 'Local',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down_rounded),
              ],
            ],
          ),
        ),
      );
    });
  }

  static Future<void> refreshActiveContext() async {
    if (Get.isRegistered<HomeScreenController>()) {
      final homeCtrl = Get.find<HomeScreenController>();
      homeCtrl.isContentFetched.value = false;
      await homeCtrl.loadContent(forceRefresh: true);
      await homeCtrl.loadLocalCustomSections();
      unawaited(homeCtrl.reloadRecommendations(force: true));
    }
    if (Get.isRegistered<LibrarySongsController>()) {
      await Get.find<LibrarySongsController>().refreshCollections();
    }
    if (Get.isRegistered<LibraryPlaylistsController>()) {
      Get.find<LibraryPlaylistsController>().refreshLib();
    }
    if (Get.isRegistered<LibraryAlbumsController>()) {
      await Get.find<LibraryAlbumsController>().refreshLib();
    }
    if (Get.isRegistered<LibraryArtistsController>()) {
      await Get.find<LibraryArtistsController>().refreshLib();
    }
  }
}

class _ManageProfilesDialog extends StatelessWidget {
  const _ManageProfilesDialog();

  @override
  Widget build(BuildContext context) {
    final manager = Get.find<ProfileManager>();
    return AlertDialog(
      title: const Text('Perfiles musicales'),
      content: SizedBox(
        width: 480,
        child: Obx(() => ListView(
              shrinkWrap: true,
              children: [
                for (final profile in manager.profiles)
                  ListTile(
                    leading: Icon(
                      profile.availability == MusicProfileAvailability.available
                          ? Icons.account_circle_outlined
                          : Icons.error_outline_rounded,
                    ),
                    title: Text(profile.name),
                    subtitle: Text(
                      profile.errorMessage ?? profile.providerId,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Renombrar',
                          onPressed: () => _rename(context, profile),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        if (!profile.isFallback)
                          IconButton(
                            tooltip: 'Eliminar',
                            onPressed: () => manager.deleteProfile(profile.id),
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                      ],
                    ),
                  ),
              ],
            )),
      ),
      actions: [
        TextButton(
          onPressed: () => _create(context),
          child: const Text('Crear perfil'),
        ),
        FilledButton(onPressed: Get.back, child: const Text('Listo')),
      ],
    );
  }

  Future<void> _rename(BuildContext context, MusicProfile profile) async {
    final controller = TextEditingController(text: profile.name);
    final name = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Renombrar perfil'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Get.back(result: controller.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name != null && name.trim().isNotEmpty) {
      await Get.find<ProfileManager>().renameProfile(profile.id, name);
    }
  }

  Future<void> _create(BuildContext context) async {
    final providerManager = Get.find<MusicProviderManager>();
    final profileManager = Get.find<ProfileManager>();
    final controller = TextEditingController();
    final serverUrlController = TextEditingController();
    var providerId = providerManager.localProviderId;
    String? libraryFolder;
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
        final isLocal = providerManager.registrationFor(providerId)?.trust ==
            ProviderTrust.local;
        return AlertDialog(
          title: const Text('Crear perfil musical'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: providerId,
                  decoration: const InputDecoration(labelText: 'Proveedor'),
                  items: [
                    for (final id in providerManager.availableProviderIds)
                      DropdownMenuItem(
                        value: id,
                        child: Text(
                            providerManager.registrationFor(id)?.displayName ??
                                id),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => providerId = value ?? providerId),
                ),
                if (isLocal) ...[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final selected =
                          await FilePicker.platform.getDirectoryPath();
                      if (selected != null) {
                        setState(() => libraryFolder = selected);
                      }
                    },
                    icon: const Icon(Icons.folder_open_rounded),
                    label: Text(libraryFolder ?? 'Elegir carpeta de música'),
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: serverUrlController,
                          decoration: const InputDecoration(
                            labelText: 'URL del servidor (opcional)',
                            hintText: 'https://tu-servidor-o-receta.com',
                            prefixIcon: Icon(Icons.link_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        tooltip: 'Escanear QR de servidor',
                        icon: const Icon(Icons.qr_code_scanner_rounded),
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
                      color: Colors.amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Aviso: Las reproducciones externas no nos hacemos responsables de cómo se usen.',
                      style: TextStyle(fontSize: 11.5, color: Colors.amber),
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: Get.back, child: const Text('Cancelar')),
            FilledButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Crear'),
            ),
          ],
        );
      }),
    );
    final name = controller.text.trim();
    final serverUrl = serverUrlController.text.trim();
    controller.dispose();
    serverUrlController.dispose();
    if (created == true) {
      await profileManager.createProfile(
        name: name.isEmpty ? 'Nuevo perfil' : name,
        providerId: providerId,
        settings: {
          if (libraryFolder != null) 'libraryRoots': [libraryFolder],
          if (serverUrl.isNotEmpty) 'serverUrl': serverUrl,
        },
      );
    }
  }
}
