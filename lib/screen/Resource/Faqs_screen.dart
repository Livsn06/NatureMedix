import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/Utils/_initApp.dart';
import '../../Utils/responsive.dart';
import '../Pages/control_screen.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen>
    with Application, TickerProviderStateMixin {
  TabController? _tabController;
  final List<bool> _isAnswerVisible =
      List.generate(14, (_) => false); // 14 to account for both sections

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_tabController == null) {
      _tabController = TabController(length: 2, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

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
            'FAQ\'s'.toUpperCase(),
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
                        Image.asset(icon.FAQs,
                            scale: setResponsiveSize(context, baseSize: 2.5)),
                        Gap(setResponsiveSize(context, baseSize: 5)),
                        Text(
                          'FAQ\'s\nNatureMedix'.toUpperCase(),
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
              Gap(setResponsiveSize(context, baseSize: 10)),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'APP INFO',
                  ),
                  Tab(text: 'APP FEATURES'),
                ],
                labelStyle: style.displaySmall(
                  context,
                  color: color.primarylow,
                  fontsize: setResponsiveSize(context, baseSize: 14),
                  fontweight: FontWeight.w500,
                  fontstyle: FontStyle.normal,
                ),
                unselectedLabelStyle: style.displaySmall(
                  context,
                  color: color.darkGrey,
                  fontsize: setResponsiveSize(context, baseSize: 14),
                  fontweight: FontWeight.w500,
                  fontstyle: FontStyle.normal,
                ),
              ),
              Gap(setResponsiveSize(context, baseSize: 10)),
              SizedBox(
                height: 480,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildHowAppWorksFAQSection(),
                    _buildAppFeaturesFAQSection(),
                  ],
                ),
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

  // Updated FAQ for "How the App Works"
  Widget _buildHowAppWorksFAQSection() {
    return ListView(
      children: [
        Gap(setResponsiveSize(context, baseSize: 10)),
        _buildFAQSection(
          'How does the NatureMedix app work?',
          'NatureMedix uses augmented reality to help users identify and learn about medicinal plants. You can scan plants to see their medicinal uses and learn about remedies.',
          Icons.camera_alt,
          0,
        ),
        _buildFAQSection(
          'Is the NatureMedix app free to use?',
          'Yes, NatureMedix is completely free to use. You can access all features without any hidden charges.',
          Icons.free_breakfast,
          1,
        ),
        _buildFAQSection(
          'How is my personal data stored?',
          'Your personal data is securely stored in an encrypted cloud database. The app ensures your privacy and does not share your data with third parties without your consent.',
          Icons.lock,
          2,
        ),
        _buildFAQSection(
          'Is the data I provide safe?',
          'Yes, NatureMedix follows strict security protocols to keep your data safe, including SSL encryption and compliance with privacy laws.',
          Icons.security,
          3,
        ),
        _buildFAQSection(
          'How does the app identify plants?',
          'The app uses the camera to scan plants and match them with a database of known medicinal plants. Augmented reality displays information about the plant you scan.',
          Icons.camera,
          4,
        ),
        // Additional FAQ on how the app works
        _buildFAQSection(
          'Can I access the app in multiple languages?',
          'Currently, the app supports English only. We are planning to add more language options in future updates.',
          Icons.language,
          5,
        ),
        _buildFAQSection(
          'How do I reset my account password?',
          'You can reset your password by going to the settings page and selecting "Forgot Password." You will receive an email to reset your password.',
          Icons.password,
          6,
        ),
      ],
    );
  }

  // Updated FAQ for "App Features & Info"
  Widget _buildAppFeaturesFAQSection() {
    return ListView(
      children: [
        Gap(setResponsiveSize(context, baseSize: 10)),
        _buildFAQSection(
          'Can I bookmark plants I like?',
          'Yes, you can bookmark plants in the app for easy access later. The bookmark feature helps you keep track of your favorite plants and remedies.',
          Icons.bookmark,
          7,
        ),
        _buildFAQSection(
          'Does the app work offline?',
          'No, NatureMedix requires an internet connection to access its database of medicinal plants and their information. However, bookmarked plants can be accessed offline.',
          Icons.signal_wifi_off,
          8,
        ),
        _buildFAQSection(
          'Is there any way to suggest new plants?',
          'Currently, the app does not allow users to suggest new plants directly, but we are working on adding this feature in future updates.',
          Icons.question_answer,
          9,
        ),
        _buildFAQSection(
          'Are there ads in the app?',
          'No, NatureMedix is ad-free to ensure a smooth and uninterrupted user experience.',
          Icons.no_accounts,
          10,
        ),
        _buildFAQSection(
          'How can I get updates for the app?',
          'The app will notify you about updates through your device’s app store. Ensure that automatic updates are enabled for the latest features and fixes.',
          Icons.update,
          11,
        ),
        // Additional FAQ on app features
        _buildFAQSection(
          'Can I share the plants I discover?',
          'Yes, you can share your discovered plants via social media or directly with friends through the sharing options in the app.',
          Icons.share,
          12,
        ),
        _buildFAQSection(
          'How do I contact support?',
          'You can contact our support team via the "Contact Us" section in the app settings, where you can submit a ticket for assistance.',
          Icons.contact_support,
          13,
        ),
      ],
    );
  }

  // Common FAQ Section Builder
  Widget _buildFAQSection(
      String question, String answer, IconData icon, int index) {
    if (index >= _isAnswerVisible.length) {
      return Container(); // Prevent invalid access if index is out of bounds
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAnswerVisible[index] =
              !_isAnswerVisible[index]; // Toggle answer visibility
        });
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.darkOpacity10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: color.primary,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: color.primary,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: _isAnswerVisible[index] ? null : 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              answer,
                              style: TextStyle(
                                fontSize: 15,
                                color: color.primarylow,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
