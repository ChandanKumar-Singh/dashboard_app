import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';

class RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [ApprovalStore]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<ApprovalStore> desserts) {
    final updatedSet = <int>{};
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (dessert.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

int _idCounter = 0;

/// Domain model entity
class ApprovalStore {
  ApprovalStore(
    this.profilePic,
    this.storeName,
    this.city,
    this.mobile,
    this.email,
    this.adminShare,
    this.ownerName,
    this.iron,
  );

  final int id = _idCounter++;

  final String profilePic;
  final int storeName;
  final double city;
  final int mobile;
  final double email;
  final int adminShare;
  final int ownerName;
  final int iron;
  bool selected = false;
}

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class DessertDataSource extends DataTableSource {
  DessertDataSource.empty(this.context) {
    desserts = [];
  }

  DessertDataSource(this.context,
      [sortedByCalories = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]) {
    desserts = stores;
    if (sortedByCalories) {
      sort((d) => d.storeName, true);
    }
  }

  final BuildContext context;
  late List<ApprovalStore> desserts;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(ApprovalStore d) getField, bool ascending) {
    desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void updateSelectedDesserts(RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= desserts.length) throw 'index > _desserts.length';
    final dessert = desserts[index];
    return DataRow2.byIndex(
      index: index,
      selected: dessert.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${dessert.profilePic}')
          : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(
              context, 'Double Tapped on row ${dessert.profilePic}')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(
              context, 'Long pressed on row ${dessert.profilePic}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(
              context, 'Right clicked on row ${dessert.profilePic}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) => _showSnackbar(
              context, 'Right button down on row ${dessert.profilePic}')
          : null,
      specificRowHeight:
          hasRowHeightOverrides && dessert.city >= 25 ? 100 : null,
      cells: [
        DataCell(Text(dessert.profilePic)),
        DataCell(Text('${dessert.storeName}'),
            onTap: () => _showSnackbar(context,
                'Tapped on a cell with "${dessert.storeName}"', Colors.red)),
        DataCell(Text(dessert.city.toStringAsFixed(1))),
        DataCell(Text('${dessert.mobile}')),
        DataCell(Text(dessert.email.toStringAsFixed(1))),
        DataCell(Text('${dessert.adminShare}')),
        DataCell(Text(format.format(dessert.ownerName / 100))),
        DataCell(Text(format.format(dessert.iron / 100))),
      ],
    );
  }

  @override
  int get rowCount => desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final dessert in desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? desserts.length : 0;
    notifyListeners();
  }
}

/// Async datasource for AsynPaginatedDataTabke2 example. Based on AsyncDataTableSource which
/// is an extension to FLutter's DataTableSource and aimed at solving
/// saync data fetching scenarious by paginated table (such as using Web API)
class StoreListApprovalSourceAsync extends AsyncDataTableSource {
  StoreListApprovalSourceAsync() {
    print('DessertDataSourceAsync created');
  }

  StoreListApprovalSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  StoreListApprovalSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;
  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final StoreListApprovalService _repo = StoreListApprovalService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  Future<int> getTotalRecords() {
    return Future<int>.delayed(
        const Duration(milliseconds: 0), () => _empty ? 0 : _dessertsX3.length);
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    print('getRows($startIndex, $count)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    final format =
        NumberFormat.decimalPercentPattern(locale: 'en', decimalDigits: 0);
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var x = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => StoreListApprovalServiceResponse(0, []))
        : await _repo.getData(
            startIndex, count, _caloriesFilter, _sortColumn, _sortAscending);

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((store) {
          return DataRow(
            key: ValueKey<int>(store.id),
            selected: store.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<int>(store.id), value);
              }
            },
            cells: [
              DataCell(Text(store.id.toString())),
              DataCell(Text(store.profilePic)),
              DataCell(Text('${store.storeName}')),
              DataCell(Text(store.city.toStringAsFixed(1))),
              DataCell(Text('${store.mobile}')),
              DataCell(Text(store.email.toStringAsFixed(1))),
              DataCell(Text('${store.adminShare}')),
              DataCell(Text(format.format(store.ownerName / 100))),
              // DataCell(Text(format.format(store.iron / 100))),
            ],
          );
        }).toList());

    return r;
  }
}

class StoreListApprovalServiceResponse {
  StoreListApprovalServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<ApprovalStore> data;
}

