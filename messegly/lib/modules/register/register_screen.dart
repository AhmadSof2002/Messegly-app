import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messegly/layouts/social_layout.dart';
import 'package:messegly/modules/register/regCubit/cubit.dart';
import 'package:messegly/modules/register/regCubit/states.dart';

import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/network/local/cache_helper.dart';
import 'package:messegly/shared/styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool? checkBoxValue = false;
  bool _value = false;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();

  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: bgColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                    'Sign Up',
                    style: const TextStyle(
                        fontSize: 55, fontWeight: FontWeight.bold),
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.white60,
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: 300,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormField(
                                hintText: 'name',
                                controller: nameController,
                                prefixIcon: Icons.person,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your name';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                                hintText: 'e-mail',
                                controller: emailController,
                                prefixIcon: Icons.email,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter an email address';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                                hintText: 'password',
                                suffixIcon:
                                    RegisterCubit.get(context).suffixIcon,
                                controller: passController,
                                prefixIcon: Icons.lock,
                                suffixPressed: () {
                                  RegisterCubit.get(context).changePassVision();
                                },
                                isPass: RegisterCubit.get(context).isPassShown,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter a password';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                                hintText: 'phone number',
                                prefixIcon: Icons.phone,
                                controller: phoneController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter a phone number';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Checkbox(
                                        activeColor: Colors.blueAccent,
                                        splashRadius: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        value: checkBoxValue,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            checkBoxValue = newValue;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Remember me',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey[500],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Sign up with social account',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.facebook_rounded,
                                        size: 33,
                                        color: Colors.white,
                                      ),
                                      radius: 20,
                                      backgroundColor: HexColor('#2E4C6D'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.email,
                                        size: 26,
                                        color: Colors.white,
                                      ),
                                      radius: 20,
                                      backgroundColor: HexColor('#2E4C6D'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  fallback: (context) =>
                                      CircularProgressIndicator(),
                                  builder: (context) => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).emailPassReg(
                                            email: emailController.text,
                                            name: nameController.text,
                                            password: passController.text,
                                            phone: phoneController.text);
                                      }
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              HexColor('#2E4C6D'),
                                              HexColor('#396EB0')
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 400.0, minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Sign up',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void isChecked({required bool isChecked}) {
  isChecked = !isChecked;
}

//creating a gradientText


