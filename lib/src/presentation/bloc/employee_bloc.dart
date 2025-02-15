import 'dart:async';

import '../../domain/repositories/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc {
  final EmployeeRepository _employeeRepository;

  final _eventController = StreamController<EmployeeEvent>();
  StreamSink<EmployeeEvent> get eventSink => _eventController.sink;
  Stream<EmployeeEvent> get _eventStream => _eventController.stream;

  final _stateController = StreamController<EmployeeState>();
  StreamSink<EmployeeState> get _stateSink => _stateController.sink;
  Stream<EmployeeState> get stateStream => _stateController.stream;

  EmployeeBloc(this._employeeRepository) {
    _eventStream.listen((event) {
      if (event is GetEmployeesEvent) {
        _getEmployees();
      }
    });
  }

  Future<void> _getEmployees() async {
    _stateSink.add(EmployeeLoading());

    try {
      final employees = await _employeeRepository.getEmployees();
      _stateSink.add(EmployeeLoaded(employees));
    } catch (e) {
      _stateSink.add(EmployeeError(e.toString()));
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
