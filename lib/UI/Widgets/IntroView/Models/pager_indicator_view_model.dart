import 'package:the_parker/UI/Widgets/IntroView/Constants/constants.dart';
import 'package:the_parker/UI/Widgets/IntroView/Models/page_view_model.dart';

//view model for page indicator

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}
