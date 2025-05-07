import 'package:flutter/material.dart';
import 'timeline_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _login(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TimelineScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _login(context),
          child: const Text('ログイン（仮）'),
        ),
      ),
    );
  }
}
