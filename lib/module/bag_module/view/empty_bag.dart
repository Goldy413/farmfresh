import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: 1.sw / (2 / (1.sh / 1.sw)),
        height: 1.sw / (2 / (1.sh / 1.sw)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(ImageConstants.emptyCart,
                  width: 300, height: 300),
            ),
            Positioned.fill(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                Text('Your bag is empty',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                      'Looks like you haven’t added any items to the bag yet. Start shopping to fill it in.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 50)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
