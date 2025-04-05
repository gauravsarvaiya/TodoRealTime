import '../model/employee_model.dart';

class EmployeeState {
  final List<Employee> employees;
  final List<Employee> previousEmployees;

  EmployeeState({
    required this.employees,
    required this.previousEmployees,
  });

  factory EmployeeState.initial() {
    return EmployeeState(employees: [], previousEmployees: []);
  }

  EmployeeState copyWith({
    List<Employee>? employees,
    List<Employee>? previousEmployees,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      previousEmployees: previousEmployees ?? this.previousEmployees,
    );
  }
}
