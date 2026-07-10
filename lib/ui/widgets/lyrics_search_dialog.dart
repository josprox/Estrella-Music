import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/services/music/lyrics_providers.dart';
import 'package:harmonymusic/services/music/synced_lyrics_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

class LyricsSearchDialog extends StatefulWidget {
  const LyricsSearchDialog({super.key});

  @override
  State<LyricsSearchDialog> createState() => _LyricsSearchDialogState();
}

class _LyricsSearchDialogState extends State<LyricsSearchDialog> {
  final PlayerController _playerController = Get.find<PlayerController>();
  late final TextEditingController _titleController;
  late final TextEditingController _artistController;

  bool _isLoading = false;
  List<LyricsSearchResult> _results = [];
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    final currentSong = _playerController.currentSong.value;
    _titleController = TextEditingController(text: currentSong?.title ?? "");
    _artistController = TextEditingController(text: currentSong?.artist ?? "");
    
    // Auto trigger search on open
    if (_titleController.text.isNotEmpty) {
      _performSearch();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
      _results = [];
      _expandedIndex = -1;
    });

    try {
      final results = await SyncedLyricsService.searchManual(
        "",
        trackName: _titleController.text.trim(),
        artistName: _artistController.text.trim(),
        duration: _playerController.progressBarStatus.value.total.inSeconds,
        album: _playerController.currentSong.value?.album,
      );
      setState(() {
        _results = results;
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to search lyrics: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectResult(LyricsSearchResult result) async {
    final songId = _playerController.currentSong.value?.id;
    if (songId == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final lyricsData = await SyncedLyricsService.saveManualLyrics(
        songId,
        result.lyrics,
        result.isSynced,
      );
      
      // Update lyrics in controller
      _playerController.lyrics.value = lyricsData;
      _playerController.lyrics.refresh();
      
      Get.back(); // Close dialog
      Get.snackbar(
        "Lyrics Updated",
        "Successfully selected lyrics from ${result.providerName}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save lyrics: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: isDark ? const Color(0xFF1E1E2E) : Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 650),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lyrics_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  "Buscar Letras",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Search Input Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Título",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _artistController,
                    decoration: const InputDecoration(
                      labelText: "Artista",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _isLoading ? null : _performSearch,
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Search Results or Loading
            Expanded(
              child: _isLoading && _results.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _results.isEmpty
                      ? Center(
                          child: Text(
                            _isLoading ? "Buscando..." : "No se encontraron letras",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _results.length,
                          separatorBuilder: (context, index) => Divider(
                            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          ),
                          itemBuilder: (context, index) {
                            final result = _results[index];
                            final isExpanded = index == _expandedIndex;
                            return Card(
                              elevation: 0,
                              color: isDark
                                  ? const Color(0xFF2E2E3E)
                                  : theme.colorScheme.surfaceContainerLow,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.zero,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => _selectResult(result),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result.trackName,
                                                  style: theme.textTheme.titleMedium?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  result.artistName,
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.onSurfaceVariant,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Chip(
                                                label: Text(result.providerName),
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity.compact,
                                                backgroundColor: theme.colorScheme.primaryContainer,
                                                labelStyle: theme.textTheme.labelSmall?.copyWith(
                                                  color: theme.colorScheme.onPrimaryContainer,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    result.isSynced
                                                        ? Icons.sync_rounded
                                                        : Icons.text_snippet_rounded,
                                                    size: 16,
                                                    color: theme.colorScheme.secondary,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    result.isSynced ? "Sincronizada" : "Texto Plano",
                                                    style: theme.textTheme.labelSmall?.copyWith(
                                                      color: theme.colorScheme.secondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              isExpanded
                                                  ? Icons.expand_less_rounded
                                                  : Icons.expand_more_rounded,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _expandedIndex = isExpanded ? -1 : index;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      if (isExpanded) ...[
                                        const SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? const Color(0xFF1E1E2E)
                                                : theme.colorScheme.surfaceContainerLowest,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          constraints: const BoxConstraints(maxHeight: 150),
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: Text(
                                              result.lyrics,
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                fontFamily: 'monospace',
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: FilledButton.tonal(
                                            onPressed: () => _selectResult(result),
                                            child: const Text("Seleccionar Letra"),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 16),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(S.current.cancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
