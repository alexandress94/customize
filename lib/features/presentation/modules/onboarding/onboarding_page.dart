import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:customize/features/presentation/modules/onboarding/controller/onboarding_controller.dart';
import 'package:customize/features/presentation/theme/app_color.dart';
import 'package:customize/features/presentation/utils/path_lottie.dart';

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
        color: isActive ? Colors.white : Colors.grey[500],
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
              colors: controller.service.isDarkMode
                  ? [
                      AppDarkColors.appPrimeryOnboardingColor,
                      AppDarkColors.appSecondaryOnboardingColor,
                      AppDarkColors.appSecondaryBackgroundColor,
                      AppDarkColors.appPrimeryBackgroundColor
                    ]
                  : [
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
                    onPressed: () async =>
                        await controller.navigatorTransactionPage(),
                    child: Text(
                      'Pular',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: controller.service.isDarkMode
                                ? AppLightColors.appWhiteColor
                                : AppLightColors.appBlackColor,
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
                        lottie: PathLottie.SAVING_MONEY,
                        title: 'Organize suas despesas',
                        description:
                            'Não deixe para depois. Organize suas despesas de maneira fácil na palma da sua mão.',
                      ),
                      SlideWidget(
                        lottie: PathLottie.BUSINESS_ANALYTICS,
                        title: 'Fazer contas?',
                        description:
                            'Com o customize, você não irá precisar de calculadora para suas contas.',
                      ),
                      SlideWidget(
                        lottie: PathLottie.FINANCIAL,
                        title: 'O aplicativo que você precisa',
                        description:
                            'Direto ao ponto e com estilo. Aplicativo simples para facilitar o seu dia a dia.',
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
                onTap: () async => await controller.navigatorTransactionPage(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Iniciar agora',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: controller.service.isDarkMode
                                ? AppDarkColors.appSecondaryBackgroundColor
                                : AppLightColors.appBlackColor,
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
