import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final String? username;
  final String? password;
  final String? email;
  final bool? rememberMe;
  final String? gender;
  final String? country;
  final double? age;
  final DateTime? selectedDate;

  const OutputScreen({
    super.key,
    this.username,
    this.password,
    this.email,
    this.rememberMe,
    this.gender,
    this.country,
    this.age,
    this.selectedDate,
  });

  Widget buildInfo(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Output'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF111827)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildInfo('Username', '$username', Icons.person),
              buildInfo('Email', '$email', Icons.email),
              buildInfo('Gender', '$gender', Icons.transgender),
              buildInfo('Country', '$country', Icons.flag),
              buildInfo('Age', '${age?.round()}', Icons.cake),
              buildInfo(
                'Date',
                selectedDate == null
                    ? "Not selected"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                Icons.calendar_month,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}