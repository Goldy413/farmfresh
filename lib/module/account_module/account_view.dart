import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0XFFBFD1DF),
        expandedHeight: 380,
        floating: true,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Positioned(
                  child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0)),
                    color: Theme.of(context).colorScheme.secondary),
              )),
              Positioned.fill(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  InkWell(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55.0,
                          backgroundImage: NetworkImage(AppStorage()
                                  .userDetail
                                  ?.profilePic ??
                              'https://tastevibe.web.app/assets/images/placeholder-user.png'),
                          backgroundColor: Colors.grey.withOpacity(0.2),
                        ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit_outlined),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppStorage().userDetail?.name ?? "",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Text(
                      AppStorage().userDetail?.email ?? "",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          padding: const EdgeInsets.all(5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Account',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                context.push(AppPaths.order);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.add_box_outlined,
                  size: 28,
                  color: Colors.black,
                ),
                title: Text(
                  "Order History",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                subtitle: Text(
                  "Click to view order history",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.grey),
              ),
            ),
            InkWell(
              onTap: () {
                //context.pushNamed(AppPaths.pinset);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.pin_outlined,
                  size: 28,
                  color: Colors.black,
                ),
                title: Text(
                  "Change PIN",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                subtitle: Text(
                  "Click to change PIN",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.grey),
              ),
            ),
            InkWell(
              onTap: () {
                //context.pushNamed(AppPaths.policy);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.policy_outlined,
                  size: 28,
                  color: Colors.black,
                ),
                title: Text(
                  "Policy",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                subtitle: Text(
                  "Click to check policy",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.grey),
              ),
            ),
            InkWell(
              onTap: () {
                // context.pushNamed(AppPaths.aboutUs);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  size: 28,
                  color: Colors.black,
                ),
                title: Text(
                  "About Us",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                subtitle: Text(
                  "Click to know about us",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.grey),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 100)
      ]))
    ]));
  }
}
