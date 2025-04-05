import 'package:hive/hive.dart';
import '../model/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_realtime_innovation/app/home/logic/employee_state.dart';


// class EmployeeCubit extends Cubit<EmployeeState> {
//   EmployeeCubit() : super(EmployeeState.initial());
//
//   void addEmployee(Employee employee) {
//     final newEmployee = employee.copyWith(id: UniqueKey().toString());
//     emit(state.copyWith(
//       employees: [...state.employees, newEmployee],
//     ));
//   }
//
//   void removeEmployee({required String id, required DateTime endDate, required bool isCurrentList,}) {
//     final currentList = List<Employee>.from(state.employees);
//     final previousList = List<Employee>.from(state.previousEmployees);
//
//     final employeeIndex = currentList.indexWhere((e) => e.id == id);
//     final previousIndex = previousList.indexWhere((e) => e.id == id);
//
//     if (isCurrentList && employeeIndex != -1) {
//       currentList.removeAt(employeeIndex);
//     } else if (!isCurrentList && previousIndex != -1) {
//       previousList.removeAt(previousIndex);
//     }
//
//     emit(state.copyWith(
//       employees: currentList,
//       previousEmployees: previousList,
//     ));
//   }
//
//   void updateEmployee({required Employee updatedEmployee}) {
//     final currentList = List<Employee>.from(state.employees);
//     final previousList = List<Employee>.from(state.previousEmployees);
//
//     final index = currentList.indexWhere((e) => e.id == updatedEmployee.id);
//
//     if (index != -1) {
//       currentList.removeAt(index);
//       if (updatedEmployee.endDate != null) {
//         previousList.add(updatedEmployee);
//       } else {
//         currentList.insert(index, updatedEmployee);
//       }
//
//       emit(state.copyWith(
//         employees: currentList,
//         previousEmployees: previousList,
//       ));
//     }
//   }
//
//
//   List<Employee> get activeEmployees => state.employees;
//   List<Employee> get previousEmployees => state.previousEmployees;
// }

class EmployeeCubit extends Cubit<EmployeeState> {
  final Box<Employee> currentBox = Hive.box<Employee>('currentEmployees');
  final Box<Employee> previousBox = Hive.box<Employee>('previousEmployees');

  EmployeeCubit() : super(EmployeeState.initial()) {
    _loadData();
  }

  void _loadData() {
    emit(EmployeeState(
      employees: currentBox.values.toList(),
      previousEmployees: previousBox.values.toList(),
    ));
  }

  void addEmployee(Employee employee) {
    final newEmployee = employee.copyWith(id: UniqueKey().toString());
    currentBox.put(newEmployee.id, newEmployee);
    _loadData();
  }

  void removeEmployee({required String id, required DateTime endDate, required bool isCurrentList}) {
    if (isCurrentList) {
      currentBox.delete(id);
    } else {
      previousBox.delete(id);
    }
    _loadData();
  }

  void updateEmployee({required Employee updatedEmployee}) {
    final existsInCurrent = currentBox.containsKey(updatedEmployee.id);

    if (existsInCurrent) {
      currentBox.delete(updatedEmployee.id);
    }

    if (updatedEmployee.endDate != null) {
      previousBox.put(updatedEmployee.id, updatedEmployee);
    } else {
      currentBox.put(updatedEmployee.id, updatedEmployee);
    }

    _loadData();
  }

  List<Employee> get activeEmployees => currentBox.values.toList();
  List<Employee> get previousEmployees => previousBox.values.toList();
}

