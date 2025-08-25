import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color> colors;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.colors,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.darkSecondaryColor, // let gradient show
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 10,left: 10,right: 0,top: 10), // we’ll handle padding inside gradient
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
