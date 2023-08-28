import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/RecentFile.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
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
            "Recent Files",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
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
                          return b.size
                              .toString()
                              .compareTo(a.size.toString());
                        });
                        larger = !larger;
                      });
                    }),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
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
