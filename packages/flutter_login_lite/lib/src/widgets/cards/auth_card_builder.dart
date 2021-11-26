library auth_card_builder;

import 'dart:math';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_lite/flutter_login.dart';
import 'package:flutter_login_lite/src/constants.dart';
import 'package:flutter_login_lite/src/dart_helper.dart';
import 'package:flutter_login_lite/src/matrix.dart';
import 'package:flutter_login_lite/src/models/login_data.dart';
import 'package:flutter_login_lite/src/models/login_user_type.dart';
import 'package:flutter_login_lite/src/paddings.dart';
import 'package:flutter_login_lite/src/providers/auth.dart';
import 'package:flutter_login_lite/src/providers/login_messages.dart';
import 'package:flutter_login_lite/src/providers/login_theme.dart';
import 'package:flutter_login_lite/src/widget_helper.dart';
import 'package:provider/provider.dart';

import '../../../flutter_login.dart';
import '../animated_button.dart';
import '../animated_text_form_field.dart';
import '../custom_page_transformer.dart';
import '../fade_in.dart';

part 'login_card.dart';
part 'recover_card.dart';

class AuthCard extends StatefulWidget {
  const AuthCard(
      {Key? key,
      required this.userType,
      this.padding = const EdgeInsets.all(0),
      required this.loadingController,
      this.urlValidator,
      this.passwordValidator,
      this.onSubmit,
      this.onSubmitCompleted,
      this.hideForgotPasswordButton = false,
      this.hideSignUpButton = false,
      this.disableCustomPageTransformer = false,
      this.loginTheme,
      this.navigateBackAfterRecovery = false})
      : super(key: key);

  final EdgeInsets padding;
  final AnimationController loadingController;
  final FormFieldValidator<String>? urlValidator;
  final FormFieldValidator<String>? passwordValidator;
  final Function? onSubmit;
  final Function? onSubmitCompleted;
  final bool hideForgotPasswordButton;
  final bool hideSignUpButton;
  final LoginUserType userType;
  final bool disableCustomPageTransformer;
  final LoginTheme? loginTheme;
  final bool navigateBackAfterRecovery;

  @override
  AuthCardState createState() => AuthCardState();
}

class AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
  final GlobalKey _loginCardKey = GlobalKey();

  static const int _loginPageIndex = 0;
  static const int _recoveryIndex = 1;

  int _pageIndex = _loginPageIndex;

  var _isLoadingFirstTime = true;
  static const cardSizeScaleEnd = .2;

  final TransformerPageController _pageController = TransformerPageController();
  late AnimationController _formLoadingController;
  late AnimationController _routeTransitionController;

  // Card specific animations
  late Animation<double> _flipAnimation;
  late Animation<double> _cardSizeAnimation;
  late Animation<double> _cardSize2AnimationX;
  late Animation<double> _cardSize2AnimationY;
  late Animation<double> _cardRotationAnimation;
  late Animation<double> _cardOverlayHeightFactorAnimation;
  late Animation<double> _cardOverlaySizeAndOpacityAnimation;

  @override
  void initState() {
    super.initState();

    widget.loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isLoadingFirstTime = false;
        _formLoadingController.forward();
      }
    });

    // Set all animations
    _flipAnimation = Tween<double>(begin: pi / 2, end: 0).animate(
      CurvedAnimation(
        parent: widget.loadingController,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeIn,
      ),
    );

    _formLoadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _routeTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _cardSizeAnimation = Tween<double>(begin: 1.0, end: cardSizeScaleEnd)
        .animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(0, .27272727 /* ~300ms */,
          curve: Curves.easeInOutCirc),
    ));

    // replace 0 with minPositive to pass the test
    // https://github.com/flutter/flutter/issues/42527#issuecomment-575131275
    _cardOverlayHeightFactorAnimation =
        Tween<double>(begin: double.minPositive, end: 1.0)
            .animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.27272727, .5 /* ~250ms */, curve: Curves.linear),
    ));

    _cardOverlaySizeAndOpacityAnimation =
        Tween<double>(begin: 1.0, end: 0).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.5, .72727272 /* ~250ms */, curve: Curves.linear),
    ));

    _cardSize2AnimationX =
        Tween<double>(begin: 1, end: 1).animate(_routeTransitionController);

    _cardSize2AnimationY =
        Tween<double>(begin: 1, end: 1).animate(_routeTransitionController);

    _cardRotationAnimation =
        Tween<double>(begin: 0, end: pi / 2).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.72727272, 1 /* ~300ms */,
          curve: Curves.easeInOutCubic),
    ));
  }

  @override
  void dispose() {
    _formLoadingController.dispose();
    _pageController.dispose();
    _routeTransitionController.dispose();
    super.dispose();
  }

  void _changeCard(int newCardIndex) {
    final auth = Provider.of<Auth>(context, listen: false);

    auth.currentCardIndex = newCardIndex;

    setState(() {
      _pageController.animateToPage(
        newCardIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      _pageIndex = newCardIndex;
    });
  }

  Future<void>? runLoadingAnimation() {
    if (widget.loadingController.isDismissed) {
      return widget.loadingController.forward().then((_) {
        if (!_isLoadingFirstTime) {
          _formLoadingController.forward();
        }
      });
    } else if (widget.loadingController.isCompleted) {
      return _formLoadingController
          .reverse()
          .then((_) => widget.loadingController.reverse());
    }
    return null;
  }

  Future<void> _forwardChangeRouteAnimation(GlobalKey cardKey) {
    final deviceSize = MediaQuery.of(context).size;
    final cardSize = getWidgetSize(cardKey)!;
    final widthRatio = deviceSize.width / cardSize.height + 2;
    final heightRatio = deviceSize.height / cardSize.width + .25;

    _cardSize2AnimationX =
        Tween<double>(begin: 1.0, end: heightRatio / cardSizeScaleEnd).animate(
      CurvedAnimation(
        parent: _routeTransitionController,
        curve: const Interval(.72727272, 1, curve: Curves.easeInOutCubic),
      ),
    );
    _cardSize2AnimationY =
        Tween<double>(begin: 1.0, end: widthRatio / cardSizeScaleEnd).animate(
      CurvedAnimation(
        parent: _routeTransitionController,
        curve: const Interval(.72727272, 1, curve: Curves.easeInOutCubic),
      ),
    );

    widget.onSubmit?.call();

    return _formLoadingController
        .reverse()
        .then((_) => _routeTransitionController.forward());
  }

  void _reverseChangeRouteAnimation() {
    _routeTransitionController
        .reverse()
        .then((_) => _formLoadingController.forward());
  }

  void runChangeRouteAnimation() {
    if (_routeTransitionController.isCompleted) {
      _reverseChangeRouteAnimation();
    } else if (_routeTransitionController.isDismissed) {
      _forwardChangeRouteAnimation(_loginCardKey);
    }
  }

  void runChangePageAnimation() {
    final auth = Provider.of<Auth>(context, listen: false);
    if (auth.currentCardIndex >= 2) {
      _changeCard(0);
    } else {
      _changeCard(auth.currentCardIndex + 1);
    }
  }

  Widget _buildLoadingAnimator({Widget? child, required ThemeData theme}) {
    Widget card;
    Widget overlay;

    // loading at startup
    card = AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) => Transform(
        transform: Matrix.perspective()..rotateX(_flipAnimation.value),
        alignment: Alignment.center,
        child: child,
      ),
      child: child,
    );

    // change-route transition
    overlay = Padding(
      padding: theme.cardTheme.margin!,
      child: AnimatedBuilder(
        animation: _cardOverlayHeightFactorAnimation,
        builder: (context, child) => ClipPath.shape(
          shape: theme.cardTheme.shape!,
          child: FractionallySizedBox(
            heightFactor: _cardOverlayHeightFactorAnimation.value,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(color: theme.colorScheme.secondary),
        ),
      ),
    );

    overlay = ScaleTransition(
      scale: _cardOverlaySizeAndOpacityAnimation,
      child: FadeTransition(
        opacity: _cardOverlaySizeAndOpacityAnimation,
        child: overlay,
      ),
    );

    return Stack(
      children: <Widget>[
        card,
        Positioned.fill(child: overlay),
      ],
    );
  }

  Widget _changeToCard(BuildContext context, int index) {
    var formController = _formLoadingController;
    // if (!_isLoadingFirstTime) formController = _formLoadingController..value = 1.0;
    switch (index) {
      case _loginPageIndex:
        return _buildLoadingAnimator(
          theme: Theme.of(context),
          child: _LoginCard(
            key: _loginCardKey,
            userType: widget.userType,
            loadingController: formController,
            urlValidator: widget.urlValidator,
            passwordValidator: widget.passwordValidator,
            onSwitchRecoveryPassword: () => _changeCard(_recoveryIndex),
            onSubmitCompleted: () {
              _forwardChangeRouteAnimation(_loginCardKey).then((_) {
                widget.onSubmitCompleted!();
              });
            },
            hideForgotPasswordButton: widget.hideForgotPasswordButton,
          ),
        );
      case _recoveryIndex:
        return _RecoverCard(
          userType: widget.userType,
          loginTheme: widget.loginTheme,
          loadingController: formController,
          navigateBack: widget.navigateBackAfterRecovery,
          onBack: () => _changeCard(_loginPageIndex),
          onSubmitCompleted: () => _changeCard(_loginPageIndex),
        );
    }
    throw IndexError(index, 5);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Widget current = Container(
      height: deviceSize.height,
      width: deviceSize.width,
      padding: widget.padding,
      child: TransformerPageView(
        physics: const NeverScrollableScrollPhysics(),
        pageController: _pageController,
        itemCount: 5,

        /// Need to keep track of page index because soft keyboard will
        /// make page view rebuilt
        index: _pageIndex,
        transformer: widget.disableCustomPageTransformer
            ? null
            : CustomPageTransformer(),
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.topCenter,
            child: _changeToCard(context, index),
          );
        },
      ),
    );

    return AnimatedBuilder(
      animation: _cardSize2AnimationX,
      builder: (context, snapshot) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(_cardRotationAnimation.value)
            ..scale(_cardSizeAnimation.value, _cardSizeAnimation.value)
            ..scale(_cardSize2AnimationX.value, _cardSize2AnimationY.value),
          child: current,
        );
      },
    );
  }
}
