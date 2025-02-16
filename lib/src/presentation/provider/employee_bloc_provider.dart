import 'package:flutter/material.dart';

import '../bloc/employee_bloc.dart';

class EmployeeBlocProvider extends InheritedWidget {
  final EmployeeBloc employeeBloc;

  const EmployeeBlocProvider({
    Key? key,
    required this.employeeBloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(EmployeeBlocProvider oldWidget) {
    return oldWidget.employeeBloc != employeeBloc;
  }

  static EmployeeBloc of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<EmployeeBlocProvider>();
    if (provider == null) {
      throw FlutterError(
          'EmployeeBlocProvider não encontrado na árvore de widgets.');
    }
    return provider.employeeBloc;
  }
}
