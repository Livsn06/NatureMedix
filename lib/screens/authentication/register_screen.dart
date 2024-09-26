import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/Auth_Control/register_controller.dart';
import 'package:naturemedix/routes/screen_routes.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../components/cust_checkbox.dart';
import '../../components/cust_textformfield.dart';
import '../../utils/_initApp.dart';

class RegisterScreen extends StatefulWidget with Application {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Application {
  final TextEditingController _fnameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) => Scaffold(
          backgroundColor: color.white,
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(image.BG6),
                                fit: BoxFit.cover),
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
                                  Get.toNamed(ScreenRouter.getGetstartedRoute)),
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
                top: setResponsiveSize(context, baseSize: 100),
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Gap(setResponsiveSize(context, baseSize: 15)),
                          Text(
                            'REGISTER',
                            textAlign: TextAlign.center,
                            style: style.displaySmall(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 22),
                                fontweight: FontWeight.w700,
                                fontspace:
                                    setResponsiveSize(context, baseSize: 4)),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 5)),
                          Text(
                            'Create your new account',
                            textAlign: TextAlign.center,
                            style: style.displaySmall(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 14),
                                fontweight: FontWeight.w400),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 30)),
                          TextFormFields(
                            control: _fnameControl,
                            labeltext: 'Username',
                            iconData: Icons.person,
                            isPassword: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _emailControl,
                            labeltext: 'Email',
                            iconData: Icons.email,
                            isPassword: false,
                            validator: controller.validateEmail,
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _passwordController,
                            labeltext: 'Password',
                            iconData: Icons.lock,
                            isPassword: true,
                            isPasswordVisible: controller.isPasswordVisible,
                            togglePasswordVisibility:
                                controller.togglePasswordVisibility,
                            validator: controller.validatePassword,
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          TextFormFields(
                            control: _confirmControl,
                            labeltext: 'Confirm Password',
                            iconData: Icons.lock,
                            isPassword: true,
                            isPasswordVisible:
                                controller.isConfirmPasswordVisible,
                            togglePasswordVisibility:
                                controller.toggleConfirmPasswordVisibility,
                            validator: (value) =>
                                controller.validateConfirmPassword(
                                    value, _passwordController.text),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          CheckBoxs(
                            isRememberMeChecked: controller.isRememberMeChecked,
                            onChanged: (value) {
                              if (value != null) {
                                controller.toggleRememberMe();
                              }
                            },
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.toSignUpConfirm(
                                    _fnameControl,
                                    _emailControl,
                                    _passwordController,
                                    _confirmControl,
                                    context,
                                    'signup');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation:
                                  setResponsiveSize(context, baseSize: 3),
                              backgroundColor: color.primarylow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 50)),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      setResponsiveSize(context, baseSize: 15)),
                              child: Text(
                                'REGISTER',
                                textAlign: TextAlign.center,
                                style: style.buttonText(context,
                                    color: color.white,
                                    fontspace: 3,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 15)),
                              ),
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 30)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    setResponsiveSize(context, baseSize: 50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Divider(
                                        thickness: setResponsiveSize(context,
                                            baseSize: 0.5),
                                        color: color.primarylow)),
                                Gap(setResponsiveSize(context, baseSize: 5)),
                                Text(
                                  'or with',
                                  textAlign: TextAlign.center,
                                  style: style.displaySmall(context,
                                      color: color.primarylow,
                                      fontsize: 15,
                                      fontweight: FontWeight.w500),
                                ),
                                Gap(setResponsiveSize(context, baseSize: 5)),
                                Expanded(
                                    child: Divider(
                                        thickness: setResponsiveSize(context,
                                            baseSize: 0.5),
                                        color: color.primarylow)),
                              ],
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NeoBox(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 7)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 10)),
                                  child: Image.asset(
                                    icon.GOOGLE,
                                    scale: setResponsiveSize(context,
                                        baseSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: setResponsiveSize(context,
                                        baseSize: 20)),
                                child: NeoBox(
                                  borderRadius: BorderRadius.circular(
                                      setResponsiveSize(context, baseSize: 7)),
                                  child: Padding(
                                    padding: EdgeInsets.all(setResponsiveSize(
                                        context,
                                        baseSize: 10)),
                                    child: Image.asset(
                                      icon.FACEBOOK,
                                      scale: setResponsiveSize(context,
                                          baseSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              NeoBox(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 7)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 10)),
                                  child: Image.asset(
                                    icon.INSTAGRAM,
                                    scale: setResponsiveSize(context,
                                        baseSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(setResponsiveSize(context, baseSize: 30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                textAlign: TextAlign.center,
                                style: style.displaySmall(context,
                                    color: color.primarylow,
                                    fontsize: 15,
                                    fontweight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(ScreenRouter.getLoginRoute),
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.center,
                                  style: style.displaySmall(context,
                                      color: color.primary,
                                      fontsize: 15,
                                      fontweight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
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
