import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/widgets/datagrid_source.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_project/features/admin/util/admin/admin_alets.dart';
import 'package:inventory_project/features/admin/util/admin/admin_buttom_sheet.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//-----------------------used sfdatagrid package in here for the tabel--------------------------------

// ignore: must_be_immutable
class AdminInventoryTableSection extends StatelessWidget {
  TextEditingController search_controller;

  AdminInventoryTableSection({super.key, required this.search_controller});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      // the bloc provider is here --------------------------------------
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          // ---------------fisrt state loading ----------------
          if (state is InventoryLoading) {
            return Container(
              height: 580.h,
              child: const Center(
                  child: CircularProgressIndicator(
                color: C.bluish,
              )),
            );

            // ---------------second state error ----------------
          } else if (state is InventoryError) {
            return Center(child: Text(state.message));
          }
//------------third state loaded ----------------
          if (state is InventoryLoaded) {
            return Container(
              height: 580.h,
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                    headerColor: C.blue, sortIconColor: C.primaryBackground),
                child: SfDataGrid(
                  footerFrozenRowsCount: 1,
                  footer: Container(
                    decoration: BoxDecoration(color: C.blue),
                    child: Center(
                      child: Text(
                        'عدد الاصناف  : ${MemberDataSource(context, stuff: state.inventoryList).rows.length}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  allowSorting: true,
                  isScrollbarAlwaysShown: false,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  headerRowHeight: 60,
                  // this is the source so dont look far--------------------------------------------
                  source: MemberDataSource(context, stuff: state.inventoryList),
                  onCellTap: (details) async {
                    // here im using the real date to display on the editing buttom sheet --------------------------

                    if (details.rowColumnIndex.rowIndex != 0) {
                      final DataGridRow row =
                          MemberDataSource(context, stuff: state.inventoryList)
                              .rows[details.rowColumnIndex.rowIndex - 1];
                      final int quantaity = row
                          .getCells()
                          .firstWhere((cell) => cell.columnName == 'quantaity')
                          .value;
                      final String name = row
                          .getCells()
                          .firstWhere((cell) => cell.columnName == 'name')
                          .value;
                      final String id = row
                          .getCells()
                          .firstWhere((cell) => cell.columnName == 'id')
                          .value;
                      EditItem_sheet(
                          context, name, quantaity, id, search_controller);
                    }
                  },
                  onCellLongPress: (details) async {
                    //----------this part here is to delete the item --------------------
                    if (details.rowColumnIndex.rowIndex != 0) {
                      // Create a data source instance to extract the row
                      final DataGridRow row =
                          MemberDataSource(context, stuff: state.inventoryList)
                              .rows[details.rowColumnIndex.rowIndex - 1];

                      // Extract the product ID from the hidden row  row
                      final String id = row
                          .getCells()
                          .firstWhere((cell) => cell.columnName == 'id')
                          .value;
                      admin_delete_alert(context, id);
                    }
                  },
                  columns: [
                    GridColumn(
                      width: 100.w,
                      columnName: 'quantaity',
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
                      columnName: 'name',
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
            );
          } else
            // ---------------default state ----------------
            return Container(
              child: Center(
                child: Text("somthing wnet wrong"),
              ),
            );
        },
      ),
    );
  }
}
