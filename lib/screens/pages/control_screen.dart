import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/home_controller.dart';
import 'package:naturemedix/screens/pages/bookmark_screen.dart';
import 'package:naturemedix/screens/pages/home_screens.dart';
import 'package:naturemedix/screens/pages/profile_screen.dart';
import 'package:naturemedix/screens/pages/request_screen.dart';
import 'package:naturemedix/screens/pages/scanner_screen.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../components/cust_bottomnav.dart';
import '../../controllers/bookmark_controller.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen>
    with WidgetsBindingObserver {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    final int? initialPage = Get.arguments as int?;
    if (initialPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(initialPage);
        Get.find<HomeController>().updateIndex(initialPage);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      int? index = Get.arguments as int?;
      if (index != null) {
        Get.find<HomeController>().updateIndex(index);
        _pageController.jumpToPage(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BookmarkController());
    return GetBuilder<HomeController>(
      init: Get.put(HomeController(), permanent: false),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                if (controller.selectedIndex.value != index) {
                  controller.updateIndex(index);
                }
              },
              children: [
                DashboardScreen(),
                BookmarkScreen(),
                ScannerScreen(),
                RequestScreen(),
                ProfileScreen(),
              ],
            ),
            Positioned(
              bottom: setResponsiveSize(context, baseSize: 0),
              left: setResponsiveSize(context, baseSize: 0),
              right: setResponsiveSize(context, baseSize: 0),
              child: Obx(
                () => ButtomNav(
                  selectedIndex: controller.selectedIndex.value,
                  onTap: (index) {
                    if (_pageController.page != index.toDouble()) {
                      controller.updateIndex(index);
                      _pageController.jumpToPage(index);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
