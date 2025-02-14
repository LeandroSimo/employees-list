import '../entities/employee_entity.dart';

abstract class EmployeRepository {
  Future<List<EmployeeEntity>> getEmployes();
}
