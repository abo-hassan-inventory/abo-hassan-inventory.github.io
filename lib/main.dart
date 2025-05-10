import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/fonts/textTheme.dart';
import 'package:inventory_project/features/admin/data/data_source/admin_remote_data_source.dart';
import 'package:inventory_project/features/admin/data/repo/admin_repository_impl.dart';
import 'package:inventory_project/features/admin/domain/usecase/admin_usecase.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/analysis_bloc/bloc/analysis_bloc.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/analysis_bloc/roro/bloc/orderssummary_bloc.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/messages/bloc/message_bloc.dart';
import 'package:inventory_project/features/auth/data/data%20source/auth_remote_data_source.dart';
import 'package:inventory_project/features/auth/data/repo/auth_repository_impl.dart';
import 'package:inventory_project/features/auth/domain/usecase/auth_usecase.dart';
import 'package:inventory_project/features/auth/presentation/pages/splash%20screen/splash_screen.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/user/Data/data_source/user_inventory_remote.dart';
import 'package:inventory_project/features/user/Data/repo/user_inventory_repo_impl.dart';
import 'package:inventory_project/features/user/Domain/usecase/user_usecase.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_orders_bloc/bloc/user_order_bloc.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_reservations_bloc/res_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/admin/presentation/state manegment/res/admin_res_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://csotdcmvxijfvfbctudm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNzb3RkY212eGlqZnZmYmN0dWRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwMDkyODgsImV4cCI6MjA1NDU4NTI4OH0.eV9T8Ak5fVnxPcwOGkuDj_A8my-RSOELnS9mJ9RfluQ',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final supabaseClient = Supabase.instance.client;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //------------------- i used  screen util in here for the responsivnes -----------------------
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                Case: UseCase(AuthRepositoryImpl(
                    remoteDataSource:
                        AuthRemoteDataSource(supabaseClient: supabaseClient))),
              ),
            ),
            BlocProvider(
              create: (context) => InventoryBloc(
                AdminUsecase(AdminRepositoryImpl(
                    remoteDataSource:
                        AdminRemoteDataSourceImpl(supabase: supabaseClient))),
              ),
            ),
            BlocProvider(
              create: (context) => AnalysisBloc(
                AdminUsecase(AdminRepositoryImpl(
                    remoteDataSource:
                        AdminRemoteDataSourceImpl(supabase: supabaseClient))),
              ),
            ),
            BlocProvider(
              create: (context) => MessageBloc(
                AdminUsecase(AdminRepositoryImpl(
                    remoteDataSource:
                        AdminRemoteDataSourceImpl(supabase: supabaseClient))),
              ),
            ),
            BlocProvider(
              create: (context) => UserInventoryBloc(
                UserUsecase(UserInventoryRepoImpl(
                    (UserInventoryRemote(supabaseClient)))),
              ),
            ),
            BlocProvider(
              create: (context) => UserOrderBloc(
                UserUsecase(UserInventoryRepoImpl(
                    (UserInventoryRemote(supabaseClient)))),
              ),
            ),
            BlocProvider(
              create: (context) => ResBloc(
                UserUsecase(UserInventoryRepoImpl(
                    (UserInventoryRemote(supabaseClient)))),
              ),
            ),
            BlocProvider(
              create: (context) => AdminResBloc(
                AdminUsecase(AdminRepositoryImpl(
                    remoteDataSource:
                        AdminRemoteDataSourceImpl(supabase: supabaseClient))),
              ),
            ),
            BlocProvider(
              create: (context) => OrdersSummaryBloc(
                AdminUsecase(AdminRepositoryImpl(
                    remoteDataSource:
                        AdminRemoteDataSourceImpl(supabase: supabaseClient))),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'inventory',
            theme: ThemeData(textTheme: FontTheme.textTheme),

            // this page is only a temp section to check the user is logged in or not and im gonna make it a
            //it will be a splash screen
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
