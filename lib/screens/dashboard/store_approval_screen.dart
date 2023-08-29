import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_dashboard/screens/dashboard/components/recent_files.dart';
import '../../data/data_sources.dart';
import '../../models/RecentFile.dart';
import '../../widgets/rich_text_editor.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/screens/dashboard/components/default_caontainer.dart';
import '/screens/dashboard/components/edit_profile.dart';
import '/utils/dialogs.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import '../../responsive.dart';

import 'components/profile/profile_header.dart';

class StoreApprovalScreen extends StatefulWidget {
  const StoreApprovalScreen({super.key});

  @override
  State<StoreApprovalScreen> createState() => _StoreApprovalScreenState();
}

class _StoreApprovalScreenState extends State<StoreApprovalScreen> {
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
                Expanded(child: AsyncPaginatedDataTable2Demo())
              ],
            ),
          ),
        );
      },
    );
  }
}

class AsyncPaginatedDataTable2Demo extends StatefulWidget {
  const AsyncPaginatedDataTable2Demo({super.key});

  @override
  AsyncPaginatedDataTable2DemoState createState() =>
      AsyncPaginatedDataTable2DemoState();
}

class AsyncPaginatedDataTable2DemoState
    extends State<AsyncPaginatedDataTable2Demo> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  StoreListApprovalSourceAsync? _dessertsDataSource;
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
        StoreListApprovalSourceAsync();

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
      case 1:
        columnName = "#";
        break;
      case 2:
        columnName = "profile pic";
        break;
      case 3:
        columnName = "store name";
        break;
      case 4:
        columnName = "city";
        break;
      case 5:
        columnName = "mobile";
        break;
      case 6:
        columnName = "email";
        break;
      case 7:
        columnName = "admin share";
        break;
      case 8:
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
      DataColumn(
        label: const Text('Desert'),
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Calories'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Fat (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Carbs (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Protein (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Sodium (mg)'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Calcium (%)'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Iron (%)'),
        numeric: true,
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
          horizontalMargin: 20,
          checkboxHorizontalMargin: 12,
          columnSpacing: 0,
          wrapInCard: false,
//           header: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 //TODO: Range Selector
// /*                _TitledRangeSelector(
//                     range: const RangeValues(150, 600),
//                     onChanged: (v) {
//                       // If the curren row/current page happens to be larger than
//                       // the total rows/total number of pages what would happen is determined by
//                       // [pageSyncApproach] field
//                       _dessertsDataSource!.caloriesFilter = v;
//                     },
//                     key: _rangeSelectorKey,
//                     title: 'AsyncPaginatedDataTable2',
//                     caption: 'Calories'),*/
//                 // if (kDebugMode && getCurrentRouteOption(context) == custPager)
//
//                 //TODO:Page Jumper
// /*
//                 Row(children: [
//                   OutlinedButton(
//                       onPressed: () => _controller.goToPageWithRow(25),
//                       child: const Text('Go to row 25')),
//                   OutlinedButton(
//                       onPressed: () => _controller.goToRow(5),
//                       child: const Text('Go to row 5'))
//                 ]),
// */
//                 // if (getCurrentRouteOption(context) == custPager)
//                 //   PageNumber(controller: _controller)
//               ]),
          rowsPerPage: _rowsPerPage,
          autoRowsToHeight: true,
          pageSyncApproach: PageSyncApproach.goToFirst,
          minWidth: 800,
          fit: FlexFit.loose,
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
            height: 70,
            color: Colors.red,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

