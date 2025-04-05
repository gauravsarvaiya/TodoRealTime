import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../logic/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_realtime_innovation/base/base.dart';
import 'package:todo_realtime_innovation/utils/utils.dart';
import 'package:todo_realtime_innovation/app/home/logic/employee_state.dart';
import 'package:todo_realtime_innovation/app/home/screen/add_employee_details.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.red, // Desired color
          statusBarIconBrightness: Brightness.light, // For white icons
        ),
    child: Scaffold(
      backgroundColor: screenBGColor,
       appBar: AppBar(
         backgroundColor: kPrimaryColor,
           centerTitle: false,
           title: Text("Employee List",
               style: CustomTextStyle.mediumFont18Style
           ),
       ),
       body: Stack(
         children: [
           BlocBuilder<EmployeeCubit, EmployeeState>(
             builder: (context, state) {
               if ((state.employees.isEmpty && state.previousEmployees.isEmpty)) {
                 return noDataFound();
               }
               return Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height,
                 child: Column(
                   children: [
                     if(state.employees.isNotEmpty)
                     Container(
                         width: MediaQuery.of(context).size.width,
                         color: Color(0xffF2f2f2),
                         padding: EdgeInsets.symmetric(vertical: 16.sp,horizontal: 16.sp),
                         child: Text("Current Employee",style: CustomTextStyle.mediumFont18Style.copyWith(fontSize: 16.sp,color: kPrimaryColor),)
                     ),
                     Expanded(
                       child: ListView.builder(
                         itemCount: state.employees.length,
                         itemBuilder: (context, index) {
                           final employee = state.employees[index];
                           return Dismissible(
                             key: Key(employee.id ?? ""),
                             background: Container(color: Colors.red, child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 ImageUtil.iconImageClass.deleteIcon,
                                 SizedBox(width:
                                   10.sp,)
                               ],
                             )),
                             onDismissed: (_) {
                               context.read<EmployeeCubit>().removeEmployee(
                                 isCurrentList: true,
                                 id: employee.id ?? "",
                                 endDate: DateTime.now(),
                               );
                               customToast(context: context, msg: '${employee.name} removed');
                             },
                             direction: DismissDirection.endToStart,
                             child: GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                                   return AddEmployeeDetails(employee: employee,isUpdate: true,);
                                 },));
                               },
                               child: Container(
                                 width: double.infinity,
                                 color: kWhiteColor,
                                 padding: EdgeInsets.all(16.sp),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   spacing: 6.sp,
                                   children: [
                                     Text(employee.name,style: CustomTextStyle.mediumFont18Style.copyWith(color: kTextPrimaryColor)),
                                     Text(employee.role,style: CustomTextStyle.regularFont16Style.copyWith(color: kTextSecondaryColor)),
                                     Text("From ${DateFormat('d MMM, yyyy').format(employee.startDate)}",style: CustomTextStyle.regularFont16Style.copyWith(color: kTextSecondaryColor,fontSize: 14.sp),),
                                   ],
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                     // =================
                     if(state.previousEmployees.isNotEmpty)
                     Container(
                         width: MediaQuery.of(context).size.width,
                         color: Color(0xffF2f2f2),
                         padding: EdgeInsets.symmetric(vertical: 16.sp,horizontal: 16.sp),
                         child: Text("Previous Employees",style: CustomTextStyle.mediumFont18Style.copyWith(fontSize: 16.sp,color: kPrimaryColor),)
                     ),
                     Expanded(
                       child: ListView.builder(
                         itemCount: state.previousEmployees.length,
                         itemBuilder: (context, index) {
                           final employee = state.previousEmployees[index];
                           return Dismissible(
                             direction: DismissDirection.endToStart,
                             key: Key(employee.id ?? ""),
                             background: Container(color: Colors.red, child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 ImageUtil.iconImageClass.deleteIcon,
                                 SizedBox(width:
                                 10.sp,)
                               ],
                             )),
                             onDismissed: (_) {
                               context.read<EmployeeCubit>().removeEmployee(
                                 isCurrentList: false,
                                 id: employee.id ?? "",
                                 endDate: DateTime.now(),
                               );
                               customToast(context: context, msg: '${employee.name} removed');
                             },
                             child: GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                                   return AddEmployeeDetails(employee: employee,isUpdate: true,);
                                 },));
                               },
                               child: Container(
                                 width: double.infinity,
                                 color: kWhiteColor,
                                 padding: EdgeInsets.all(16.sp),
                                 margin: EdgeInsets.only(bottom: 1.sp),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   spacing: 6.sp,
                                   children: [
                                     Text(employee.name,style: CustomTextStyle.mediumFont18Style.copyWith(color: kTextPrimaryColor)),
                                     Text(employee.role,style: CustomTextStyle.regularFont16Style.copyWith(color: kTextSecondaryColor)),
                                     Text("${DateFormat('d MMM, yyyy').format(employee.startDate)} - ${DateFormat('d MMM, yyyy').format(employee.endDate ?? DateTime.now())} ",
                                       style: CustomTextStyle.regularFont16Style.copyWith(color: kTextSecondaryColor,fontSize: 14.sp),),
                                   ],
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),

                   ],
                 )
               );
             }
           ),
           Positioned(
             bottom: 10.sp,
               right: 24.sp,
               child: CustomFloatingBtn(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => AddEmployeeDetails()),
                   );
                 },
               )
           )
         ],
       ),
    ));
  }
}

Widget noDataFound(){
  return Container(
    width: double.infinity,
    color: Color(0xffF2F2F2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 230.sp,
            width: 230.sp,
            child: ImageUtil.imageClass.noFoundImage
        ),
        SizedBox(height: 100.sp),
      ],
    ),
  );
}

