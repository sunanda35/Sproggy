import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  final String data;
  Second({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
