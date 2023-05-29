import 'dart:io';

import 'package:farmfresh/module/profile_module/profile/profile_bloc.dart';
import 'package:farmfresh/module/profile_module/profile_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/ui/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  final picker = ImagePicker();
  final String phone;
  final String id;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  ProfileView({super.key, required this.phone, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
        child: Center(
          child: RepositoryProvider(
            create: (context) => ProfileRepository(),
            child: BlocProvider(
              create: (context) => ProfileBloc(context.read()),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final bloc = context.read<ProfileBloc>();
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async => {
                          await picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) =>
                                  {bloc.add(SelectImageEvent(value))})
                        },
                        child: bloc.image == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(File(bloc.image!.path)),
                                radius: 50,
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is ProfileErrorState
                          ? Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        // margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // name field
                            textFeld(
                              hintText: "Enter your name",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // email
                            textFeld(
                              hintText: "Enter your email",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),
                            // bio
                            textFeld(
                              hintText: "Enter your bio here...",
                              icon: Icons.edit,
                              inputType: TextInputType.name,
                              maxLines: 2,
                              controller: bioController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: BlocListener<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                            if (state is MovetoHomeState) {
                              context.go(AppPaths.tabbar);
                            }
                          },
                          child: CustomButton(
                            text: state is ProfileLoadingState
                                ? "Loading..."
                                : "Continue",
                            onPressed: () => {
                              if (state is! ProfileLoadingState)
                                {
                                  bloc.add(AddProfileEvent(
                                      id,
                                      nameController.text,
                                      emailController.text,
                                      bioController.text,
                                      phone))
                                }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.green,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.green.shade50,
          filled: true,
        ),
      ),
    );
  }
}
