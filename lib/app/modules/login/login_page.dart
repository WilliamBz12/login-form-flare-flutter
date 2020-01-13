import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:login_flare/app/modules/home/home_module.dart';
import 'package:login_flare/app/modules/login/login_module.dart';
import 'package:login_flare/app/modules/login/widgets/custom_button_widget.dart';
import 'package:login_flare/app/modules/login/widgets/custom_text_field_widget.dart';
import 'package:login_flare/app/modules/login/widgets/suffix_icon_widget.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePass = true;
  bool _isLoading = false;

  final _loginBloc = LoginModule.to.getBloc<LoginBloc>();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    //add function to listen alterations in TextField
    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _loginBloc.emailFocus();
      }
    });
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _loginBloc.passwordFocus(hide: _hidePass);
      }
    });
  }

  void _onTapButton() async {
    setState(() => _isLoading = true);
    bool result = await _loginBloc.submit();

    if (result) {
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
            SizedBox(height: 100),
            _buildTeddy(),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeddy() {
    return StreamBuilder<String>(
      stream: _loginBloc.outTeddyAction,
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
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: _loginBloc.email,
            builder: (context, snapshot) {
              return CustomTextFieldWidget(
                controller: _emailController,
                hintText: "e-mail",
                focus: _emailFocus,
                onChanged: _loginBloc.changeEmail,
                textError: snapshot.error,
              );
            },
          ),
          StreamBuilder(
            stream: _loginBloc.password,
            builder: (context, snapshot) {
              return CustomTextFieldWidget(
                controller: _passwordController,
                hintText: "password",
                focus: _passwordFocus,
                suffixIcon: _buildSuffixIconPassword(),
                onChanged: _loginBloc.changePassword,
                obscureText: _hidePass,
                textError: snapshot.error,
              );
            },
          ),
          StreamBuilder(
            stream: _loginBloc.submitValid,
            builder: (context, snapshot) {
              return CustomButtonWidget(
                onTap: snapshot.hasData ? _onTapButton : null,
                isLoading: _isLoading,
                text: "Login",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuffixIconPassword() {
    return SuffixIconWidget(
      actived: _hidePass,
      onTap: () => setState(() {
        _hidePass = !_hidePass;
        _loginBloc.passwordFocus(hide: _hidePass);
      })
    );
  }
}
