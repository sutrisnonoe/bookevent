import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class AddEventScreen extends StatefulWidget {
  final String token;

  const AddEventScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _maxParticipantsController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _submitForm() async {
    final success = await ApiService.createEvent(
      token: widget.token,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: _startDateController.text.trim(),
      endDate: _endDateController.text.trim(),
      time: _timeController.text.trim(),
      location: _locationController.text.trim(),
      maxAttendees: int.tryParse(_maxParticipantsController.text.trim()) ?? 0,
      category: _categoryController.text.trim(),
      price: int.tryParse(_priceController.text.trim()) ?? 0,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event berhasil ditambahkan')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menambahkan event')));
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Events Menu',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
                arguments: widget.token,
              );
            },
          ),
        ],
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
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('Title'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration('Description'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _startDateController,
                decoration: _inputDecoration('Start Date (YYYY-MM-DD)'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _endDateController,
                decoration: _inputDecoration('End Date (YYYY-MM-DD)'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: _inputDecoration('Time (HH:MM:SS)'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: _inputDecoration('Location'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _maxParticipantsController,
                decoration: _inputDecoration('Max Participants'),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _categoryController,
                decoration: _inputDecoration('Category'),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: _inputDecoration('Price'),
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
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
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
