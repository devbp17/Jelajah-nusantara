import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jelajah_nusantara/controllers/auth_controller.dart';
import 'package:jelajah_nusantara/screens/auth/Register_Screen.dart';
import 'package:jelajah_nusantara/screens/home/home.dart';
import 'package:jelajah_nusantara/screens/widgets/login_Textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF6F2E5),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Color(0XFFD1A824),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/login.svg',
                    width: 250,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Login',
                style: TextStyle(
                  color: Color(0XFFD1A824),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        LoginTextform(
                        label: "Username",
                        hintText: "Masukkan Username Kamu",
                        controller: _usernamecontroller,
                      ),
                    SizedBox(height: 20),
                      LoginTextform(
                        label: "Password",
                        hintText: "Masukkan Password Kamu",
                        isObscure: true,
                        controller: _passwordcontroller,
                      ),
                    SizedBox(height: 15),
                    Text(
                      "Lupa Password?",
                      style: TextStyle(
                        color: Color(0XFFD1A824),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final message = await AuthController.login(
                    context,
                    _usernamecontroller.text,
                    _passwordcontroller.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFD1A824),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Text(
                  "Belum Punya Akun? Register",
                  style: TextStyle(
                    color: Color(0XFFD1A824),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
