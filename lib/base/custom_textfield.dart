part of 'base.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const CustomFormField({super.key,this.controller,this.focusNode});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.sp,
      child: TextFormField(
        // cursorHeight: 24.sp,
        controller: widget.controller ,
        focusNode: widget.focusNode,
        cursorColor: kTextPrimaryColor.withValues(alpha: 0.5),
        decoration: InputDecoration(
          hintText: "Employee Name",
          hintStyle: CustomTextStyle.regularFont16Style.copyWith(color: kTextSecondaryColor),
          contentPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: kTextFiledBorderColor, width: 1.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kTextFiledBorderColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kTextFiledBorderColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kTextFiledBorderColor, width: 1.0),
          ),
          prefixIcon: Padding(
            padding:  EdgeInsets.all(12.sp),
            child: ImageUtil.iconImageClass.profileIcon,
          ),
        ),
        style: CustomTextStyle.regularFont16Style,
      ),
    );
  }
}
