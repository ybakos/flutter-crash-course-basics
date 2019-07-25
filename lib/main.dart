import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Hello, World!"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Text("One"),
      ),
    ),
  ));
} 
