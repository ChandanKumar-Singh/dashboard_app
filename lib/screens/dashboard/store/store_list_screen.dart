import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../responsive.dart';
import '../../../utils/logger.dart';
import '../../../utils/picture_utils.dart';
import '../../../utils/text.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/utils/sizedbox_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants.dart';

import '../components/profile/profile_header.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({super.key});

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const CommonHeader(),
                const SizedBox(height: defaultPadding),
                Expanded(child: _StoreApprovalAsyncPaginatedDataTable2())
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StoreApprovalAsyncPaginatedDataTable2 extends StatefulWidget {
  const _StoreApprovalAsyncPaginatedDataTable2({super.key});

  @override
  _StoreApprovalAsyncPaginatedDataTable2State createState() =>
      _StoreApprovalAsyncPaginatedDataTable2State();
}

class _StoreApprovalAsyncPaginatedDataTable2State
    extends State<_StoreApprovalAsyncPaginatedDataTable2> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  _StoreListApprovalSourceAsync? _dessertsDataSource;
  final PaginatorController _controller = PaginatorController();

  bool _dataSourceLoading = false;
  int _initialRow = 0;

  @override
  void didChangeDependencies() {
    // initState is to early to access route options, context is invalid at that stage
    _dessertsDataSource =
        // ??= getCurrentRouteOption(context) == noData
        // false
        //     ? DessertDataSourceAsync.empty()
        //     : false
        //         ? DessertDataSourceAsync.error()
        //         :
        _StoreListApprovalSourceAsync();

    if (false) {
      _dataSourceLoading = true;
      _dessertsDataSource!.getTotalRecords().then((count) => setState(() {
            _initialRow = count - _rowsPerPage;
            _dataSourceLoading = false;
          }));
    }
    super.didChangeDependencies();
  }

  void sort(
    int columnIndex,
    bool ascending,
  ) {
    var columnName = "name";
    switch (columnIndex) {
      case 0:
        columnName = "#";
        break;
      case 1:
        columnName = "profile pic";
        break;
      case 2:
        columnName = "store name";
        break;
      case 3:
        columnName = "city";
        break;
      case 4:
        columnName = "mobile";
        break;
      case 5:
        columnName = "email";
        break;
      case 6:
        columnName = "admin share";
        break;
      case 7:
        columnName = "owner name";
        break;
    }
    _dessertsDataSource!.sort(columnName, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource!.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      DataColumn2(
        label: const Text('#'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
        size: ColumnSize.S,
        fixedWidth: 40,
      ),
      DataColumn2(
          label: const Text('Profile'),
          onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
          fixedWidth: 80),
      DataColumn2(
        label: const Text('Store Name'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('City'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Mobile'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Email'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Amin Share'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn2(
        label: const Text('Owner Name'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
    ];
  }

// Use global key to avoid rebuilding state of _TitledRangeSelector
// upon AsyncPaginatedDataTable2 refreshes, e.g. upon page switches
  final GlobalKey _rangeSelectorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Last ppage example uses extra API call to get the number of items in datasource
    if (_dataSourceLoading) return const SizedBox();

    return Stack(alignment: Alignment.bottomCenter, children: [
      AsyncPaginatedDataTable2(
          showCheckboxColumn: false,
          // horizontalMargin: 20,
          checkboxHorizontalMargin: 12,
          columnSpacing: 10,
          wrapInCard: false,

          header: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          constraints:
                          BoxConstraints(maxWidth: 150, minWidth: 100),
                          child: TextFormField()),
                    ],
                  ),
                ),
                width10(),
                Builder(builder: (context) {
                  return Row(children: [
                    Responsive.isMobile(context)
                        ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.print, color: Colors.teal))
                        : OutlinedButton(
                        onPressed: () => _controller.goToPageWithRow(25),
                        child: const Text('Print')),
                    width10(),
                    Responsive.isMobile(context)
                        ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.picture_as_pdf_outlined,
                            color: Colors.teal))
                        : OutlinedButton(
                        onPressed: () => _controller.goToPageWithRow(25),
                        child: const Text('Print')),
                  ]);
                }),

                // if (getCurrentRouteOption(context) == custPager)
                //   PageNumber(controller: _controller)
              ]),
          rowsPerPage: _rowsPerPage,
          autoRowsToHeight: true,
          pageSyncApproach: PageSyncApproach.goToFirst,
          minWidth: 800,
          fit: FlexFit.tight,
          border: TableBorder(
            borderRadius: BorderRadius.circular(10),
            top: BorderSide(color: Colors.grey[300]!),
            bottom: BorderSide(color: Colors.grey[300]!),
            left: BorderSide(color: Colors.grey[300]!),
            right: BorderSide(color: Colors.grey[300]!),
            // verticalInside: BorderSide(color: Colors.grey[300]!),
            // horizontalInside: const BorderSide(color: Colors.grey, width: 1),
          ),
          onRowsPerPageChanged: (value) {
            print('Row per page changed to $value');
            _rowsPerPage = value!;
          },
          initialFirstRowIndex: _initialRow,
          onPageChanged: (rowIndex) {
            //print(rowIndex / _rowsPerPage);
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          sortArrowIcon: Icons.keyboard_arrow_up,
          sortArrowAnimationDuration: const Duration(milliseconds: 0),
          onSelectAll: (select) => select != null && select
              // ? (getCurrentRouteOption(context) != selectAllPage
              ? _dessertsDataSource!.selectAll()
              //     : _dessertsDataSource!.selectAllOnThePage())
              // : (getCurrentRouteOption(context) != selectAllPage
              // ? _dessertsDataSource!.deselectAll()
              : _dessertsDataSource!.deselectAllOnThePage(),
          controller: _controller,
          // hidePaginator: getCurrentRouteOption(context) == custPager,
          columns: _columns,
          empty: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  // color: Colors.grey[200],
                  child: const Text('No data'))),
          loading: _Loading(),
          errorBuilder: (e) => _ErrorAndRetry(
              e.toString(), () => _dessertsDataSource!.refreshDatasource()),
          source: _dessertsDataSource!),
      // if (getCurrentRouteOption(context) == custPager)
      //   Positioned(bottom: 16, child: CustomPager(_controller))
    ]);
  }
}

