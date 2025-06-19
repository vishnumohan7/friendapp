import 'package:flutter/material.dart';

class ExecutiveListScreen extends StatefulWidget {
  const ExecutiveListScreen({super.key});

  @override
  State<ExecutiveListScreen> createState() => _ExecutiveListScreenState();
}

class _ExecutiveListScreenState extends State<ExecutiveListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('executive list')));
  }
}
