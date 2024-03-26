// ignore_for_file: unused_element, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';

import '../../database/sql_helper.dart';
import '../signin/signin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isLoading = false;
  List<Map<String, dynamic>> _journals = [];
  
  Future<void> _refreshJournals() async {
    final data = await SQLHelper.getUsers();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }


  Future<void> _deleteAccount(int id) async {
    await SQLHelper.deleteUser(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted'),
    ));
    _refreshJournals();
  }


  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return const SignIn();
  }
}
