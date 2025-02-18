abstract class EmployeeEvent {}

class GetEmployeesEvent extends EmployeeEvent {}

class FilterEmployeesEvent extends EmployeeEvent {
  final String query;

  FilterEmployeesEvent(this.query);
}
