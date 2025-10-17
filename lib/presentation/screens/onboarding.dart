import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardPageData> pages = [
    _OnboardPageData(
      title: "Start your workout now", //"ابدأ التمرين الآن",
      subtitle: "Stay active with ease.", //"حافظ على نشاطك البدني بكل سهولة.",
      image: "assets/images/fitness_4.png",
    ),
    _OnboardPageData(
      title: "balanced diet plans", //"خطط غذائية متوازنة",
      subtitle:
          "Eat healthy food that suits you.", //"تناول الطعام الصحي الذي يناسبك.",
      image: "assets/images/fitness_1.png",
    ),
    _OnboardPageData(
      title: "Track your progress", //"تابع تقدمك",
      subtitle:
          "See the progress you make day by day.", //"تعرّف على التقدم الذي تحققه يوما بعد يوم.",
      image: "assets/images/fitness_3.png",
    ),
    _OnboardPageData(
      title: "Join the community", //"انضم للمجتمع",
      subtitle:
          "Share your achievements and learn from others.", //"شارك إنجازاتك واستفد من الآخرين.",
      image: "assets/images/fitness_2.png",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPage(_OnboardPageData data, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة تدخل مع Slide من الأعلى
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.4),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: Image.asset(data.image, height: 250),
          ),
          const SizedBox(height: 30),
          Text(
            data.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (idx) {
          setState(() {
            _currentIndex = idx;
          });
        },
        itemBuilder: (context, index) {
          final animationController = AnimationController(
            duration: const Duration(milliseconds: 1000), //800
            vsync: this,
          );
          final animation = CurvedAnimation(
            parent: animationController,
            curve: Curves.easeIn,
          );

          // شغّل الأنيميشن عند العرض
          animationController.forward();

          return AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return _buildPage(pages[index], animation);
            },
          );
        },
      ),
      bottomSheet: _currentIndex == pages.length - 1
          ? Container(
              color: MyColors.white,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  log("go to Login ================ ");
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ), // ابدأ الآن
                child: const Text("Start Now", style: TextStyle(fontSize: 20)),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (idx) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentIndex == idx ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == idx ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String subtitle;
  final String image;
  _OnboardPageData({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
