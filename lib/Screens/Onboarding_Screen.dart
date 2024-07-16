import 'package:flutter/material.dart';
import '/Modules/Authentication/Authentication_Mod.dart';

class Onboarding_Screen extends StatefulWidget {
  const Onboarding_Screen({Key? key}) : super(key: key);

  @override
  _Onboarding_ScreenState createState() => _Onboarding_ScreenState();
}

class _Onboarding_ScreenState extends State<Onboarding_Screen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      'Welcome to YugTalk',
      'A stage for Filipino children to find their voice.',
      'assets/images/onboarding1.png',
    ),
    OnboardingPage(
      'Building Confidence in Two Languages',
      'YugTalk fosters communication with accessible features and bilingual support for Filipino children.',
      'assets/images/onboarding2.png',
    ),
    OnboardingPage(
      'Beyond Words',
      'YugTalk goes beyond traditional AAC apps with custom context and video demonstrations for words.',
      'assets/images/onboarding3.png',
    ),
    OnboardingPage(
      'Empowering Parents and Therapists',
      "Work together to create a communication journey tailored for your child's needs",
      'assets/images/onboarding4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPageWidget(
                  onboardingPage: onboardingPages[index],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 50, bottom: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            ('Back'),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingPages.length,
                    (index) => buildPageIndicator(index),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 50, bottom: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < onboardingPages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Authentication_Mod(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        _currentPage == onboardingPages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.deepPurple : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String image;

  OnboardingPage(this.title, this.subtitle, this.image);
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage onboardingPage;

  const OnboardingPageWidget({
    Key? key,
    required this.onboardingPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(bottom: 130), // Adjusted margin
                  child: Image.asset(
                    onboardingPage.image,
                    fit:
                        BoxFit.contain, // Fit image to contain within container
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 20, // Adjusted bottom position
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        onboardingPage.title,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        onboardingPage.subtitle,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
