import 'package:collaborators_table/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/employee_entity.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_state.dart';

class ListOfEmployess extends StatelessWidget {
  final EmployeeBloc employeeBloc;
  const ListOfEmployess({super.key, required this.employeeBloc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 0.93,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFE6E2E2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: context.mediaQuery.height * 0.07,
                width: context.mediaQuery.width,
                padding: EdgeInsets.all(context.mediaQuery.width * 0.03),
                decoration: BoxDecoration(
                  color: Color(0xFFEDEFFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 4,
                      child: Text(
                        "Foto",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 4,
                      child: Text(
                        "Nome",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: -8,
                      child: Text(
                        "•",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<EmployeeState>(
                  stream: employeeBloc.stateStream,
                  builder: (context, snapshot) {
                    return _buildUI(snapshot);
                  },
                ),
              ),
            ],
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
      physics: const ClampingScrollPhysics(),
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
