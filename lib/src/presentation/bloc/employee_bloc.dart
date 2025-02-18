import 'dart:async';

import '../../domain/entities/employee_entity.dart';
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

  List<EmployeeEntity> _allEmployees = [];

  EmployeeBloc(this._employeeRepository) {
    _eventStream.listen((event) {
      if (event is GetEmployeesEvent) {
        _getEmployees();
      } else if (event is FilterEmployeesEvent) {
        _mapFilterEmployeesEventToState(event);
      }
    });
  }

  Future<void> _getEmployees() async {
    _stateSink.add(EmployeeLoading());

    try {
      _allEmployees = await _employeeRepository.getEmployees();
      _stateSink.add(EmployeeLoaded(_allEmployees));
    } catch (e) {
      _stateSink.add(EmployeeError(e.toString()));
    }
  }

  Future<void> _mapFilterEmployeesEventToState(
      FilterEmployeesEvent event) async {
    final query = event.query.toLowerCase();

    final filteredEmployees = _allEmployees.where((employee) {
      return employee.name.toLowerCase().contains(query) ||
          employee.job.toLowerCase().contains(query) ||
          employee.phone.contains(query);
    }).toList();

    _stateSink.add(EmployeeLoaded(filteredEmployees));
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
