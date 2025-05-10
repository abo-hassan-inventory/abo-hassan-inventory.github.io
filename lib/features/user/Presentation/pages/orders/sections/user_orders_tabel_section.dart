// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/orders/widgets/user_order_datagrid.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_orders_bloc/bloc/user_order_bloc.dart';
import 'package:inventory_project/features/user/util/alerts/user_alerts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserOrdersTabelSection extends StatelessWidget {
  const UserOrdersTabelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderBloc, UserOrderState>(
      builder: (context, state) {
        if (state is UserOrderInitial) {
          return Center(
            child: Text(
              'لا يوجد طلبات',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        }
        // the error state is handeld in the mian root page by a lisner
        if (state is user_order_temp_list_loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is user_order_temp_list_loaded) {
          if (state.templist.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد طلبات',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
            // this state is to display the error message is hanedled in the root page main one with bloc lisner
          } else if (state.templist.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 500.h,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      gridLineColor: C.blue,
                      headerColor: C.yellow,
                      sortIconColor: C.bluish),
                  child: SfDataGrid(
                    footerFrozenRowsCount: 1,
                    footer: Container(
                      decoration: BoxDecoration(color: C.yellow),
                      child: Center(
                        child: Text(
                          'لديك ${state.templist.length} طلب بإجمالي ${state.templist.fold(0, (sum, item) => sum + item.quantity)} قطعة ',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    allowSorting: true,
                    isScrollbarAlwaysShown: false,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    headerRowHeight: 60,
                    source: Userorderdatasource(context, stuff: state.templist),
                    onCellTap: (details) async {},
                    onCellLongPress: (details) async {
                      if (details.rowColumnIndex.rowIndex != 0) {
                        final DataGridRow row =
                            Userorderdatasource(context, stuff: state.templist)
                                .rows[details.rowColumnIndex.rowIndex - 1];
                        final int quantaity = row
                            .getCells()
                            .firstWhere(
                                (cell) => cell.columnName == 'quantaity')
                            .value;
                        final String name = row
                            .getCells()
                            .firstWhere((cell) => cell.columnName == 'name')
                            .value;
                        final String id = row
                            .getCells()
                            .firstWhere((cell) => cell.columnName == 'id')
                            .value;
                        user_delete_alert(context,
                            item_id: id, item_quantaty: quantaity);
                      }
                    },
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
        return Container();
      },
    );
  }
}
