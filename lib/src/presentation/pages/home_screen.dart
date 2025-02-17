import 'package:collaborators_table/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../provider/employee_bloc_provider.dart';
import '../widgets/custom_notification_widget.dart';
import '../widgets/list_of_employees.dart';

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
                SizedBox(height: context.mediaQuery.height * 0.05),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Funcionários",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: context.mediaQuery.height * 0.02),
                ListOfEmployess(employeeBloc: _employeeBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
