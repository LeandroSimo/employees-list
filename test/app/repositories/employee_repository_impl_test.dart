import 'package:collaborators_table/src/core/errors/exceptions.dart';
import 'package:collaborators_table/src/domain/entities/employee_entity.dart';
import 'package:mockito/annotations.dart';

import 'package:collaborators_table/src/data/repositories/employee_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([EmployeeRepositoryImpl])
import 'employee_repository_impl_test.mocks.dart';

void main() {
  late EmployeeRepositoryImpl repository;

  setUp(() {
    repository = MockEmployeeRepositoryImpl();
  });

  final tEmployeeEntity = EmployeeEntity(
    id: '1',
    name: 'Test',
    job: 'Test',
    admissionDate: '2021-09-01',
    phone: '123456789',
    image: 'https://test.com',
  );

  final tEmployeeEntityList = [tEmployeeEntity];

  group('getEmployees', () {
    test(
        'deve retornar uma lista de EmployeeEntity quando a chamada para a fonte de dados remota for bem-sucedida',
        () async {
      // Arrange
      when(repository.getEmployees())
          .thenAnswer((_) async => tEmployeeEntityList);

      // Act
      final result = await repository.getEmployees();

      // Assert
      expect(result, tEmployeeEntityList);
      verify(repository.getEmployees()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('deve lançar NetWorkException quando houver um erro de rede',
        () async {
      // Arrange
      when(repository.getEmployees())
          .thenThrow(NetworkException('Timeout de conexão'));

      // Act
      final call = repository.getEmployees;

      // Assert
      expect(() => call(), throwsA(isA<NetworkException>()));
      verify(repository.getEmployees()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test(
        'deve retornar uma lista vazia quando nenhum funcionário for encontrado',
        () async {
      // Arrange
      when(repository.getEmployees())
          .thenAnswer((_) async => []); // Retorna uma lista vazia

      // Act
      final result = await repository.getEmployees();

      // Assert
      expect(result, []);
      verify(repository.getEmployees()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
