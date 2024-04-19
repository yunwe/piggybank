import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/presentation/resources/assets_manager.dart';
import 'package:piggybank/presentation/resources/color_manager.dart';
import 'package:piggybank/presentation/resources/routes_manager.dart';
import 'package:piggybank/presentation/resources/strings_manager.dart';
import 'package:piggybank/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<SliderObject> slides = [
    SliderObject(
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubtitle1,
      AssetsManager.onboardingLogo1,
    ),
    SliderObject(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubtitle2,
      AssetsManager.onboardingLogo2,
    ),
    SliderObject(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubtitle3,
      AssetsManager.onboardingLogo3,
    ),
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      //  appBar: AppBar(),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentIndex = value),
        itemCount: slides.length,
        itemBuilder: (context, index) => OnBoardingPage(slides[index]),
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.goNamed(RoutesManager.home);
                },
                child: const Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            pageIndicator,
          ],
        ),
      ),
    );
  }

  Widget get pageIndicator => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i = 0; i < slides.length; i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Icon(
                i == _currentIndex ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                size: AppSize.iconSize,
                color: ColorManager.darkPrimary,
              ),
            )
        ],
      );
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject slide;

  const OnBoardingPage(this.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            slide.image,
            fit: BoxFit.cover,
            width: AppSize.imageW,
            height: AppSize.imageH,
          ),
          const SizedBox(
            height: AppSize.s50,
          ),
          Text(
            slide.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            slide.subTitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorManager.onPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