class StoreListApprovalService {
  int Function(ApprovalStore, ApprovalStore)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      case '#':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.id.toString().compareTo(d2.id.toString()));
      case 'profile pic':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.profilePic.compareTo(d2.profilePic));
      // case 'profile pic':
      //  return (ApprovalStore d1, ApprovalStore d2) => coef * (d1.storeName - d2.storeName);
      case 'store name':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.storeName - d2.storeName);
      case 'city':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.city - d2.city).round();
      case 'mobile':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.mobile - d2.mobile).round();
      case 'email':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.email - d2.email).round();
      case 'admin share':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.adminShare - d2.adminShare);
      case 'owner name':
        return (ApprovalStore d1, ApprovalStore d2) =>
            coef * (d1.ownerName - d2.ownerName);
    }

    return null;
  }

  Future<StoreListApprovalServiceResponse> getData(int startingAt, int count,
      RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 2650
                : startingAt < 20
                    ? 2000
                    : 400), () {
      var result = _dessertsX3;
      if (caloriesFilter != null) {
        result = result
            .where((e) =>
                e.storeName >= caloriesFilter.start &&
                e.storeName <= caloriesFilter.end)
            .toList();
      }

      try {
        result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      } catch (e) {
        print(e);
      }
      print(result);

      return StoreListApprovalServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;

List<ApprovalStore> stores = <ApprovalStore>[
  ApprovalStore(
    'Frozen Yogurt',
    159,
    6.0,
    24,
    4.0,
    87,
    14,
    1,
  ),
  ApprovalStore(
    'Ice Cream Sandwich',
    237,
    9.0,
    37,
    4.3,
    129,
    8,
    1,
  ),
  ApprovalStore(
    'Eclair',
    262,
    16.0,
    24,
    6.0,
    337,
    6,
    7,
  ),
  ApprovalStore(
    'Cupcake',
    305,
    3.7,
    67,
    4.3,
    413,
    3,
    8,
  ),
  ApprovalStore(
    'Gingerbread',
    356,
    16.0,
    49,
    3.9,
    327,
    7,
    16,
  ),
  ApprovalStore(
    'Jelly Bean',
    375,
    0.0,
    94,
    0.0,
    50,
    0,
    0,
  ),
  ApprovalStore(
    'Lollipop',
    392,
    0.2,
    98,
    0.0,
    38,
    0,
    2,
  ),
  ApprovalStore(
    'Honeycomb',
    408,
    3.2,
    87,
    6.5,
    562,
    0,
    45,
  ),
  ApprovalStore(
    'Donut',
    452,
    25.0,
    51,
    4.9,
    326,
    2,
    22,
  ),
  ApprovalStore(
    'Apple Pie',
    518,
    26.0,
    65,
    7.0,
    54,
    12,
    6,
  ),
  ApprovalStore(
    'Frozen Yougurt with sugar',
    168,
    6.0,
    26,
    4.0,
    87,
    14,
    1,
  ),
  ApprovalStore(
    'Ice Cream Sandich with sugar',
    246,
    9.0,
    39,
    4.3,
    129,
    8,
    1,
  ),
  ApprovalStore(
    'Eclair with sugar',
    271,
    16.0,
    26,
    6.0,
    337,
    6,
    7,
  ),
  ApprovalStore(
    'Cupcake with sugar',
    314,
    3.7,
    69,
    4.3,
    413,
    3,
    8,
  ),
  ApprovalStore(
    'Gingerbread with sugar',
    345,
    16.0,
    51,
    3.9,
    327,
    7,
    16,
  ),
  ApprovalStore(
    'Jelly Bean with sugar',
    364,
    0.0,
    96,
    0.0,
    50,
    0,
    0,
  ),
  ApprovalStore(
    'Lollipop with sugar',
    401,
    0.2,
    100,
    0.0,
    38,
    0,
    2,
  ),
  ApprovalStore(
    'Honeycomd with sugar',
    417,
    3.2,
    89,
    6.5,
    562,
    0,
    45,
  ),
  ApprovalStore(
    'Donut with sugar',
    461,
    25.0,
    53,
    4.9,
    326,
    2,
    22,
  ),
  ApprovalStore(
    'Apple pie with sugar',
    527,
    26.0,
    67,
    7.0,
    54,
    12,
    6,
  ),
  ApprovalStore(
    'Forzen yougurt with honey',
    223,
    6.0,
    36,
    4.0,
    87,
    14,
    1,
  ),
  ApprovalStore(
    'Ice Cream Sandwich with honey',
    301,
    9.0,
    49,
    4.3,
    129,
    8,
    1,
  ),
  ApprovalStore(
    'Eclair with honey',
    326,
    16.0,
    36,
    6.0,
    337,
    6,
    7,
  ),
  ApprovalStore(
    'Cupcake with honey',
    369,
    3.7,
    79,
    4.3,
    413,
    3,
    8,
  ),
  ApprovalStore(
    'Gignerbread with hone',
    420,
    16.0,
    61,
    3.9,
    327,
    7,
    16,
  ),
  ApprovalStore(
    'Jelly Bean with honey',
    439,
    0.0,
    106,
    0.0,
    50,
    0,
    0,
  ),
  ApprovalStore(
    'Lollipop with honey',
    456,
    0.2,
    110,
    0.0,
    38,
    0,
    2,
  ),
  ApprovalStore(
    'Honeycomd with honey',
    472,
    3.2,
    99,
    6.5,
    562,
    0,
    45,
  ),
  ApprovalStore(
    'Donut with honey',
    516,
    25.0,
    63,
    4.9,
    326,
    2,
    22,
  ),
  ApprovalStore(
    'Apple pie with honey',
    582,
    26.0,
    77,
    7.0,
    54,
    12,
    6,
  ),
];

List<ApprovalStore> _dessertsX3 = stores.toList()
  ..addAll(stores.map((i) => ApprovalStore('${i.profilePic} x2', i.storeName,
      i.city, i.mobile, i.email, i.adminShare, i.ownerName, i.iron)))
  ..addAll(stores.map((i) => ApprovalStore('${i.profilePic} x3', i.storeName,
      i.city, i.mobile, i.email, i.adminShare, i.ownerName, i.iron)));

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
