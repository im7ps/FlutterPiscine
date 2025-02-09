import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget  {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}


class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen to focus changes
    _focusNode.addListener(() {
      print("Focus state: ${_focusNode.hasFocus}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("SKIBIDIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII\n\n\n\n\n");
        _focusNode.requestFocus();
      },
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(
        ),
        decoration: InputDecoration(
          hintText: 'Search city',
        ),
      ),
    );
  }
}

