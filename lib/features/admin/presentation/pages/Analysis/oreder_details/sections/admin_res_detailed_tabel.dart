import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_item_entity.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../../domain/entiti/analysis/ItemSummaryEntity.dart';
import '../widgets/admin_res_detailed_source.dart';

//-----------------------used sfdatagrid package in here for the tabel--------------------------------

class AdminroroDetailedTabel extends StatelessWidget {
  final int total_count;

  final List<ItemSummaryEntity> itemss;
  const AdminroroDetailedTabel(
      {super.key, required this.total_count, required this.itemss});

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
            headerColor: C.blue,
          ),
          child: SfDataGrid(
            footerFrozenRowsCount: 1,
            footer: Container(
              decoration: BoxDecoration(color: C.blue),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'عدد الاصناف  : $total_count',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ]),
              ),
            ),
            isScrollbarAlwaysShown: false,
            gridLinesVisibility: GridLinesVisibility.horizontal,
            headerGridLinesVisibility: GridLinesVisibility.horizontal,
            headerRowHeight: 60,
            source: AdminroroDetailedSource(context, stuff: itemss),
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
