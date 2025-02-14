import 'package:collaborators_table/src/domain/entities/employee_entity.dart';

import '../../core/errors/exceptions.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasource/employee_remote_data_source.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    try {
      final employes = await remoteDataSource.getEmployees();
      return employes.map((employee) => employee.toEntity()).toList();
    } on ServerException catch (e) {
      throw e.message;
    } on NetWorkException catch (e) {
      throw e.message;
    }
  }
}
