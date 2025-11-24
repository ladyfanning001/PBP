import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photobooth_app/screens/preview_screen.dart';

class TemplateScreen extends StatefulWidget {
  final List<String> imagePaths;

  const TemplateScreen({super.key, required this.imagePaths});

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  String _selectedTemplate = 'template1'; // Default template

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Template'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index) {
                return Image.file(File(widget.imagePaths[index]));
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Select a Template:', style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: _selectedTemplate,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTemplate = newValue!;
                    });
                  },
                  items: <String>['template1', 'template2', 'template3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(
                    imagePaths: widget.imagePaths,
                    template: _selectedTemplate,
                  ),
                ),
              );
            },
            child: const Text('Preview'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