class _ErrorAndRetry extends StatelessWidget {
  const _ErrorAndRetry(this.errorMessage, this.retry);

  final String errorMessage;
  final void Function() retry;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            // height: 70,
            decoration: BoxDecoration(
                color: getTheme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Oops! $errorMessage',
                      style: const TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: retry,
                      child:
                          const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        Text('Retry', style: TextStyle(color: Colors.white))
                      ]))
                ])),
      );
}

class _Loading extends StatefulWidget {
  @override
  __LoadingState createState() => __LoadingState();
}

class __LoadingState extends State<_Loading> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Colors.transparent,
        // at first show shade, if loading takes longer than 0,5s show spinner
        child: FutureBuilder(
            future:
                Future.delayed(const Duration(milliseconds: 500), () => true),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const SizedBox()
                  : Center(
                      child: Container(
                      // color: Colors.yellow,
                      padding: const EdgeInsets.all(7),
                      width: 150,
                      height: 50,
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Text('Loading....')
                          ]),
                    ));
            }));
  }
}

class _TitledRangeSelector extends StatefulWidget {
  const _TitledRangeSelector(
      {super.key,
      required this.onChanged,
      this.title = "",
      this.caption = "",
      this.range = const RangeValues(0, 100)});

  final String title;
  final String caption;
  final Duration titleToSelectorSwitch = const Duration(seconds: 2);
  final RangeValues range;
  final Function(RangeValues) onChanged;

  @override
  State<_TitledRangeSelector> createState() => _TitledRangeSelectorState();
}

class _TitledRangeSelectorState extends State<_TitledRangeSelector> {
  bool _titleVisible = true;
  RangeValues _values = const RangeValues(0, 100);

  @override
  void initState() {
    super.initState();

    _values = widget.range;

    Timer(
        widget.titleToSelectorSwitch,
        () => setState(() {
              _titleVisible = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: [
      AnimatedOpacity(
          opacity: _titleVisible ? 1 : 0,
          duration: const Duration(milliseconds: 1000),
          child: Align(
              alignment: Alignment.centerLeft, child: Text(widget.title))),
      AnimatedOpacity(
          opacity: _titleVisible ? 0 : 1,
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
              width: 340,
              child: SizedBox(
                  // data: blackSlider(context),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    DefaultTextStyle(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _values.start.toStringAsFixed(0),
                                  ),
                                  Text(
                                    widget.caption,
                                  ),
                                  Text(
                                    _values.end.toStringAsFixed(0),
                                  )
                                ]))),
                    SizedBox(
                        height: 24,
                        child: RangeSlider(
                          values: _values,
                          divisions: 9,
                          min: widget.range.start,
                          max: widget.range.end,
                          onChanged: (v) {
                            setState(() {
                              _values = v;
                            });
                            widget.onChanged(v);
                          },
                        ))
                  ]))))
    ]);
  }
}

int _idCounter = 0;

class _ApprovalStore {
  _ApprovalStore(
    this.profilePic,
    this.storeName,
    this.city,
    this.mobile,
    this.email,
    this.adminShare,
    this.ownerName,
  ) {
    profilePic = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
  }

  final int id = _idCounter++;

  String profilePic;
  final String storeName;
  final String city;
  final String mobile; // 10 digit mobile number with country code
  final String email;
  final double adminShare;
  final String ownerName;
  bool selected = false;
}

class _StoreListApprovalSourceAsync extends AsyncDataTableSource {
  final String tag = 'StoreListApprovalSourceAsync';
  _StoreListApprovalSourceAsync() {
    infoLog('DessertDataSourceAsync created', tag);
  }

  _StoreListApprovalSourceAsync.empty() {
    _empty = true;
    infoLog('DessertDataSourceAsync.empty created', tag);
  }

