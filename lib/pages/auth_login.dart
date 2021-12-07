import 'package:flutter/material.dart';
import 'package:heroflix/pages/auth_register.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool passwordConfirmationVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateToRegister(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logged in\nHeroflix',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: false,
                      autofocus: false,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) => value.isEmpty ? 'Email is required' : null,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      autocorrect: false,
                      autofocus: false,
                      obscureText: !passwordVisible,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          color: textGrey,
                          splashRadius: 1,
                          icon: Icon(passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: togglePassword,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) => value.isEmpty ? 'Password is required' : null,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {

                      }
                    },
                    borderRadius: BorderRadius.circular(14.0),
                    child: Center(
                      child: Text(
                        'Login',
                        style: heading5.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account? ",
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToRegister(context);
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}