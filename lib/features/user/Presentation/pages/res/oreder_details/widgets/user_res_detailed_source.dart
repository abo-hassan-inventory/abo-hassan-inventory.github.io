import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_orditem.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

//temp model later to make the ultimate one

//temp list to test the ui
class UserResDetailedSource extends DataGridSource {
  List<UserGorgeOrditem> stuff;
  List<DataGridRow> _dataGridRows = [];

  UserResDetailedSource(this.context, {required this.stuff}) {
    buildDataGridRows();
  }

  final BuildContext context;

  void buildDataGridRows() {
    _dataGridRows = stuff.map<DataGridRow>((item) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'quantaity', value: item.quantity),
        DataGridCell<String>(columnName: 'name', value: item.itemName),
        // added this hidden column to get the uiud fro ecah item when i try to delete or update them
        DataGridCell<String>(columnName: 'id', value: item.id),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        decoration: BoxDecoration(color: C.blue2),
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        decoration: BoxDecoration(color: C.blue2),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    ]);
  }
}
