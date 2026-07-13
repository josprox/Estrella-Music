import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_marquee.dart';

import 'package:harmonymusic/services/social/piped_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import '/ui/widgets/snackbar.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'common_dialog_widget.dart';
import 'modified_text_field.dart';
import 'package:harmonymusic/generated/l10n.dart';

class CreateNRenamePlaylistPopup extends StatefulWidget {
  const CreateNRenamePlaylistPopup({
    super.key,
    this.isCreateNadd = false,
    this.songItems,
    this.renamePlaylist = false,
    this.playlist,
  });

  final bool isCreateNadd;
  final bool renamePlaylist;
  final List<MediaItem>? songItems;
  final Playlist? playlist;

  @override
  State<CreateNRenamePlaylistPopup> createState() => _CreateNRenamePlaylistPopupState();
}

class _CreateNRenamePlaylistPopupState extends State<CreateNRenamePlaylistPopup> {
  bool _isCollaborative = false;
  final List<dynamic> _selectedFriends = [];
  late Future<List<Map<String, dynamic>>> _friendsFuture;

  @override
  void initState() {
    super.initState();
    final syncService = Get.find<SyncService>();
    _friendsFuture = syncService.fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    final librPlstCntrller = Get.find<LibraryPlaylistsController>();
    librPlstCntrller.changeCreationMode("local");
    librPlstCntrller.textInputController.text = "";
    final isPipedLinked = Get.find<PipedServices>().isLoggedIn;
    final isCloudMode = Get.find<SyncService>().isCloudMode;

    return CommonDialog(
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Marquee(
                  delay: const Duration(milliseconds: 300),
                  id: "createPlaylist",
                  child: Text(
                    widget.renamePlaylist
                        ? S.current.renamePlaylist
                        : S.current.CreateNewPlaylist,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              if (isPipedLinked && !widget.renamePlaylist)
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "piped",
                            // ignore: deprecated_member_use
                            groupValue: librPlstCntrller.playlistCreationMode.value,
                            // ignore: deprecated_member_use
                            onChanged: librPlstCntrller.changeCreationMode,
                          ),
                          Text(S.current.Piped),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          Radio(
                            value: "local",
                            // ignore: deprecated_member_use
                            groupValue: librPlstCntrller.playlistCreationMode.value,
                            // ignore: deprecated_member_use
                            onChanged: librPlstCntrller.changeCreationMode,
                          ),
                          Text(S.current.local),
                        ],
                      )
                    ],
                  ),
                ),
              
              ModifiedTextField(
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                cursorColor: Theme.of(context).textTheme.titleSmall!.color,
                controller: librPlstCntrller.textInputController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  focusColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Collaborative Playlist Option
              if (isCloudMode && !widget.renamePlaylist) ...[
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    "Playlist Colaborativa (Amigos)",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Tus amigos seleccionados podrán ver y editar esta playlist",
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _isCollaborative,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _isCollaborative = val ?? false;
                    });
                  },
                ),
                if (_isCollaborative)
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _friendsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "No tienes amigos agregados aún para colaborar.",
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        );
                      }
                      final friends = snapshot.data!;
                      final double containerHeight = (friends.length * 50.0).clamp(50.0, 120.0);
                      return Container(
                        height: containerHeight,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var friend in friends) ...[
                                (() {
                                  final friendId = friend['id'] ?? friend['username'];
                                  final friendName = friend['name'] ?? friend['username'] ?? 'Amigo';
                                  final isChecked = _selectedFriends.any((c) => (c is Map ? c['id'] : c) == friendId);
                                  return CheckboxListTile(
                                    dense: true,
                                    title: Text(friendName.toString()),
                                    value: isChecked,
                                    onChanged: (selected) {
                                      setState(() {
                                        if (selected == true) {
                                          _selectedFriends.add({
                                            'id': friend['id'],
                                            'username': friend['username'],
                                            'first_name': friend['first_name'] ?? '',
                                            'last_name': friend['last_name'] ?? '',
                                          });
                                        } else {
                                          _selectedFriends.removeWhere((c) => (c is Map ? c['id'] : c) == friendId);
                                        }
                                      });
                                    },
                                  );
                                }()),
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(S.current.cancel),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                        child: Text(
                          widget.isCreateNadd
                              ? S.current.createnAdd
                              : widget.renamePlaylist
                                  ? S.current.rename
                                  : S.current.create,
                          style: TextStyle(color: Theme.of(context).canvasColor),
                        ),
                      ),
                      onTap: () async {
                        if (widget.renamePlaylist) {
                          librPlstCntrller.renamePlaylist(widget.playlist!).then((value) {
                            if (value) {
                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackbar(context, S.current.playlistRenameAlert, size: SanckBarSize.MEDIUM),
                              );
                            }
                          });
                        } else {
                          librPlstCntrller
                              .createNewPlaylist(
                                createPlaylistNaddSong: widget.isCreateNadd,
                                songItems: widget.songItems,
                                isCollaborative: _isCollaborative,
                                collaborators: _selectedFriends,
                              )
                              .then((value) {
                            if (!context.mounted) return;
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackbar(
                                  context,
                                  widget.isCreateNadd
                                      ? S.current.playlistCreatednsongAddedAlert
                                      : S.current.playlistCreatedAlert,
                                  size: SanckBarSize.MEDIUM,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackbar(context, S.current.errorOccuredAlert, size: SanckBarSize.MEDIUM),
                              );
                            }
                            Navigator.of(context).pop();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
