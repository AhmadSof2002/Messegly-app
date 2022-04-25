import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messegly/cubit/cubit.dart';
import 'package:messegly/layouts/social_layout.dart';
import 'package:messegly/modules/login/loginCubit/cubit.dart';
import 'package:messegly/modules/login/loginCubit/states.dart';

import 'package:messegly/modules/register/register_screen.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/components/constants.dart';
import 'package:messegly/shared/network/local/cache_helper.dart';
import 'package:messegly/shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            // toastMessage(msg: state.error, state: ToastStates.ERROR);
            toastMessage(msg: state.error, state: ToastStates.ERROR);
          }
          // if (state is LoginSuccessState) {
          //   toastMessage(msg: 'Login successed', state: ToastStates.SUCCESS);
          //   CacheHelper.saveData(
          //           key: 'uId', value: SocialCubit.get(context).userModel!.uId)
          //       .then((value) {
          //     uId = SocialCubit.get(context).userModel!.uId;
          //     print(uId);
          //     navigateAndFinish(context, SocialLayout());
          //   });
          // }

          // if (state is LoginSuccessState) {
          //   CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
          //     navigateAndFinish(context, SocialLayout());
          //   });
          // }
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                    'Sign in',
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
                                suffixIcon: LoginCubit.get(context).suffixIcon,
                                controller: passController,
                                prefixIcon: Icons.lock,
                                suffixPressed: () {
                                  LoginCubit.get(context).changePassVision();
                                },
                                isPass: LoginCubit.get(context).isPassShown,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter a password';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Sign in with social account',
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
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(0.0),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).emailPassLogin(
                                        email: emailController.text,
                                        password: passController.text,
                                      );
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).emailPassLogin(
                                          email: emailController.text,
                                          password: passController.text,
                                        );
                                        if (state is LoginSuccessState) {
                                          navigateAndFinish(
                                              context, SocialLayout());
                                        }
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
                                            'Sign in',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Don\'t have an account?',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey[400],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                    defaultTextButton(
                                        onPressed: () {
                                          navigateTo(context, RegisterScreen());
                                        },
                                        text: 'Register now',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[300])
                                  ],
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
