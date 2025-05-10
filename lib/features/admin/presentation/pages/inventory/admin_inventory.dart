import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/sections/admin_inventory_search_section.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/sections/admin_inventory_tabel_section.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_project/features/admin/util/admin/admin_buttom_sheet.dart';

// ignore: must_be_immutable
class AdminInventory extends StatefulWidget {
  AdminInventory({super.key});

  @override
  State<AdminInventory> createState() => _AdminInventoryState();
}

class _AdminInventoryState extends State<AdminInventory> {
  TextEditingController item_name = TextEditingController();

  TextEditingController item_quantity = TextEditingController();

  // this is for the search canceling
  TextEditingController search_controller = TextEditingController();

  @override
  void dispose() {
    item_name.dispose();
    item_quantity.dispose();
    search_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<InventoryBloc>().add(getInventoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is InventoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                ),
                backgroundColor: C.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          if (state is added_sucessfuly) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                ),
                backgroundColor: C.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is updated_sucessfuly) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                ),
                backgroundColor: C.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is removed_sucessfuly) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                ),
                backgroundColor: C.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
            // here is the part for the eleveted button
            resizeToAvoidBottomInset: true,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addnewitem_sheet(context);
              },
              backgroundColor: C.bluish,
              child: Icon(
                Icons.add,
                color: C.secondaryBackground,
              ),
            ),
            backgroundColor: C.primaryBackground,
            // this is the app bar part for the refresh button
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: C.green,
                  ),
                  onPressed: () {
                    // Handle refresh the list ------------------------------------
                    context.read<InventoryBloc>().add(getInventoryEvent());
                  },
                ),
              ],
              surfaceTintColor: Colors.transparent,
              backgroundColor: C.primaryBackground,
              centerTitle: true,
              title: Text(
                "المخزون",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AdminInventorySearchSection(
                    controller: search_controller,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AdminInventoryTableSection(
                    search_controller: search_controller,
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
