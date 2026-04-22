import 'package:auth_project/output_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFF8B5CF6),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _email;
  bool _rememberMe = false;
  String? _gender;
  String? _country;
  double _age = 18;
  DateTime? _selectedDate;

  final List<String> _countries = [
    'Palestine',
    'Jordan',
    'Egypt',
    'Syria',
    'Iraq'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(
            username: _username,
            password: _password,
            email: _email,
            rememberMe: _rememberMe,
            gender: _gender,
            country: _country,
            age: _age,
            selectedDate: _selectedDate,
          ),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Widget buildField(Widget child) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }

  Widget genderRadio(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _gender,
          onChanged: (val) {
            setState(() {
              _gender = val;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Registration'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF111827)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                buildField(
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                    validator: (v) =>
                        v!.isEmpty ? 'Enter username' : null,
                    onSaved: (v) => _username = v,
                  ),
                ),

                buildField(
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (v) =>
                        v!.length < 6 ? 'Min 6 characters' : null,
                    onSaved: (v) => _password = v,
                  ),
                ),

                buildField(
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (v) =>
                        v!.contains('@') ? null : 'Invalid email',
                    onSaved: (v) => _email = v,
                  ),
                ),

                CheckboxListTile(
                  title: const Text('Remember me'),
                  value: _rememberMe,
                  onChanged: (v) {
                    setState(() => _rememberMe = v ?? false);
                  },
                ),

                // ✅ GENDER RADIO BUTTONS
                buildField(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gender",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          genderRadio("male", "Male"),
                          genderRadio("female", "Female"),
                        ],
                      ),
                    ],
                  ),
                ),

                // COUNTRY
                buildField(
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Country',
                    ),
                    items: _countries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => _country = v,
                  ),
                ),

                Row(
                  children: [
                    const Text("Age"),
                    Expanded(
                      child: Slider(
                        value: _age,
                        min: 18,
                        max: 99,
                        divisions: 81,
                        label: _age.round().toString(),
                        onChanged: (v) => setState(() => _age = v),
                      ),
                    ),
                    Text(_age.round().toString()),
                  ],
                ),

                InkWell(
                  onTap: () => _selectDate(context),
                  child: buildField(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "Select Date"
                              : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ FIXED BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF6366F1),
                       foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submitForm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}