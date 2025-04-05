part of utils;


const String graphicsPath = "assets/images";
const String iconPath = "assets/icons";

class ImageUtil{
 static ImageClass imageClass = ImageClass();
 static IconImageClass iconImageClass = IconImageClass();
}


class ImageClass{
  Widget get noFoundImage => const AssetsImagePictures(assetName: "$graphicsPath/no_found.png", fit: BoxFit.cover);
}

class IconImageClass{
  Widget get calenderIcon => const CustomSvgPictures.asset("$iconPath/calender.svg", fit: BoxFit.cover);
  Widget get dropDownIcon => const CustomSvgPictures.asset("$iconPath/drop_down.svg", fit: BoxFit.cover);
  Widget get jobIcon => const CustomSvgPictures.asset("$iconPath/job.svg", fit: BoxFit.cover);
  Widget get profileIcon => const CustomSvgPictures.asset("$iconPath/profile.svg", fit: BoxFit.cover);
  Widget get rightArrowIcon => const CustomSvgPictures.asset("$iconPath/right_arrow.svg", fit: BoxFit.cover);
  Widget get deleteIcon => const CustomSvgPictures.asset("$iconPath/delete_icon.svg", fit: BoxFit.cover);
}


class CustomSvgPictures extends StatelessWidget {
  const CustomSvgPictures.asset(
      this.assetName, {
        Key? key,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.alignment = Alignment.center,
        this.color
      }) : super(key: key);

  final double? width;
  final Color? color;
  final String assetName;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      color: color,
      placeholderBuilder: (context) {
        return const SizedBox.shrink();
      },
    );
  }
}

class AssetsImagePictures extends StatelessWidget {
  final double? width;
  final Color? color;
  final String assetName;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  const AssetsImagePictures({Key? key, required this.assetName, this.width, this.color, this.height, this.fit, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetName,
    fit: fit,
     color: color,
     width: width,
     height: height,
     alignment: alignment ?? Alignment.center,
    );
  }
}



