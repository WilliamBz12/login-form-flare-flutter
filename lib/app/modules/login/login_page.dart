import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:login_flare/app/modules/home/home_module.dart';
import 'package:login_flare/app/modules/login/login_module.dart';
import 'package:login_flare/app/modules/login/widgets/custom_button.dart';
import 'package:login_flare/app/modules/login/widgets/custom_text_field_widget.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePass = true;
  bool _isLoading = false;

  String password;
  String email;

  final _bloc = LoginModule.to.getBloc<LoginBloc>();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _bloc.emailFocus();
      }
    });

    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _bloc.passwordFocus(hide: _hidePass);
      }
    });
  }

  void _onTapButton() async {
    setState(() => _isLoading = true);
    bool response = await _bloc.submit();

    if (response) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomeModule()),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            StreamBuilder<String>(
              stream: _bloc.outTeddyAction,
              initialData: "test",
              builder: (context, snapshot) {
                return Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: FlareActor(
                    "assets/teddy.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    animation: snapshot.data,
                    //controller: _teddyController,
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: _bloc.email,
                      builder: (context, snapshot) {
                        return CustomTextFieldWidget(
                          controller: _emailController,
                          hintText: "e-mail",
                          focus: _emailFocus,
                          onChanged: _bloc.changeEmail,
                          textError: snapshot.error,
                        );
                      }),
                  StreamBuilder(
                      stream: _bloc.password,
                      builder: (context, snapshot) {
                        return CustomTextFieldWidget(
                          controller: _passwordController,
                          hintText: "Senha",
                          focus: _passwordFocus,
                          suffixIcon: _suffixIcon(),
                          onChanged: _bloc.changePassword,
                          obscureText: _hidePass,
                          textError: snapshot.error,
                        );
                      }),
                  StreamBuilder(
                      stream: _bloc.submitValid,
                      builder: (context, snapshot) {
                        return CustomButtonWidget(
                          onTap: snapshot.hasData ? _onTapButton : null,
                          isLoading: _isLoading,
                          text: "Login",
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _suffixIcon() {
    return InkWell(
      child: _hidePass ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      onTap: () => setState(() {
        _hidePass = !_hidePass;
        _bloc.passwordFocus(hide: _hidePass);
      }),
    );
  }
}
