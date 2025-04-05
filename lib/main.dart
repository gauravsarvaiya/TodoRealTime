import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_realtime_innovation/app.dart';
import 'app/home/model/employee_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(EmployeeAdapter());

  await Hive.openBox<Employee>('currentEmployees');
  await Hive.openBox<Employee>('previousEmployees');

  runApp(TodoApp());
}

