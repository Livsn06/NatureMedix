import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/Utils/_initApp.dart';

import '../../Utils/responsive.dart';
import '../Pages/control_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with Application {
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
            'About'.toUpperCase(),
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
          padding: const EdgeInsets.all(18),
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
                        Image.asset(logo.second,
                            scale: setResponsiveSize(context, baseSize: 2.5)),
                        Gap(setResponsiveSize(context, baseSize: 5)),
                        Text(
                          'About\nNatureMedix'.toUpperCase(),
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
                'What is NatureMedix?',
                'NatureMedix is an innovative mobile application designed to help users discover and learn about medicinal plants and their uses for natural remedies. The app provides information, plant recognition through Augmented Reality, and remedies to promote wellness.',
                Icons.info_outline,
              ),
              _buildSection(
                'Mission',
                'Our mission is to encourage the use of natural remedies through technology, making traditional knowledge of medicinal plants more accessible and actionable for everyone.',
                Icons.task_alt,
              ),
              _buildSection(
                'Vision',
                'We aim to become the leading platform for plant-based wellness, connecting users to nature’s healing power through easy-to-use technology and promoting a healthier, sustainable lifestyle.',
                Icons.visibility,
              ),
              _buildSection(
                'How We Work',
                'NatureMedix uses Augmented Reality (AR) to help users identify plants and access relevant medicinal information. It also integrates user feedback, ensuring that the app evolves according to the needs of its community.',
                Icons.work,
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
      elevation: 3,
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
