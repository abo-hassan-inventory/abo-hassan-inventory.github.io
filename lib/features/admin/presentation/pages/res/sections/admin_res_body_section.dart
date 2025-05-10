import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/features/admin/presentation/pages/res/widgets/admin_res_card_widget.dart';

import '../../../state manegment/res/admin_res_bloc.dart';

class AdminResBodySection extends StatelessWidget {
  const AdminResBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminResBloc, AdminResState>(
      builder: (context, state) {
        if (state is AdminResInitial) {
          context.read<AdminResBloc>().add(GetAllOrders());
        }
        if (state is AdminResLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AdminResLoaded) {
          if (state.orders.isEmpty) {
            return Center(
              child: Text("لا يوجد حجوزات"),
            );
          } else if (state.orders.isNotEmpty) {
            return Container(
              child: ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return AdminResCardWidget(
                    order_id: state.orders[index].orderId,
                    name: state.orders[index].userName,
                    total_items: state.orders[index].items.length,
                    date: state.orders[index].orderDate!,
                    items: state.orders[index].items,
                  );
                },
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
