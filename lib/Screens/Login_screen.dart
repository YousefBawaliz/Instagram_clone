import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/firebase_auth.dart';
import 'package:instagram_clone/Screens/Signup_screen.dart';
import 'package:instagram_clone/Utils/colors.dart';
import 'package:instagram_clone/Utils/utils.dart';
import 'package:instagram_clone/Widgets/TextFieldInput.dart';
import 'package:instagram_clone/responsive/mobile_Screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .logInUser(email: _email.text, password: _password.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void NavigateToSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //image
              Container(
                height: 64,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://www.pngkey.com/png/detail/1-13459_instagram-font-logo-white-png-instagram-white-text.png'),
                  ),
                ),
              ),
              //spacing
              SizedBox(
                height: 64,
              ),
              //textField For email
              TextFieldInput(
                  textEditingController: _email,
                  hintText: "enter your email",
                  textInputType: TextInputType.emailAddress),
              //spacing
              SizedBox(
                height: 24,
              ),
              //textField For password
              TextFieldInput(
                textEditingController: _password,
                hintText: "enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              //spacing
              SizedBox(
                height: 24,
              ),
              //log in button
              InkWell(
                onTap: logInUser,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              //spacing
              SizedBox(
                height: 24,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Dont have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: NavigateToSignUp,
                    child: Container(
                      child: const Text(
                        ' Signup.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
