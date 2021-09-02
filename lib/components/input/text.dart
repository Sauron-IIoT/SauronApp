import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController? controller;

  final String label;
  final String? hint;
  final IconData? icon;
  final bool isSecret;
  final TextInputType inputType = TextInputType.text;

  TextInput({this.controller, this.label = "", this.hint, this.icon, this.isSecret = false});

  @override
  State<StatefulWidget> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        _buildLabel(),
        SizedBox(height: 10),
        _buildInput(),
      ],
    );

  Container _buildInput() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(174, 97, 209, 1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isSecret,
          keyboardType: widget.inputType,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.white54,
              )),
        ),
      );
  }

  Text _buildLabel() {
    return Text(
        widget.label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}
