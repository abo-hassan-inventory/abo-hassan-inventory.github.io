import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/Analysis/widgets/admin_analysis_cart.dart';
import 'package:inventory_project/features/user/util/widgets/snackbar/user_snackbar.dart';

import '../../state manegment/analysis_bloc/roro/bloc/orderssummary_bloc.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.primaryBackground,
      appBar: AppBar(
        backgroundColor: C.primaryBackground,
        title: Text(
          "التحليلات", style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center, // يمكنك إزالته إن استخدمت centerTitle
        ),
        centerTitle: true, // يجعل العنوان في المنتصف
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<OrdersSummaryBloc>().add(FetchOrdersSummaryEvent());
            },
          ),
        ],
      ),
      body: BlocListener<OrdersSummaryBloc, OrdersSummaryState>(
        listener: (context, state) {
          if (state is OrdersSummaryError) {
            user_SnackBar(
                context: context,
                message: state.message,
                backgroundColor: C.red);
          }
          if (state is OrdersSummaryConfirmed) {
            user_SnackBar(
                context: context,
                message: state.message,
                backgroundColor: C.green);
          }
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: BlocBuilder<OrdersSummaryBloc, OrdersSummaryState>(
              builder: (context, state) {
                if (state is OrdersSummaryInitial) {
                  BlocProvider.of<OrdersSummaryBloc>(context)
                      .add(FetchOrdersSummaryEvent());
                }
                if (state is OrdersSummaryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is OrdersSummaryLoaded) {
                  if (state.summaries.isEmpty) {
                    return Center(
                      child: Text(
                        "لم يقم اي مندوب بحجز طلبات حتي الان",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    );
                  } else if (state.summaries.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.summaries.length,
                      itemBuilder: (context, index) {
                        return AdminAnalysisCart(
                          orderCount: state.summaries[index].orderCount,
                          name: state.summaries[index].userName,
                          items: state.summaries[index].items,
                          userId: state.summaries[index].userId,
                        );
                      },
                    );
                  }
                }

                return Container(
                  child: Text(
                    "حدث خطا ما لا تقلق قم باعادة تشغيل البرنامج",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              },
            ),
          ),
        )),
      ),
    );
  }
}
