//  Onboarding Screen - Screen that is displayed the FirebaseAuth has no User Credentials (when there is no user logged in)
//
//  Author: NightmindOfficial
//  Co-Author: damattl
//  (Refactored)

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:linum/common/utils/country_flag_generator.dart';
import 'package:linum/common/utils/silent_scroll.dart';
import 'package:linum/core/authentication/login_view.dart';
import 'package:linum/core/authentication/register_view.dart';
import 'package:linum/core/authentication/services/authentication_service.dart';
import 'package:linum/core/design/layout/enums/screen_key.dart';
import 'package:linum/core/design/layout/utils/layout_helpers.dart';
import 'package:linum/core/design/layout/widgets/screen_skeleton.dart';
import 'package:linum/screens/onboarding_screen/constants/country_codes.dart';
import 'package:linum/screens/onboarding_screen/models/onboarding_slide_data.dart';
import 'package:linum/screens/onboarding_screen/viewmodels/onboarding_screen_viewmodel.dart';
import 'package:linum/screens/onboarding_screen/widgets/page_indicator.dart';
import 'package:linum/screens/onboarding_screen/widgets/single_slide.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: deprecated_member_use
//TODO DEPRECATED

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingPage> {
  int _currentPage = 0;
  List<OnboardingSlideData> _slides = [];
  late PageController _pageController = PageController();

  @override
  void initState() {
    _currentPage = 0;
    _slides = [
      OnboardingSlideData(
        imageURL: 'assets/svg/mobile-login.svg',
        heading: 'onboarding_screen.card1-title',
        freepikURL: 'https://storyset.com/phone',
        description: 'onboarding_screen.card1-description',
      ),
      OnboardingSlideData(
        imageURL: 'assets/svg/refund.svg',
        heading: 'onboarding_screen.card2-title',
        freepikURL: 'https://storyset.com/device',
        description: 'onboarding_screen.card2-description',
      ),
      OnboardingSlideData(
        imageURL: 'assets/svg/video-files.svg',
        heading: 'onboarding_screen.card3-title',
        description: 'onboarding_screen.card3-description',
        freepikURL: 'https://storyset.com/technology',
      ),
      OnboardingSlideData(
        imageURL: 'assets/svg/financial-data.svg',
        heading: 'onboarding_screen.card4-title',
        description: 'onboarding_screen.card4-description',
        freepikURL: 'https://storyset.com/data',
      ),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  // List for all OnboardingSlides build with the OnboardingSlide class
  List<Widget> _builtSlides() {
    return _slides.map((slide) => SingleSlide(slide: slide)).toList();
  }

  void _handleOnPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _handleOnDropdownChanged(String? value) {
    if (value != null) {
      setState(() {
        SharedPreferences.getInstance().then((pref) {
          pref.setString(
            "languageCode",
            countryFlagsToCountryCode[value] ?? "en",
          );
        });
        final String langString = countryFlagsToCountryCode[value] ?? "en";
        context.setLocale(
          Locale(
            langString,
            langString != "en" ? langString.toUpperCase() : "US",
          ),
        );

        Provider.of<AuthenticationService>(
          context,
          listen: false,
        ).updateLanguageCode(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingScreenViewModel viewModel =
      context.read<OnboardingScreenViewModel>();

    return ScreenSkeleton(
      head: '', // will not be displayed anyways
      contentOverride: true,
      screenKey: ScreenKey.onboarding,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          viewModel.setPageState(OnboardingPageState.none);
        },
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: SilentScroll(),
              child: PageView(
                controller: _pageController,
                onPageChanged: _handleOnPageChanged,
                physics: const PageScrollPhysics(),
                children: [
                  ..._builtSlides(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    elevation: 1,
                    items: countryFlagsToCountryCode.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: countryFlagWithSpecialCases(
                      context.locale.languageCode,
                    ),
                    onChanged: _handleOnDropdownChanged,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  PageIndicator(
                    slideCount: _slides.length,
                    currentSlide: _currentPage,
                  ),
                  SizedBox(
                    height: context.proportionateScreenHeight(32),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        callback: () => {
                          viewModel
                              .setPageState(OnboardingPageState.register),
                        },
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            const Color(0xFFC1E695),
                          ],
                        ),
                        elevation: 0,
                        increaseHeightBy: context
                            .proportionateScreenHeight(56 - 24),
                        increaseWidthBy: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tr('onboarding_screen.register-button'),
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.proportionateScreenHeight(10),
                  ),
                  CupertinoButton(
                    child: Text(
                      tr('onboarding_screen.login-button'),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    onPressed: () => {
                      viewModel
                          .setPageState(OnboardingPageState.login),
                    },
                  ),
                ],
              ),
            ),

            // Auth Screens

            // ignore: prefer_const_constructors
            LoginView(), // Won't reload on Language-Switch if const
            // ignore: prefer_const_constructors
            RegisterView(), // Won't reload on Language-Switch if const
          ],
        ),
      ),
    );
  }
}