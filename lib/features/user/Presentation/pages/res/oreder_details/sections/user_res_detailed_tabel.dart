import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../../Domain/entity/user_gorge_orditem.dart';
import '../widgets/user_res_detailed_source.dart';
//-----------------------used sfdatagrid package in here for the tabel--------------------------------

class UserResDetailedTabel extends StatelessWidget {
  final int total_count;
  final String date;
  final List<UserGorgeOrditem> itemss;
  const UserResDetailedTabel(
      {super.key,
      required this.total_count,
      required this.date,
      required this.itemss});

//---------------cahnge with real data from the database----------------
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: C.primaryBackground,
        height: 580.h,
        child: SfDataGridTheme(
          data: SfDataGridThemeData(
              headerColor: C.blue, sortIconColor: C.primaryBackground),
          child: SfDataGrid(
            footerFrozenRowsCount: 1,
            footer: Container(
              decoration: BoxDecoration(color: C.blue),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(date),
                      ),
                      Text(
                        'عدد الاصناف  : $total_count',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ]),
              ),
            ),
            allowSorting: true,
            isScrollbarAlwaysShown: false,
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.horizontal,
            headerRowHeight: 60,
            source: UserResDetailedSource(context, stuff: itemss),
            columns: [
              GridColumn(
                width: 100.w,
                columnName: 'ID',
                label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    'العدد',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              GridColumn(
                width: 270.w,
                columnName: 'Name',
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اسم الصنف ',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
