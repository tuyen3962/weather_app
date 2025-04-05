import 'package:flutter/material.dart';
import 'package:weather_app/constant/app_color.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.errorBgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Something went wrong at our end!',
                style: TextStyle(color: AppColor.bgColor, fontSize: 54)),
            SizedBox(height: 44),
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: AppColor.buttonBgColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text('Retry',
                    style: TextStyle(
                        color: AppColor.bgColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
