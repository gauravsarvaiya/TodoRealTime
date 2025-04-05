import 'package:flutter/material.dart';
import 'app/home/logic/employee_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/home/screen/employee_list_screen.dart';
import 'package:todo_realtime_innovation/utils/utils.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<EmployeeCubit>(
                  create: (context) => EmployeeCubit(),
                ),
              ],
              child: MaterialApp(
            title: 'TODO APP',
            theme: appTheme(context),
            debugShowCheckedModeBanner: false,
            home:EmployeeListScreen(),
          )
          );
        },
      ),
    );
  }
}

ThemeData appTheme(BuildContext context){
  return ThemeData(
      appBarTheme: AppBarTheme.of(context).copyWith(
          centerTitle: false,
          toolbarHeight: kToolbarHeight,
          titleTextStyle: TextStyle(
              color: kTextSecondaryColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto"
          ),
          shape:  UnderlineInputBorder(
            borderSide: BorderSide(color: kTextSecondaryColor.withOpacity(0.30)),
          )
      ),
      scaffoldBackgroundColor: kWhiteColor,
      primarySwatch: primarySwatchColor,
      useMaterial3: true,
      fontFamily: "Roboto",

  );
}