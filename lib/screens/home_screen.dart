

import 'package:flutter/material.dart';
import 'package:notepad/notepad_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textController = TextEditingController();
  final NotepadService _notepadService = NotepadService();
  String _notepadContent = '';

  // Save content
  void _saveContent() async {
    await _notepadService.saveToFile("${_textController.text.trim()}\n");
    _textController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved successfully')));
    });
  }

  // Append content
  void _appendContent() async {
    await _notepadService.appendToFile('${_textController.text.trim()}\n');
    _textController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Appended successfully')));
    });
  }

  // Read content
  void _readContent() async {
    String content = await _notepadService.readFromFile();
    setState(() {
      _notepadContent = content;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _textController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter text to save or append...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter text";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveContent();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _appendContent();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Append'),
                    ),
                    ElevatedButton(
                      onPressed: _readContent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Read'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _notepadContent,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
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
