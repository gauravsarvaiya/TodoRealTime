// Font Sizes
part of utils;

const int primaryColorValue = 0xffEC2A24;
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kPrimaryColor = Color(0xff1DA1F2);
const Color kTextPrimaryColor = Color(0xff323238);
const Color kSecondaryColor = Color(0xffEDF8FF);
const Color kTextSecondaryColor = Color(0xff949C9E);
const Color kTextFiledBorderColor = Color(0xFFE5E5E5);
const Color kBlackColor = Color(0xff000000);
const Color transparentColor = Color(0x00000000);
const Color screenBGColor = Color(0xfff2f2f2);


final primarySwatchColor = MaterialColor(primaryColorValue, <int, Color>{
  50: const Color(primaryColorValue).withValues(alpha: 0.05),//10%
  100: const Color(primaryColorValue).withValues(alpha: 0.10),//20%
  200: const Color(primaryColorValue).withValues(alpha: 0.20),//30%
  300: const Color(primaryColorValue).withValues(alpha: 0.30),//40%
  400: const Color(primaryColorValue).withValues(alpha: 0.40),//50%
  500: const Color(primaryColorValue).withValues(alpha: 0.50),//60%
  600: const Color(primaryColorValue).withValues(alpha: 0.60),//70%
  700: const Color(primaryColorValue).withValues(alpha: 0.70),//80%
  800: const Color(primaryColorValue).withValues(alpha: 0.80),//90%
  900: const Color(primaryColorValue).withValues(alpha: 0.90),//100%
});


double kFont_18 = 18.sp;
double kFont_16 = 16.sp;
double kFont_14 = 14.sp;
double kFont_12 = 12.sp;
double kFont_13 = 13.sp;
double kFont_25 = 25.sp;
double kFont_20 = 20.sp;
double kFont_35 = 35.sp;
double kFont_24 = 24.sp;
double kFont_10 = 10.sp;

int kDummySecond = 1;
