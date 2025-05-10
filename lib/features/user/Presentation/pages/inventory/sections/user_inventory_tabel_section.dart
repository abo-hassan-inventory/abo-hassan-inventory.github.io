import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/inventory/widgets/user_datagrid_source_inventory.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/util/buttom%20sheet%20sections/user_buttom_sheets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

// converted this section to a statfull widget to make it more dynamic when it comes to delaing with text editing controllers
class UserInventoryTabelSection extends StatefulWidget {
  const UserInventoryTabelSection({super.key});

  @override
  State<UserInventoryTabelSection> createState() =>
      _UserInventoryTabelSectionState();
}

class _UserInventoryTabelSectionState extends State<UserInventoryTabelSection> {
  final TextEditingController oreder_item_controller = TextEditingController();
  // this key is the key fro the form to check validation
  final order_feild_key = GlobalKey<FormState>();

// added this deispose method to dispose of the text editing controller to release resources
  @override
  void dispose() {
    oreder_item_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // here im using the bloc of the user inventory part

    return BlocBuilder<UserInventoryBloc, UserInventoryState>(
      builder: (context, state) {
        // fisrt state loading
        if (state is user_inventoryloading) {
          return Container(
            height: 580.h,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        // this state is to display the error message is hanedled in the root page main one with bloc lisner

        // here is the state that have all the updated date from suba base

        if (state is user_inventoryLoaded) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 580.h,
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  headerColor: C.blue,
                ),
                child: SfDataGrid(
                  footerFrozenRowsCount: 1,
                  footer: Container(
                    decoration: BoxDecoration(color: C.blue),
                    child: Center(
                      child: Text(
                        'عدد الاصناف  : ${Userdatasource(context, stuff: state.inventory).rows.length}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),

                  isScrollbarAlwaysShown: false,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  headerRowHeight: 60,
                  // here is where i used the list in the data grid source that list is from supabase
                  source: Userdatasource(context, stuff: state.inventory),
                  // here is wher i tap and activate the function to add the new order
                  onCellTap: (details) async {
                    if (details.rowColumnIndex.rowIndex != 0) {
                      final DataGridRow row =
                          Userdatasource(context, stuff: state.inventory)
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

                      add_new_order(context, name, quantaity, id,
                          oreder_item_controller, order_feild_key);
                    }
                  },
                  onCellLongPress: (details) async {},
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
        // if there is a unknown error no state is being emitted do return this

        return Center(
          child: Container(
            child: Text("unknown error has acourred "),
          ),
        );
      },
    );
  }
}
