import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/Utils/_initApp.dart';

import '../../Utils/responsive.dart';
import '../Pages/control_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with Application {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.light,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          iconTheme: IconThemeData(color: color.primary),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.primary,
                  color.primarylow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: InkWell(
            onTap: () => Get.offAll(() => const ControlScreen(), arguments: 4),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: color.white,
              size: setResponsiveSize(context, baseSize: 18),
            ),
          ),
          title: Text(
            'Privacy Policy'.toUpperCase(),
            style: style.displaySmall(
              context,
              color: color.white,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500,
              fontspace: 2,
              fontstyle: FontStyle.normal,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: color.white, width: 4),
                    gradient: LinearGradient(
                      colors: [
                        color.primary,
                        color.primarylow,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(icon.privacy,
                            scale: setResponsiveSize(context, baseSize: 5)),
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        Text(
                          'privacy\nNaturemedix'.toUpperCase(),
                          style: style.mediumText(
                            context,
                            color: color.white,
                            fontsize: setResponsiveSize(context, baseSize: 22),
                            fontweight: FontWeight.w700,
                            fontspace: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(setResponsiveSize(context, baseSize: 20)),
              _buildSection(
                'Information We Collect',
                'We collect personal information such as your name and email to enhance our services and improve user experience. Usage and device data help us understand how you engage with the platform.',
                Icons.info_outline,
              ),
              _buildSection(
                'How We Use Your Information',
                'We use your information to personalize services and communication, as well as meet legal obligations. Your data helps us ensure that our services align with your needs.',
                Icons.settings,
              ),
              _buildSection(
                'Data Sharing',
                'We share your information with third parties only when necessary to improve services. Collaboration with third-party services is done within strict privacy guidelines.',
                Icons.share,
              ),
              _buildSection(
                'Data Security',
                'We implement encryption and secure storage protocols to protect your data from unauthorized access. Our systems are designed to ensure data privacy.',
                Icons.lock,
              ),
              _buildSection(
                'Your Rights',
                'You have rights to access, correct, or delete your personal information. You can also restrict processing based on your preferences.',
                Icons.security,
              ),
              const Divider(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Last updated: November 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: color.darkGrey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.darkOpacity10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 25,
                color: color.primary,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color.primary,
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 2)),
                  Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
