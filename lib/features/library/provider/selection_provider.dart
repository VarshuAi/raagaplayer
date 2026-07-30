import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectionNotifier extends StateNotifier<Set<String>> {
  SelectionNotifier() : super({});

  void toggleSelection(String id) {
    if (state.contains(id)) {
      state = Set.from(state)..remove(id);
    } else {
      state = Set.from(state)..add(id);
    }
  }

  void selectAll(List<String> ids) {
    state = Set.from(ids);
  }

  void clearSelection() {
    state = {};
  }

  bool isSelected(String id) {
    return state.contains(id);
  }
}

final selectionProvider = StateNotifierProvider<SelectionNotifier, Set<String>>((ref) {
  return SelectionNotifier();
});
