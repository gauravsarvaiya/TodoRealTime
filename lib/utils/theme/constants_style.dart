part of utils;

extension CustomTextStyle on TextStyle{

  static TextStyle get regularFont16Style=> TextStyle(
      color: kTextPrimaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400
  );

  static TextStyle get mediumFont18Style=> TextStyle(
      color: kWhiteColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500
  );

  static TextStyle get mediumFont14Style=> TextStyle(
      color: kWhiteColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500
  );
  }