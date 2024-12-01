// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../components/cust_elevatedbtn.dart';
import '../../components/cust_textformfield.dart';
import '../../controllers/Auth_Control/forgetpassword_controller.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';

class ForgetPasswordScreen extends StatefulWidget with Application {
  ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Application {
  final _emailControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color.white,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(image.BG6), fit: BoxFit.cover),
                          color: color.primarylow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  setResponsiveSize(context, baseSize: 35)),
                              bottomRight: Radius.circular(
                                  setResponsiveSize(context, baseSize: 35))),
                        ),
                      ),
                      Positioned(
                          top: setResponsiveSize(context, baseSize: 20),
                          left: setResponsiveSize(context, baseSize: 10),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: color.white),
                            onPressed: () =>
                                Get.toNamed(ScreenRouter.getLoginRoute),
                          )),
                      Center(
                        child: Image.asset(
                          logo.second,
                          scale: setResponsiveSize(context, baseSize: 2.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: setResponsiveSize(context, baseSize: 270),
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.all(setResponsiveSize(context, baseSize: 18)),
                decoration: BoxDecoration(
                  color: color.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        setResponsiveSize(context, baseSize: 25)),
                    topRight: Radius.circular(
                        setResponsiveSize(context, baseSize: 25)),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            icon.reset,
                            fit: BoxFit.contain,
                            width: setResponsiveSize(context, baseSize: 100),
                            height: setResponsiveSize(context, baseSize: 100),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 50)),
                          Text(
                            'FORGET PASSWORD',
                            textAlign: TextAlign.center,
                            style: style.displaySmall(
                              context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 18),
                              fontspace:
                                  setResponsiveSize(context, baseSize: 0.7),
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          Text(
                            'Provide your account\'s email for which you want to reset your password',
                            textAlign: TextAlign.center,
                            style: style.displaySmall(
                              context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 14),
                              fontweight: FontWeight.w400,
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 30)),
                          TextFormFields(
                            control: _emailControl,
                            labeltext: 'Email',
                            iconData: Icons.email,
                            isPassword: false,
                            validator: controller.validateEmail,
                          ),
                          Gap(setResponsiveSize(context, baseSize: 50)),
                          CustElevatedbtn(
                            colors: color.primarylow,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.resetPassword(
                                    context, _emailControl.text);
                              }
                            },
                            child: Text(
                              'RESET',
                              textAlign: TextAlign.center,
                              style: style.buttonText(
                                context,
                                color: color.white,
                                fontspace: 3,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15),
                              ),
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
