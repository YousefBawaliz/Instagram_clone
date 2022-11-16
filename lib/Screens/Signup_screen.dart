import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resources/firebase_auth.dart';
import 'package:instagram_clone/Screens/Login_screen.dart';
import 'package:instagram_clone/Utils/colors.dart';
import 'package:instagram_clone/Utils/utils.dart';
import 'package:instagram_clone/Widgets/TextFieldInput.dart';
import 'package:instagram_clone/responsive/mobile_Screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _username = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _bio.dispose();
    _username.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _email.text,
      password: _password.text,
      username: _username.text,
      bio: _bio.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void NavigateToLogIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LogInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                height: 24,
              ),

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              //spacing
              SizedBox(
                height: 24,
              ),
              //textfield for username
              TextFieldInput(
                  textEditingController: _username,
                  hintText: "enter your username",
                  textInputType: TextInputType.text),
              //spacing
              SizedBox(
                height: 24,
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
              //textField For bio
              TextFieldInput(
                textEditingController: _bio,
                hintText: "enter your bio",
                textInputType: TextInputType.text,
              ),
              //spacing
              SizedBox(
                height: 24,
              ),
              //sign up button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Sign up"),
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
                      'already have an account ?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: NavigateToLogIn,
                    child: Container(
                      child: const Text(
                        ' Log in.',
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
