import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';

// ignore: must_be_immutable
class AdminInventorySearchSection extends StatelessWidget {
  TextEditingController controller;
  AdminInventorySearchSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // used decorationaly for the rlt in the text feild
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: C.secondaryBackground,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: C.grey.withAlpha(80),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            //"ابحث عن منتج معين"
            child: TextField(
                controller: controller,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  labelText: "ابحث عن منتج",
                  labelStyle: Theme.of(context).textTheme.displayLarge,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: C.red,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  context.read<InventoryBloc>().add(searchEvent(text: value));
                })));
  }
}
