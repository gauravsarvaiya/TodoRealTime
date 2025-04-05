part of 'base.dart';

class CustomAppBtn extends StatefulWidget {
  String? textName;
  Color? color;
  Color? textColor;
  GestureTapCallback? onTap;

  CustomAppBtn({super.key,this.onTap,this.textColor,this.color,this.textName});

  @override
  State<CustomAppBtn> createState() => _CustomAppBtnState();
}

class _CustomAppBtnState extends State<CustomAppBtn> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.sp),
      child: Material(
        color: widget.color ?? kSecondaryColor,
        child: InkWell(
          splashColor: kWhiteColor.withValues(alpha: 0.2),
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21.sp,vertical: 12),
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            child: Text(widget.textName ?? "",
              style: CustomTextStyle.mediumFont14Style.copyWith(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
