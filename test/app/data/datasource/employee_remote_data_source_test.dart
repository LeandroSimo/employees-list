import 'package:mockito/annotations.dart';
import 'package:collaborators_table/src/core/network/api_employees.dart';
import 'package:collaborators_table/src/core/utils/constants.dart';
import 'package:collaborators_table/src/data/datasource/employee_remote_data_source.dart';
import 'package:collaborators_table/src/data/models/employee_model.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([ApiEmployees, Dio])
import 'employee_remote_data_source_test.mocks.dart';

void main() {
  late EmployeeRemoteDataSource dataSource;
  late MockDio mockDio;
  late MockApiEmployees mockApiEmployees;

  setUp(() {
    mockDio = MockDio();
    mockApiEmployees = MockApiEmployees();

    when(mockApiEmployees.dio).thenReturn(mockDio);

    dataSource = EmployeeRemoteDataSource(mockApiEmployees);
  });

  final tEmployees = [
    {
      "id": "1",
      "name": "João",
      "job": "Back-end",
      "admission_date": "2019-12-02T00:00:00.000Z",
      "phone": "5551234567890",
      "image": "https://example.com/image.jpg",
    }
  ];

  test(
      'Deve retornar uma lista de EmployeeModel quando a chamada à API for bem-sucedida',
      () async {
    // Arrange
    when(mockDio.get(ApiConstants.employeesEndoint)).thenAnswer(
      (_) async => Response(
        data: tEmployees,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiConstants.employeesEndoint),
      ),
    );

    final result = await dataSource.getEmployees();

    expect(result, isA<List<EmployeeModel>>());
    expect(result.first.id, "1");
    verify(mockDio.get(ApiConstants.employeesEndoint));
  });
}
