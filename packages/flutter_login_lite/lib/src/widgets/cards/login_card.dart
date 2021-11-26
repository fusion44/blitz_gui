part of auth_card_builder;

class _LoginCard extends StatefulWidget {
  const _LoginCard({
    Key? key,
    required this.loadingController,
    required this.urlValidator,
    required this.passwordValidator,
    required this.onSwitchRecoveryPassword,
    required this.userType,
    this.onSubmitCompleted,
    this.hideForgotPasswordButton = false,
  }) : super(key: key);

  final AnimationController loadingController;
  final FormFieldValidator<String>? urlValidator;
  final FormFieldValidator<String>? passwordValidator;
  final Function onSwitchRecoveryPassword;
  final Function? onSubmitCompleted;
  final bool hideForgotPasswordButton;
  final LoginUserType userType;

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _urlFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  late TextEditingController _urlController;
  late TextEditingController _passController;

  var _isLoading = false;
  var _isSubmitting = false;
  var _showShadow = true;

  late AnimationController _submitController;

  Interval? _passTextFieldLoadingAnimationInterval;
  Interval? _textButtonLoadingAnimationInterval;
  late Animation<double> _buttonScaleAnimation;

  bool get buttonEnabled => !_isLoading && !_isSubmitting;

  @override
  void initState() {
    super.initState();

    final auth = Provider.of<Auth>(context, listen: false);
    _urlController = TextEditingController(text: auth.url);
    _passController = TextEditingController(text: auth.password);

    widget.loadingController.addStatusListener(handleLoadingAnimationStatus);

    _submitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _passTextFieldLoadingAnimationInterval = const Interval(.15, 1.0);
    _textButtonLoadingAnimationInterval =
        const Interval(.6, 1.0, curve: Curves.easeOut);
    _buttonScaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.loadingController,
      curve: const Interval(.4, 1.0, curve: Curves.easeOutBack),
    ));
  }

  void handleLoadingAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      setState(() => _isLoading = true);
    }
    if (status == AnimationStatus.completed) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    widget.loadingController.removeStatusListener(handleLoadingAnimationStatus);
    _urlController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _submitController.dispose();

    super.dispose();
  }

  Future<bool> _submit() async {
    // a hack to force unfocus the soft keyboard. If not, after change-route
    // animation completes, it will trigger rebuilding this widget and show all
    // textfields and buttons again before going to new route
    FocusScope.of(context).requestFocus(FocusNode());

    final messages = Provider.of<LoginMessages>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      return false;
    }

    _formKey.currentState!.save();
    await _submitController.forward();
    setState(() => _isSubmitting = true);
    final auth = Provider.of<Auth>(context, listen: false);
    String? error;

    error = await auth.onLogin?.call(
      LoginData(url: auth.url, password: auth.password),
    );

    // workaround to run after _cardSizeAnimation in parent finished
    // need a cleaner way but currently it works so..
    Future.delayed(const Duration(milliseconds: 270), () {
      if (mounted) {
        setState(() => _showShadow = false);
      }
    });

    await _submitController.reverse();

    if (!DartHelper.isNullOrEmpty(error)) {
      showErrorToast(context, messages.flushbarTitleError, error!);
      Future.delayed(const Duration(milliseconds: 271), () {
        if (mounted) {
          setState(() => _showShadow = true);
        }
      });
      setState(() => _isSubmitting = false);
      return false;
    }

    widget.onSubmitCompleted?.call();

    return true;
  }

  Widget _buildUrlField(double width, LoginMessages messages, Auth auth) {
    return AnimatedTextFormField(
      width: width,
      loadingController: widget.loadingController,
      interval: _passTextFieldLoadingAnimationInterval,
      labelText: messages.urlHint,
      controller: _urlController,
      textInputAction: TextInputAction.done,
      focusNode: _urlFocusNode,
      onFieldSubmitted: (value) =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
      validator: widget.urlValidator,
      onSaved: (value) => auth.url = value!,
      enabled: !_isSubmitting,
      prefixIcon: const Icon(Icons.link, size: 25),
    );
  }

  Widget _buildPasswordField(double width, LoginMessages messages, Auth auth) {
    return AnimatedPasswordTextFormField(
      animatedWidth: width,
      loadingController: widget.loadingController,
      interval: _passTextFieldLoadingAnimationInterval,
      labelText: messages.passwordHint,
      controller: _passController,
      textInputAction:
          auth.isLogin ? TextInputAction.done : TextInputAction.next,
      focusNode: _passwordFocusNode,
      onFieldSubmitted: (value) {
        if (auth.isLogin) {
          _submit();
        } else {
          // SignUp
          FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
        }
      },
      validator: widget.passwordValidator,
      onSaved: (value) => auth.password = value!,
      enabled: !_isSubmitting,
    );
  }

  Widget _buildForgotPassword(ThemeData theme, LoginMessages messages) {
    return FadeIn(
      controller: widget.loadingController,
      fadeDirection: FadeDirection.bottomToTop,
      offset: .5,
      curve: _textButtonLoadingAnimationInterval,
      child: TextButton(
        onPressed: buttonEnabled
            ? () {
                // save state to populate email field on recovery card
                _formKey.currentState!.save();
                widget.onSwitchRecoveryPassword();
              }
            : null,
        child: Text(
          messages.forgotPasswordButton,
          style: theme.textTheme.bodyText2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
      ThemeData theme, LoginMessages messages, Auth auth) {
    return ScaleTransition(
      scale: _buttonScaleAnimation,
      child: AnimatedButton(
        controller: _submitController,
        text: messages.loginButton,
        onPressed: () => _submit(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    final messages = Provider.of<LoginMessages>(context, listen: false);
    final theme = Theme.of(context);
    final cardWidth = min(MediaQuery.of(context).size.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;
    final authForm = Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: cardPadding,
              right: cardPadding,
              top: cardPadding + 10,
            ),
            width: cardWidth,
            child: _buildUrlField(textFieldWidth, messages, auth),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: cardPadding,
              right: cardPadding,
              top: cardPadding + 10,
            ),
            width: cardWidth,
            child: _buildPasswordField(textFieldWidth, messages, auth),
          ),
          Container(
            padding: Paddings.fromRBL(cardPadding),
            width: cardWidth,
            child: Column(
              children: <Widget>[
                !widget.hideForgotPasswordButton
                    ? _buildForgotPassword(theme, messages)
                    : SizedBox.fromSize(
                        size: const Size.fromHeight(16),
                      ),
                _buildSubmitButton(theme, messages, auth),
              ],
            ),
          ),
        ],
      ),
    );

    return FittedBox(
      child: Card(
        elevation: _showShadow ? theme.cardTheme.elevation : 0,
        child: authForm,
      ),
    );
  }
}
