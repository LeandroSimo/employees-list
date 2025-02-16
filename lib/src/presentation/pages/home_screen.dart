import 'package:flutter/material.dart';

import '../../core/network/api_employees.dart';
import '../../data/datasource/employee_remote_data_source.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final EmployeeBloc _employeeBloc;

  @override
  void initState() {
    super.initState();

    final apiEmployees = ApiEmployees();
    final remoteDataSource = EmployeeRemoteDataSource(apiEmployees);
    final employeeRepository = EmployeeRepositoryImpl(remoteDataSource);

    _employeeBloc = EmployeeBloc(employeeRepository);
    _employeeBloc.eventSink.add(GetEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<EmployeeState>(
            stream: _employeeBloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError || snapshot.data is EmployeeError) {
                String errorMessage = snapshot.hasError
                    ? snapshot.error.toString()
                    : (snapshot.data as EmployeeError).message;
                return Center(
                  child: Text('Erro: $errorMessage'),
                );
              } else if (!snapshot.hasData ||
                  snapshot.data is EmployeeLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.data is EmployeeLoaded) {
                final employees = (snapshot.data as EmployeeLoaded).employees;
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return ListTile(
                      title: Text(employee.name),
                      subtitle: Text(employee.job),
                    );
                  },
                );
              } else {
                return const Center(child: Text('Erro desconhecido'));
              }
            }),
      ),
    );
  }
}
