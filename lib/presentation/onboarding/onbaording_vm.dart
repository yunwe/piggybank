import 'dart:async';

import 'package:piggybank/domain/model.dart';
import 'package:piggybank/presentation/base/base_vm.dart';
import 'package:piggybank/presentation/resources/assets_manager.dart';
import 'package:piggybank/presentation/resources/strings_manager.dart';

class OnBoardingViewModelImplementation extends OnBoardingViewModel {
  int _currentIndex = 0;
  final _streamController = StreamController<int>();
  late final List<SliderObject> _list;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderObjectList();
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((index) => SliderViewObject(
            _list[index],
            _list.length,
            index,
          ));

  List<SliderObject> _getSliderObjectList() {
    return [
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
  }

  void _postDataToView() {
    _streamController.sink.add(_currentIndex);
  }
}

abstract class OnBoardingViewModel extends BaseViewModel {
  //Input Functions
  void onPageChanged(int index);

  //Output Functions
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(
    this.sliderObject,
    this.numOfSlides,
    this.currentIndex,
  );
}
