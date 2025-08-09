import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final studentNumberController = TextEditingController();
  final majorController = TextEditingController();
  final classYearController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void register() async {
    setState(() => isLoading = true);

    final token = await ApiService.registerUser({
      "name": nameController.text,
      "email": emailController.text,
      "student_number": studentNumberController.text,
      "major": majorController.text,
      "class_year": int.tryParse(classYearController.text) ?? 0,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
    });

    setState(() => isLoading = false);

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: token);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal mendaftar")));
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: GoogleFonts.poppins(color: Colors.grey[800]),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Daftar Akun BookEvent',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: _inputDecoration('Nama'),
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: _inputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: studentNumberController,
                  decoration: _inputDecoration('Student Number'),
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: majorController,
                  decoration: _inputDecoration('Jurusan'),
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: classYearController,
                  decoration: _inputDecoration('Tahun Masuk'),
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  decoration: _inputDecoration('Password'),
                  obscureText: true,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: _inputDecoration('Konfirmasi Password'),
                  obscureText: true,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