  _StoreListApprovalSourceAsync.error() {
    _errorCounter = 0;
    infoLog('DessertDataSourceAsync.error created', tag);
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;
  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final _StoreListApprovalService _repo = _StoreListApprovalService();

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
    warningLog('getRows($startIndex, $count)', tag);
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occurred';
      }
    }

    final format =
        NumberFormat.decimalPercentPattern(locale: 'en', decimalDigits: 0);
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var newData = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => _StoreListApprovalServiceResponse(0, []))
        : await _repo.getData(
            startIndex, count, _caloriesFilter, _sortColumn, _sortAscending);
    var response = AsyncRowsResponse(
        newData.totalRecords,
        newData.data.map((store) {
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
              DataCell(Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCachedNetworkImage(store.profilePic, ph: 35, pw: 35),
                  if (!Responsive.isDesktop(Get.context!))
                    GestureDetector(
                      onTap: () {
                        errorLog('Profile pic is id ${store.id}');
                      },
                      child: Icon(Icons.launch_outlined,
                          color: getTheme.colorScheme.primary, size: 20),
                    )
                ],
              )),
              DataCell(Text(store.storeName)),
              DataCell(Text(store.city)),
              DataCell(Text(store.mobile)),
              DataCell(Row(
                children: [
                  Expanded(
                      child: capText(store.email,
                          maxLines: 1, overflow: TextOverflow.ellipsis)),
                  width5(),
                  GestureDetector(
                    onTap: () {
                      errorLog('email is ${store.email}');
                    },
                    child: Icon(Icons.copy,
                        color: getTheme.colorScheme.primary, size: 10),
                  )
                ],
              )),
              DataCell(Text('${store.adminShare.toStringAsFixed(1)}%')),
              DataCell(Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(store.ownerName),
                  if (Responsive.isDesktop(Get.context!))
                    GestureDetector(
                      onTap: () {
                        errorLog('Profile pic is id ${store.id}');
                      },
                      child: Icon(Icons.launch_outlined,
                          color: getTheme.colorScheme.primary, size: 20),
                    )
                ],
              )), // DataCell(Text(format.format(store.iron / 100))),
            ],
          );
        }).toList());
    return response;
  }
}

class _StoreListApprovalServiceResponse {
  _StoreListApprovalServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<_ApprovalStore> data;
}

class _StoreListApprovalService {
  int Function(_ApprovalStore, _ApprovalStore)? _getComparisonFunction(
      String column, bool ascending) {
    infoLog('Column name is $column', '_getComparisonFunction');
    var coef = ascending ? 1 : -1;
    switch (column) {
      case '#':
        infoLog('Column name is $column', '_getComparisonFunction', '#');
        return (_ApprovalStore d1, _ApprovalStore d2) => coef * (d1.id - d2.id);
      case 'profile pic':
        infoLog(
            'Column name is $column', '_getComparisonFunction', 'profile pic');
      // return (ApprovalStore d1, ApprovalStore d2) =>
      //     coef * (d1.profilePic.compareTo(d2.profilePic));
      case 'store name':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.storeName.compareTo(d2.storeName));
      case 'city':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.city.compareTo(d2.city));
      case 'mobile':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.mobile.compareTo(d2.mobile));
      case 'email':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.email.compareTo(d2.email));
      case 'admin share':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.adminShare - d2.adminShare).round();
      case 'owner name':
        return (_ApprovalStore d1, _ApprovalStore d2) =>
            coef * (d1.ownerName.compareTo(d2.ownerName));
    }

    return null;
  }

  Future<_StoreListApprovalServiceResponse> getData(int startingAt, int count,
      RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 1000
                : startingAt < 20
                    ? 500
                    : 200), () {
      var result = _dessertsX3;
/*
      if (caloriesFilter != null) {
        result = result
            .where((e) =>
                e.storeName >= caloriesFilter.start &&
                e.storeName <= caloriesFilter.end)
            .toList();
      }
*/

      try {
        result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      } catch (e) {
        print(e);
      }

      return _StoreListApprovalServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;
//sample
List<_ApprovalStore> _createSampleInstances(int count) {
  List<_ApprovalStore> instances = [];
  for (int i = 0; i < count; i++) {
    instances.add(_ApprovalStore(
      "profile_pic_$i.jpg",
      "Store $i",
      "City $i",
      "123456789$i",
      "store$i@example.com",
      0.1 * i,
      "Owner $i",
    ));
  }
  return instances;
}

List<_ApprovalStore> _stores = _createSampleInstances(100);
List<_ApprovalStore> _dessertsX3 = _stores.toList()
  ..addAll(_stores.map((i) => _ApprovalStore('${i.profilePic} x2', i.storeName,
      i.city, i.mobile, i.email, i.adminShare, i.ownerName)))
  ..addAll(_stores.map((i) => _ApprovalStore('${i.profilePic} x3', i.storeName,
      i.city, i.mobile, i.email, i.adminShare, i.ownerName)));

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
