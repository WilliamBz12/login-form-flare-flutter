import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:login_flare/app/modules/login/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends BlocBase with Validators {
  //dispose will be called automatically by closing its streams

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //TEDDY streams controller
  final _teddyActionController = BehaviorSubject<String>();
  Observable<String> get outTeddyAction => _teddyActionController.stream;

  // Add data to streamx'
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  
  //Validation form
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  // change data
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Future<bool> submit() async {
    _teddyActionController.add("hands_down");
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    //Test Data
    final response =
        (validPassword == "123456") && (validEmail == "test@email.com");
    //Time for build response
    await Future.delayed(Duration(seconds: 2));

    String _action = response ? "success" : "fail";

    _teddyActionController.add(_action);
    //Time for run animation
    await Future.delayed(Duration(seconds: 1));

    return response;
  }

  void emailFocus() {
    _teddyActionController.add("test");
  }

  void passwordIsNotFocus() {
    _teddyActionController.add("hands_down");
  }
  
  void passwordFocus({bool hide}) {
    if (hide)
      _teddyActionController.add("hands_up");
    else
      _teddyActionController.add("hands_down");
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _passwordController.close();
    _teddyActionController.close();
  }
}
