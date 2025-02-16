import 'package:flutter/material.dart';

import 'src/core/network/api_employees.dart';
import 'src/core/routes/route_generator.dart';
import 'src/data/datasource/employee_remote_data_source.dart';
import 'src/data/repositories/employee_repository_impl.dart';
import 'src/presentation/bloc/employee_bloc.dart';
import 'src/presentation/pages/home_screen.dart';
import 'src/presentation/provider/employee_bloc_provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeBlocProvider(
      employeeBloc: EmployeeBloc(
        EmployeeRepositoryImpl(
          EmployeeRemoteDataSource(
            ApiEmployees(),
          ),
        ),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee App',
        initialRoute: HomeScreen.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
