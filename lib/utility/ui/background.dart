import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Background extends StatelessWidget {
  final bool showBackButton;
  const Background(this.showBackButton, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 0.3.sw >= 0.3.sh ? 0.3.sh : 0.3.sw,
              height: 0.3.sw >= 0.3.sh ? 0.3.sh : 0.3.sw,
              decoration: BoxDecoration(
                color: const Color(0XFF06602E),
                borderRadius: BorderRadius.only(
                    bottomRight:
                        Radius.circular(0.5.sw >= 0.5.sh ? 0.5.sh : 0.5.sw)),
              ),
            )),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 0.5.sw >= 0.5.sh ? 0.5.sh : 0.5.sw,
              height: 0.5.sw >= 0.5.sh ? 0.5.sh : 0.5.sw,
              decoration: BoxDecoration(
                color: const Color(0XFF237f53),
                borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(0.5.sw >= 0.5.sh ? 0.5.sh : 0.5.sw)),
              ),
            )),
        Positioned(
            bottom: 0,
            // left: 0,
            child: Image.asset(ImageConstants.vegitableboy)),
        // Positioned(
        //     bottom: 0,
        //     right: 0,
        //     child: Container(
        //       width: 0.2.sw >= 0.2.sh ? 0.2.sh : 0.2.sw,
        //       height: 0.4.sw >= 0.4.sh ? 0.4.sh : 0.4.sw,
        //       decoration: BoxDecoration(
        //         color: const Color(0XFF85BD9F),
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(1.sw >= 1.sh ? 1.sh : 1.sw),
        //             bottomLeft: Radius.circular(1.sw >= 1.sh ? 1.sh : 1.sw)),
        //       ),
        //     )),
        showBackButton
            ? Positioned(
                // top: 20,
                left: 10,
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.green,
                    ),
                    onPressed: () => context.pop(),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
