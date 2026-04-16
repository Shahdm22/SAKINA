import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sakina/core/theme/app_colors.dart';

class Customtextrich extends StatelessWidget {
  const Customtextrich({
    super.key,
    this.textTitle,
    required this.textButton,
    this.tapped,
  });

  final String? textTitle;
  final String textButton;
  final void Function()? tapped;

  @override
  Widget build(BuildContext context) {
    // default label style
    final defaultStyle = Theme.of(context).textTheme.labelMedium;

    return Text.rich(
      TextSpan(
        // first text
        text: textTitle != null ? '$textTitle ' : '',
        style: defaultStyle, 
        children: [
          TextSpan(
            text: textButton,
            // second text
            style: defaultStyle?.copyWith(
              color: AppColors.primaryBrown,
              fontWeight: FontWeight.bold, 
            ),
            recognizer: TapGestureRecognizer()..onTap = tapped,
          ),
        ],
      ),
    );
  }
}