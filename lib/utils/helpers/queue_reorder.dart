class QueueReorderResult<T> {
  const QueueReorderResult({
    required this.items,
    required this.currentIndex,
  });

  final List<T> items;
  final int currentIndex;
}

/// Applies Flutter's [ReorderableListView] index semantics without losing the
/// identity of the item that is currently playing.
QueueReorderResult<T> reorderQueue<T>({
  required List<T> items,
  required int oldIndex,
  required int newIndex,
  required int currentIndex,
}) {
  if (oldIndex < 0 ||
      oldIndex >= items.length ||
      newIndex < 0 ||
      newIndex > items.length ||
      currentIndex < 0 ||
      currentIndex >= items.length) {
    return QueueReorderResult<T>(
      items: List<T>.from(items),
      currentIndex: currentIndex,
    );
  }

  var insertionIndex = newIndex;
  if (oldIndex < insertionIndex) {
    insertionIndex--;
  }

  final reordered = List<T>.from(items);
  final movedItem = reordered.removeAt(oldIndex);
  reordered.insert(insertionIndex, movedItem);

  var updatedCurrentIndex = currentIndex;
  if (currentIndex == oldIndex) {
    updatedCurrentIndex = insertionIndex;
  } else if (oldIndex < currentIndex && insertionIndex >= currentIndex) {
    updatedCurrentIndex--;
  } else if (oldIndex > currentIndex && insertionIndex <= currentIndex) {
    updatedCurrentIndex++;
  }

  return QueueReorderResult<T>(
    items: reordered,
    currentIndex: updatedCurrentIndex,
  );
}
