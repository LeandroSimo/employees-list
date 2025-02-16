import 'package:collaborators_table/src/core/errors/exceptions.dart';
import 'package:collaborators_table/src/core/utils/constants.dart';
import 'package:dio/dio.dart';

import '../../core/network/api_employees.dart';
import '../models/employee_model.dart';

class EmployeeRemoteDataSource {
  final ApiEmployees apiEmployees;

  EmployeeRemoteDataSource(this.apiEmployees);

  Future<List<EmployeeModel>> getEmployees() async {
    try {
      final response =
          await apiEmployees.dio.get(ApiConstants.employeesEndoint);
      return (response.data as List)
          .map((employee) => EmployeeModel.fromJson(employee))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Timeout de conexão');
      } else {
        throw ServerException('Erro no servidor: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Erro inesperado: $e');
    }
  }
}
