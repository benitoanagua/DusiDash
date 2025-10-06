import 'package:flutter/foundation.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  List<T> _items = [];
  bool _isLoading = false;
  String? _error;
  int _page = 1;
  bool _hasMore = true;

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<List<T>> fetchData({int page = 1, Map<String, dynamic>? filters});

  Future<void> loadData({
    Map<String, dynamic>? filters,
    bool refresh = false,
  }) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;

    if (refresh) {
      _page = 1;
      _hasMore = true;
    }

    notifyListeners();

    try {
      final newItems = await fetchData(page: _page, filters: filters);

      if (refresh) {
        _items = newItems;
      } else {
        _items.addAll(newItems);
      }

      _hasMore = newItems.isNotEmpty;
      _page++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore({Map<String, dynamic>? filters}) async {
    if (_isLoading || !_hasMore) return;
    await loadData(filters: filters, refresh: false);
  }

  Future<void> refreshData({Map<String, dynamic>? filters}) async {
    await loadData(filters: filters, refresh: true);
  }

  void addItem(T item) {
    _items.insert(0, item);
    notifyListeners();
  }

  void updateItem(String id, T updatedItem) {
    final index = _items.indexWhere((item) => _getId(item) == id);
    if (index != -1) {
      _items[index] = updatedItem;
      notifyListeners();
    }
  }

  void deleteItem(String id) {
    _items.removeWhere((item) => _getId(item) == id);
    notifyListeners();
  }

  String _getId(T item);

  List<T> search(String query, List<String> searchFields) {
    if (query.isEmpty) return _items;

    return _items.where((item) {
      return searchFields.any((field) {
        final value = _getFieldValue(item, field);
        return value.toString().toLowerCase().contains(query.toLowerCase());
      });
    }).toList();
  }

  dynamic _getFieldValue(T item, String field) {
    try {
      final map = (item as dynamic).toJson();
      return map[field];
    } catch (e) {
      return '';
    }
  }
}
