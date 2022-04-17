import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/onboarding/controller/onboarding_controller.dart';
import 'package:organize_more/features/presentation/theme/app_color.dart';
import 'package:organize_more/features/presentation/utils/path_lottie.dart';

import 'widgets/body_widget.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = Get.find<OnboardingController>();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0.h,
      width: isActive ? 24.0.w : 16.0.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey[600],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                AppLightColors.appPrimaryBackgroundColor,
                AppLightColors.appSecondaryColor,
                AppLightColors.appIconGrayColor,
                Colors.black87
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Pular',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: AppLightColors.appBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Container(
                  height: 500.0.h,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      SlideWidget(
                        lottie: PathLottie.FINANCE,
                        title: 'Organize suas despesas',
                        description:
                            'Esquecer aquela despesa no final do mês? Nunca mais. Agora poderá registrar suas despesas.',
                      ),
                      SlideWidget(
                        lottie: PathLottie.BUSINESS_ANALYTICS,
                        title: 'Organize suas despesas',
                        description:
                            'Esquecer aquela despesa no final do mês? Nunca mais. Agora poderá registrar suas despesas.',
                      ),
                      SlideWidget(
                        lottie: PathLottie.FINANCIAL,
                        title: 'Organize suas despesas',
                        description:
                            'Esquecer aquela despesa no final do mês? Nunca mais. Agora poderá registrar suas despesas.',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onPrimary: Colors.transparent,
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Próximo',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: AppLightColors.appWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(width: 10.0.h),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppLightColors.appWhiteColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 70.0.h,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => print('Get started'),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Iniciar agora',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: AppLightColors.appBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
