part of 'base.dart';

class CustomFloatingBtn extends StatefulWidget {
  final GestureTapCallback? onTap;
  const CustomFloatingBtn({super.key,this.onTap});

  @override
  State<CustomFloatingBtn> createState() => _CustomFloatingBtnState();
}

class _CustomFloatingBtnState extends State<CustomFloatingBtn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.sp),
        child: Material(
          color: kPrimaryColor,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.all(16.sp),
              color: Colors.transparent,
              child: Icon(Icons.add, color: kWhiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
