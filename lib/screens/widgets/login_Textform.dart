import 'package:flutter/material.dart';

class LoginTextform extends StatefulWidget {

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isObscure;

  LoginTextform({
    super.key,
    required this.label,
    required this.hintText,
    this.isObscure = false,
    required this.controller,
    });

  @override
  State<LoginTextform> createState() => _LoginTextformState();
}

class _LoginTextformState extends State<LoginTextform> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
        style: TextStyle(
          color: Color(0XFFD1A824),
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),),
        SizedBox(height:5),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure ? _obscure : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0XFFD1A824),
                width: 2
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0XFFD1A824),
                width: 2
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0XFFD1A824),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0XFFD1A824),
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15
            ),
            suffixIcon: widget.isObscure ? 
            IconButton(
              onPressed: (){
                setState(() {
                  _obscure = !_obscure;
                });
              },
              icon: Icon(
                color: Colors.grey,
                _obscure? Icons.visibility_off : Icons.visibility,
              ))
            : null,
          ),
        ),
      ],
    );
  }
}