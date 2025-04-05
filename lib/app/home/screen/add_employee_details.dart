import 'package:intl/intl.dart';
import '../../../base/base.dart';
import '../../../utils/utils.dart';
import '../logic/employee_cubit.dart';
import '../model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDetails extends StatefulWidget {
  final Employee? employee;
  final bool? isUpdate;
  const AddEmployeeDetails({super.key, this.employee,this.isUpdate});

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  final TextEditingController nameController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  String selectedRole = "Select Role";
  DateTime? startDate;
  DateTime? endDate;

  List<String> dropDownDataList = [
    "Product Designer","Flutter Developer","QA Tester","Product Owner"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("====== employee?.name ${widget.employee?.role ?? ''} ===== check");
      if (widget.employee != null) {
        nameController.text = widget.employee!.name;
        selectedRole = widget.employee!.role;
        startDate = widget.employee!.startDate;
        endDate = widget.employee!.endDate;
      }
      setState(() {});
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: kWhiteColor),
        centerTitle: false,
        title: Text(widget.isUpdate == true ?" Update Employee Details": "Add Employee Details",
            style: CustomTextStyle.mediumFont18Style
        ),
        leadingWidth: 28.sp,
        actions: [
          if(widget.isUpdate == true)
          GestureDetector(
            onTap: (){
              print("hello");
              final employeeId = widget.employee?.id;
              if (employeeId == null || employeeId.isEmpty) {
                customToast(context: context, msg: "Employee ID not found!");
                return;
              }

              final isCurrent = context.read<EmployeeCubit>().activeEmployees.any((e) => e.id == employeeId);

              context.read<EmployeeCubit>().removeEmployee(
                id: employeeId,
                endDate: DateTime.now(),
                isCurrentList: isCurrent,
              );

              Navigator.pop(context);
            },
              child: Padding(
                padding: EdgeInsets.only(right: 20.sp),
                child: ImageUtil.iconImageClass.deleteIcon,
              )
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical:24.sp),
            child: Column(
              spacing: 23.sp,
              children: [
                CustomFormField(
                  controller: nameController,
                   focusNode: focusNode,
                ),

                InkWell(
                  splashColor: kPrimaryColor.withValues(alpha: 0.2),
                  onTap: (){
                    focusNode.unfocus();
                    dropDownModelSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.sp, horizontal: 12.sp
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: kTextFiledBorderColor)
                    ),
                    child: Row(
                      spacing: 10.sp,
                      children: [
                        ImageUtil.iconImageClass.jobIcon,
                        Expanded(child: Text(selectedRole,style: CustomTextStyle.regularFont16Style.copyWith(color: selectedRole == "Select Role" ? kTextSecondaryColor : kTextPrimaryColor))),
                        ImageUtil.iconImageClass.dropDownIcon,
                      ],),
                  ),
                ),

                Row(
                  spacing: 16.sp,
                  children: [
                    Expanded(
                      child: InkWell(
                        splashColor: kPrimaryColor.withValues(alpha: 0.1),
                        onTap: (){
                          showStartPicker(
                              initialDate: startDate ?? DateTime.now(),

                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: kTextFiledBorderColor)),
                          child: Row(children: [
                            ImageUtil.iconImageClass.calenderIcon,
                            SizedBox(width: 10.sp),
                            Expanded(child: Text(startDate == null ? "Start Date" : DateFormat('dd-MM-yyyy').format(startDate!).split(' ')[0],
                              style: CustomTextStyle.regularFont16Style.copyWith(color: startDate == null ? kTextSecondaryColor : kTextPrimaryColor),
                            )),
                          ],),
                        ),
                      ),
                    ),

                    ImageUtil.iconImageClass.rightArrowIcon,

                    Expanded(
                      child: InkWell(
                        splashColor: kPrimaryColor.withValues(alpha: 0.1),
                        onTap: (){
                          showEndPicker(
                              initialDate: endDate ?? DateTime.now(),
                              startDate: startDate ?? DateTime.now(),
                             // endDate: DateTime(2100),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: kTextFiledBorderColor)),
                          child: Row(children: [
                            ImageUtil.iconImageClass.calenderIcon,
                            SizedBox(width: 10.sp),
                            Expanded(child:
                            Text(endDate == null ? "End Date" : DateFormat('dd-MM-yyyy').format(endDate!).split(' ')[0],
                              style: CustomTextStyle.regularFont16Style.copyWith(color: endDate == null ? kTextSecondaryColor : kTextPrimaryColor),
                            )),
                          ],),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),

          Positioned(bottom: 0, left: 0, right: 0,
            child: SafeArea(
              child: Container(
                height: 64.sp,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: kTextFiledBorderColor,
                        offset: (Offset(-2, -2)),
                        blurRadius: 1,
                        blurStyle: BlurStyle.inner
                    )
                  ],
                ),
                child: Row(
                  spacing: 20.sp,
                  children: [

                    Expanded(
                      child: Container(
                        width: 1,
                      ),
                    ),

                    CustomAppBtn(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      textName: "Cancle",
                      textColor: kPrimaryColor,
                    ),

                    CustomAppBtn(
                        onTap: () {
                          if(nameController.text.isEmpty){
                            customToast(context: context,msg:"Please Enter Employee Name !!");
                            return;
                          }

                          if(selectedRole == "Select Role"){
                            customToast(context: context,msg:"Please Enter Employee Role !!");
                            return;
                          }

                          if(startDate == null){
                            customToast(context: context,msg:"Select Start Date");
                            return;
                          }

                          if (nameController.text.isNotEmpty && selectedRole != "Select Role") {
                            final newEmployee = Employee(
                              id: widget.isUpdate == true ? widget.employee!.id : UniqueKey().toString(),
                              name: nameController.text.trim(),
                              role: selectedRole,
                              startDate: startDate!,
                              endDate: endDate,
                            );
                            widget.isUpdate == true ?
                            context.read<EmployeeCubit>().updateEmployee(updatedEmployee: newEmployee):
                            context.read<EmployeeCubit>().addEmployee(newEmployee);
                            Navigator.pop(context);
                          }
                        },
                        textName: widget.isUpdate == true ?  "Update" : "Save" ,
                        color: kPrimaryColor
                    ),

                    SizedBox(width: 10.sp,)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showStartPicker({required DateTime initialDate}) async{
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: kWhiteColor,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: DatePickerWidget(
            initialDate: startDate ?? DateTime.now(),
            onDateSelected: (date) {
              setState(() {
                startDate = date;
                print("-=== ${date} = Date====== ${selectedDate} ={selectedDate}=");
              });
            },
          ),
        );
      },
    );
  }

  void showEndPicker({
    required DateTime initialDate,
    required DateTime startDate,
    // required DateTime endDate,
  }) async{
    showDialog(
      context: context,
      builder: (context) {
        final now = DateTime.now();
        final safeStartDate = startDate ?? now;
        final safeEndDate = endDate ?? now;
        final safeInitialDate =
        safeEndDate.isBefore(safeStartDate) ? safeStartDate : safeEndDate;
        return Dialog(
          backgroundColor: kWhiteColor,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: DatePickerWidget(
            initialDate: safeInitialDate,
            firstDate: safeStartDate,
            // lastDate: endDate,
            onDateSelected: (date) {
              setState(() {
                endDate = date;
                print("-=== ${date} = Date====== ${selectedDate} ={selectedDate}=");
              });
            },
          ),
        );
      },
    );
  }

  dropDownModelSheet(){
    return showModalBottomSheet(
      context: context, builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        child: Material(
          color: kWhiteColor,
          child: Container(
            width: double.infinity,
            height: 250.sp,
            child: Column(
              children: List.generate(dropDownDataList.length, (index) {
                return InkWell(
                  splashColor:kPrimaryColor.withValues(alpha: 0.1),
                  onTap: ()async{
                    Navigator.pop(context);

                    setState(() {
                      selectedRole = dropDownDataList[index];
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.sp),
                        child: Center(
                            child: Text(dropDownDataList[index],
                                style: CustomTextStyle.regularFont16Style
                            )
                        ),
                      ),
                      if(index != 3)
                        Divider(color: kTextFiledBorderColor,height: 1.sp),
                    ],
                  ),
                );
              },),
            ),
          ),
        ),
      );
    },
    );
  }
}

 customToast({required BuildContext context,required String msg}){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          content: SizedBox(
            child: SizedBox(
                height: 20.sp,
                child: Text(msg)),
          ))
  );
}



