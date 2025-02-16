import 'package:collaborators_table/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/employee_entity.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';
import '../provider/employee_bloc_provider.dart';
import '../widgets/custom_notification_widget.dart';

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
        child: SingleChildScrollView(
          child: Container(
            height: context.mediaQuery.height,
            width: context.mediaQuery.width,
            padding: EdgeInsets.all(context.mediaQuery.width * 0.05),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: context.mediaQuery.width * 0.075,
                      backgroundColor: Color(0xFFF5F5F5),
                      child: Text(
                        "LS",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomNotificationWidget(),
                  ],
                ),
                SizedBox(height: context.mediaQuery.height * 0.1),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Funcionários",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: context.mediaQuery.height * 0.8,
                    width: context.mediaQuery.width,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Collaborators Table',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: context.mediaQuery.height * 0.8,
                //   width: context.mediaQuery.width,
                //   color: Colors.green,
                //   child: StreamBuilder<EmployeeState>(
                //     stream: _employeeBloc.stateStream,
                //     builder: (context, snapshot) {
                //       return _buildUI(snapshot);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
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
      shrinkWrap: true,
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
