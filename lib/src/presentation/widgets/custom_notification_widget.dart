import 'package:collaborators_table/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomNotificationWidget extends StatelessWidget {
  const CustomNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            size: 35,
          ),
        ),
        Positioned(
          right: 2,
          top: 3,
          child: Container(
            height: context.mediaQuery.width * 0.06,
            width: context.mediaQuery.width * 0.06,
            decoration: BoxDecoration(
              color: Color(0XFF0500FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "02",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
