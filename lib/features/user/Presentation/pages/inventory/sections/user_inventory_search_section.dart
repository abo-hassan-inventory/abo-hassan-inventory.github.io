import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/core/theme/C.dart';

import '../../../state manegment/user_inventory_bloc/user_inventory_bloc.dart';

class UserInventorySearchSection extends StatelessWidget {
  const UserInventorySearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: C.secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: C.grey_border,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: C.grey.withAlpha(80),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          onChanged: (value) {
            context.read<UserInventoryBloc>().add(searchEvent(value));
          },
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            label: Text("ابحث عن منتج معين",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Color(0xFF5A5E77))),
            prefixIcon: Icon(
              Icons.search,
              color: C.red,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