/*
class _StoreListTable extends StatefulWidget {
  const _StoreListTable({
    Key? key,
  }) : super(key: key);

  @override
  State<_StoreListTable> createState() => _StoreListTableState();
}

class _StoreListTableState extends State<_StoreListTable> {
  bool aToz = true;
  bool latest = true;
  bool larger = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Store List (Waiting for Approval)",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            // width: double.infinity,
            // height: 300,
            child: DataTable2(
              isHorizontalScrollBarVisible: true,
              isVerticalScrollBarVisible: true,
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("#"),
                        Icon(
                            aToz
                                ? Icons.arrow_drop_down_rounded
                                : Icons.arrow_drop_up_rounded,
                            size: 16)
                      ],
                    ),
                    onSort: (i, v) {
                      setState(() {
                        demoRecentFiles.sort((_a, _b) {
                          var a;
                          var b;
                          a = aToz ? _b : _a;
                          b = aToz ? _a : _b;
                          return b.title
                              .toString()
                              .compareTo(a.title.toString());
                        });
                        aToz = !aToz;
                      });
                    }),
                DataColumn(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("File Name"),
                        Icon(
                            aToz
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 16)
                      ],
                    ),
                    onSort: (i, v) {
                      setState(() {
                        demoRecentFiles.sort((_a, _b) {
                          var a;
                          var b;
                          a = aToz ? _b : _a;
                          b = aToz ? _a : _b;
                          return b.title
                              .toString()
                              .compareTo(a.title.toString());
                        });
                        aToz = !aToz;
                      });
                    }),
                DataColumn(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date"),
                        Icon(
                            !latest
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 16)
                      ],
                    ),
                    onSort: (i, v) {
                      setState(() {
                        demoRecentFiles.sort((_a, _b) {
                          var a;
                          var b;
                          a = !latest ? _b : _a;
                          b = latest ? _a : _b;
                          return DateTime.parse(b.date
                                      .toString()
                                      .split('-')
                                      .reversed
                                      .toList()
                                      .join('-'))
                                  .isAfter(DateTime.parse(a.date
                                      .toString()
                                      .split('-')
                                      .reversed
                                      .toList()
                                      .join('-')))
                              ? 0
                              : 1;
                        });
                        latest = !latest;
                      });
                    }),
                DataColumn(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Size"),
                        Icon(
                            !larger
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 16)
                      ],
                    ),
                    onSort: (i, v) {
                      setState(() {
                        demoRecentFiles.sort((_a, _b) {
                          var a;
                          var b;
                          a = larger ? _b : _a;
                          b = !larger ? _a : _b;
                          return b.size.toString().compareTo(a.size.toString());
                        });
                        larger = !larger;
                      });
                    }),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index], index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo, int index) {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(index.toString()),
        ),
      ),
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
*/
/*


class PaginatedDataTable2Demo extends StatefulWidget {
  const PaginatedDataTable2Demo({super.key});

  @override
  PaginatedDataTable2DemoState createState() => PaginatedDataTable2DemoState();
}

class PaginatedDataTable2DemoState extends State<PaginatedDataTable2Demo> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late DessertDataSource _dessertsDataSource;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dessertsDataSource = DessertDataSource(
          context, true);

      _controller = PaginatorController();

        _sortColumnIndex = 1;
      _initialized = true;
    }
  }

  void sort<T>(
      Comparable<T> Function(Dessert d) getField,
      int columnIndex,
      bool ascending,
      ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      DataColumn(
        label: const Text('Desert'),
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.name, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Calories'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.calories, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Fat (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.fat, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Carbs (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.carbs, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Protein (gm)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.protein, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Sodium (mg)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.sodium, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Calcium (%)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.calcium, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Iron (%)'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.iron, columnIndex, ascending),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      PaginatedDataTable2(
        // availableRowsPerPage: const [2, 5, 10, 30, 100],
        horizontalMargin: 20,
        // checkboxHorizontalMargin: 12,
        columnSpacing: paddingDefault,
        wrapInCard: true,
        renderEmptyRowsInTheEnd: false,
        // headingRowColor:
        // MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
        rowsPerPage: _rowsPerPage,
        autoRowsToHeight: true,
        // minWidth: 800,
        fit: FlexFit.loose,
        border: TableBorder(
            top: const BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.grey[300]!),
            left: BorderSide(color: Colors.grey[300]!),
            right: BorderSide(color: Colors.grey[300]!),
            // verticalInside: BorderSide(color: Colors.grey[300]!),
            // horizontalInside: const BorderSide(color: Colors.grey, width: 1),
        ),
        onRowsPerPageChanged: (value) {
          // No need to wrap into setState, it will be called inside the widget
          // and trigger rebuild
          //setState(() {
          _rowsPerPage = value!;
          print(_rowsPerPage);
          //});
        },
        initialFirstRowIndex: 0,
        onPageChanged: (rowIndex) {
          print(rowIndex / _rowsPerPage);
        },
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
        sortArrowAnimationDuration:
        const Duration(milliseconds: 0), // custom animation duration
        onSelectAll: _dessertsDataSource.selectAll,
        controller:
         _controller,
        hidePaginator: false,
        columns: _columns,
        empty: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                // color: Colors.grey[200],
                child: const Text('No data'))),
        source: false
            ? DessertDataSource.empty(context)
            : _dessertsDataSource,
      ),
        // Positioned(bottom: 16, child: CustomPager(_controller!))
    ]);
  }
}
*/
