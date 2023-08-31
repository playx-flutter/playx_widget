import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget that shows an icon from icon data, svg, image or text.
// ignore: must_be_immutable
class IconViewer extends StatelessWidget {
  IconData? icon;

  String? svgIcon;
  String? iconImage;
  String? text;
  final bool isSelected;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? selectedIconColor;
  final Color? selectedIconBackgroundColor;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? iconSize;

  IconViewer({
    this.icon,
    this.svgIcon,
    this.iconImage,
    this.text,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.transparent,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width,
    this.height,
    this.iconSize,
  });

  IconViewer.icon({
    this.icon,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.transparent,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width,
    this.height,
    this.iconSize,
  });

  IconViewer.svg({
    this.svgIcon,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.transparent,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width,
    this.height,
    this.iconSize,
  });

  IconViewer.assetImage({
    this.iconImage,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.transparent,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width,
    this.height,
    this.iconSize,
  });

  IconViewer.text({
    this.text,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.transparent,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width,
    this.height,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidth = width ?? 30.w;
    final iconHeight = height ?? 30.h;
    final size = Size.fromRadius(iconSize ?? 20.r);
    if (icon != null) {
      return isSelected
          ? Container(
              width: iconWidth,
              height: iconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
                //  color: Color(0xFFF0F3F8),
              ),
              child: Icon(
                icon,
                color: selectedIconColor,
                key: key,
                size: iconSize,
              ),
            )
          : Container(
              width: iconWidth,
              height: iconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              child: Icon(
                icon,
                color: iconColor,
                key: key,
                size: iconSize,
              ),
            );
    } else if (svgIcon != null) {
      return isSelected
          ? Container(
              width: fit == BoxFit.cover ? null : width,
              height: fit == BoxFit.cover ? null : height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
                //  color: Color(0xFFF0F3F8),
              ),
              child: SvgPicture.asset(
                svgIcon!,
                width: fit == BoxFit.cover ? null : size.width,
                height: fit == BoxFit.cover ? null : size.height,
                colorFilter: selectedIconColor == null
                    ? null
                    : ColorFilter.mode(
                        selectedIconColor!,
                        BlendMode.srcIn,
                      ),
                fit: fit,
                key: key,
              ),
      )
          : Container(
              width: fit == BoxFit.cover ? null : width,
              height: fit == BoxFit.cover ? null : height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              child: SvgPicture.asset(
                svgIcon!,
                width: fit == BoxFit.cover ? null : size.width,
                height: fit == BoxFit.cover ? null : size.height,
                colorFilter: iconColor == null
                    ? null
                    : ColorFilter.mode(
                        iconColor!,
                        BlendMode.srcIn,
                      ),
                fit: fit,
                key: key,
              ),
            );
    } else if (iconImage != null) {
      return isSelected
          ? Container(
              width: iconWidth,
              height: iconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
              ),
              child: Image.asset(
                iconImage!,
                color: selectedIconColor,
                key: key,
              ),
            )
          : Image.asset(
              iconImage!,
              color: iconColor,
              key: key,
            );
    } else if (text != null) {
      return isSelected
          ? Container(
              width: iconWidth,
              height: iconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(2.r),
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 8.sp,
                  color: selectedIconColor,
                ),
              ),
            )
          : Container(
              width: iconWidth,
              height: iconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(2.r),
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 8.sp,
                  color: iconColor,
                ),
              ),
            );
    } else {
      return Container();
    }
  }
}
