import 'package:flutter/material.dart';

import '../../core/network/api_employees.dart';
import '../../data/datasource/employee_remote_data_source.dart';
import '../../data/repositories/employee_repository_impl.dart';
import '../../domain/entities/employee_entity.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';
import '../provider/employee_bloc_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final EmployeeBloc _employeeBloc;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _employeeBloc = EmployeeBlocProvider.of(context);
      _employeeBloc.eventSink.add(GetEmployeesEvent());
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<EmployeeState>(
          stream: _employeeBloc.stateStream,
          builder: (context, snapshot) {
            return _buildUI(snapshot);
          },
        ),
      ),
    );
  }

  Widget _buildUI(AsyncSnapshot<EmployeeState> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildLoading();
    }

    if (snapshot.hasError || snapshot.data is EmployeeError) {
      final errorMessage = snapshot.hasError
          ? snapshot.error.toString()
          : (snapshot.data as EmployeeError).message;
      return _buildError(errorMessage);
    }

    if (!snapshot.hasData || snapshot.data is EmployeeLoading) {
      return _buildLoading();
    }

    if (snapshot.data is EmployeeLoaded) {
      final employees = (snapshot.data as EmployeeLoaded).employees;
      return _buildEmployeeList(employees);
    }

    return _buildUnknownError();
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Text('Erro: $errorMessage'),
    );
  }

  Widget _buildEmployeeList(List<EmployeeEntity> employees) {
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
  }

  Widget _buildUnknownError() {
    return const Center(
      child: Text('Erro desconhecido'),
    );
  }
}
