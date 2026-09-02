import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/generated/l10n.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/music_metadata_editor.dart';
import 'package:estrella_music/ui/screens/Library/library_controller.dart';

class LocalMetadataSearchDialog extends StatefulWidget {
  const LocalMetadataSearchDialog({super.key, required this.song});

  final MediaItem song;

  @override
  State<LocalMetadataSearchDialog> createState() =>
      _LocalMetadataSearchDialogState();
}

class _LocalMetadataSearchDialogState extends State<LocalMetadataSearchDialog> {
  final _queryController = TextEditingController();
  final MusicCatalogService _catalog = Get.find<MusicCatalogService>();
  List<TrackMetadataCandidate> _results = const [];
  bool _loading = true;
  bool _applying = false;
  bool _hasSearched = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _prepareInitialSearch();
  }

  Future<void> _prepareInitialSearch() async {
    try {
      _queryController.text =
          await _catalog.suggestedMetadataQuery(widget.song);
      await _search();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _hasSearched = true;
        _error = error.toString();
      });
    }
  }

  Future<void> _search() async {
    final query = _queryController.text.trim();
    if (query.isEmpty || _applying) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _loading = true;
      _hasSearched = true;
      _error = null;
    });
    try {
      final results = await _catalog.searchTrackMetadata(widget.song, query);
      if (!mounted) return;
      setState(() => _results = results);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _results = const [];
        _error = error.toString();
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _select(TrackMetadataCandidate candidate) async {
    if (_applying) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(candidate.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(candidate.artist),
            if (_known(candidate.album, 'Unknown album')) Text(candidate.album),
            const SizedBox(height: 16),
            Text(S.current.metadataOverwriteWarning),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.current.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(S.current.useThisMetadata),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() {
      _applying = true;
      _error = null;
    });
    try {
      final updated = await _catalog.applyTrackMetadata(widget.song, candidate);
      await _refreshLibrary();
      if (!mounted) return;
      Navigator.pop(context, updated);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _applying = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _refreshLibrary() async {
    if (Get.isRegistered<LibrarySongsController>()) {
      await Get.find<LibrarySongsController>().refreshCollections();
    }
    if (Get.isRegistered<LibraryAlbumsController>()) {
      await Get.find<LibraryAlbumsController>().refreshLib();
    }
    if (Get.isRegistered<LibraryArtistsController>()) {
      await Get.find<LibraryArtistsController>().refreshLib();
    }
  }

  bool _known(String value, String placeholder) =>
      value.trim().isNotEmpty &&
      value.toLowerCase() != placeholder.toLowerCase();

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(S.current.metadataSearchTitle),
      content: SizedBox(
        width: 520,
        height: MediaQuery.sizeOf(context).height * .62,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.current.metadataSearchDescription,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _queryController,
              enabled: !_applying,
              autofocus: false,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: S.current.metadataSearchHint,
                prefixIcon: const Icon(Icons.manage_search),
                suffixIcon: IconButton(
                  tooltip: S.current.search,
                  onPressed: _loading || _applying ? null : _search,
                  icon: const Icon(Icons.search),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (_loading || _applying) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                '${S.current.metadataOperationFailed}\n$_error',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
            const SizedBox(height: 8),
            Expanded(child: _resultList(theme)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _applying ? null : () => Navigator.pop(context),
          child: Text(S.current.close),
        ),
      ],
    );
  }

  Widget _resultList(ThemeData theme) {
    if (_loading && _results.isEmpty) return const SizedBox.shrink();
    if (_results.isEmpty) {
      return Center(
        child: Text(
          _hasSearched && _error == null ? S.current.metadataNoResults : '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge,
        ),
      );
    }
    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final candidate = _results[index];
        final subtitle = [
          candidate.artist,
          if (_known(candidate.album, 'Unknown album')) candidate.album,
          if (candidate.year != null) candidate.year.toString(),
        ].join(' • ');
        return ListTile(
          enabled: !_applying,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: _Artwork(uri: candidate.artworkUri),
          title: Text(candidate.title, maxLines: 1),
          subtitle: Text(subtitle, maxLines: 2),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _select(candidate),
        );
      },
    );
  }
}

class _Artwork extends StatelessWidget {
  const _Artwork({required this.uri});

  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: 52,
      height: 52,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Icon(Icons.music_note),
    );
    if (uri == null || (uri!.scheme != 'http' && uri!.scheme != 'https')) {
      return placeholder;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        uri.toString(),
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}
