import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/domain/model.dart';
import 'package:piggybank/presentation/onboarding/onbaording_vm.dart';
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
  final PageController _pageController = PageController();
  final OnBoardingViewModel viewModel = OnBoardingViewModelImplementation();

  @override
  void initState() {
    viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: viewModel.outputSliderViewObject,
      builder: (context, snapshot) => getContentWidget(snapshot.data),
    );
  }

  Widget getContentWidget(SliderViewObject? viewObject) {
    if (viewObject == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: ColorManager.white,
      //  appBar: AppBar(),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => viewModel.onPageChanged(value),
        itemCount: viewObject.numOfSlides,
        itemBuilder: (context, index) =>
            OnBoardingPage(viewObject.sliderObject),
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
            pageIndicator(viewObject),
          ],
        ),
      ),
    );
  }

  Widget pageIndicator(SliderViewObject viewObject) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var i = 0; i < viewObject.numOfSlides; i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Icon(
                i == viewObject.currentIndex
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
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
