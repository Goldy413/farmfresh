import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/ui/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Account",
            style: textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      color: Theme.of(context).colorScheme.background,
                      width: 1.sw,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 1.sw,
                          ),
                          CircleAvatar(
                            radius: 45.0,
                            backgroundImage: NetworkImage(AppStorage()
                                    .userDetail
                                    ?.profilePic ??
                                'https://tastevibe.web.app/assets/images/placeholder-user.png'),
                            backgroundColor: Colors.grey.withOpacity(0.2),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            AppStorage().userDetail?.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.mail,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                AppStorage().userDetail?.email ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.phone_circle,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                AppStorage().userDetail?.phoneNumber ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons
                                    .line_horizontal_3_decrease_circle,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Bio : ${AppStorage().userDetail?.bio ?? ""}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  CustomButton(
                    text: "Logout",
                    onPressed: () => {},
                  )
                ])));
  }
}
