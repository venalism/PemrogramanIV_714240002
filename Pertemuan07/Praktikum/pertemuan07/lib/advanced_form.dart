import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class AdvancedForm extends StatefulWidget {
  const AdvancedForm({super.key});

  @override
  State<AdvancedForm> createState() => _AdvancedFormState();
}

class _AdvancedFormState extends State<AdvancedForm> {
  // Date Picker
  DateTime _dueDate = DateTime.now();
  final DateTime currentDate = DateTime.now();

  // Color Picker
  Color _currentColor = Colors.orange;

  // File Picker
  String? _dataFile;
  File? _imageFile;
  Uint8List? _imageBytes;

  // ---------------------------------------------------------------
  // A. Date Picker
  // ---------------------------------------------------------------
  Widget buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                  }
                });
              },
              child: const Text('Select'),
            ),
          ],
        ),
        Text(DateFormat('dd-MM-yyyy').format(_dueDate)),
      ],
    );
  }

  // ---------------------------------------------------------------
  // B. Color Picker
  // ---------------------------------------------------------------
  Widget buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pick Your Color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: _currentColor,
                          onColorChanged: (color) {
                            setState(() {
                              _currentColor = color;
                            });
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Select'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _currentColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // C. File Picker
  // ---------------------------------------------------------------
  Future<void> _openFile(String filePath) async {
    await OpenFile.open(filePath);
  }

  Future<void> _pickFile() async {
    final file = await FilePicker.pickFile(
      type: FileType.any,
    );

    if (!mounted || file == null) return;

    final String extension = (file.extension ?? '').toLowerCase();
    final bool isImage = ['jpg', 'jpeg', 'png'].contains(extension);

    // The path property is unavailable on web.
    final String? path = kIsWeb ? null : file.path;

    // Read file bytes for image preview (needed on web, optional elsewhere).
    Uint8List? bytes;
    if (kIsWeb && isImage) {
      bytes = await file.readAsBytes();
    }

    if (!mounted) return;

    setState(() {
      _dataFile = file.name;
      // Android, iOS, and desktop: preview from the file location.
      _imageFile = (isImage && path != null) ? File(path) : null;
      // Web: preview from the file bytes.
      _imageBytes = bytes;
    });

    // open_file does not support web.
    if (path != null) {
      _openFile(path);
    }
  }

  Widget buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'File',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: _pickFile,
              child: const Text('Pick and Open File'),
            ),
          ],
        ),
        if (_dataFile != null) Text('File Name: $_dataFile'),
        if (_imageBytes != null) ...[
          const SizedBox(height: 8),
          Image.memory(
            _imageBytes!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
        if (_imageFile != null) ...[
          const SizedBox(height: 8),
          Image.file(
            _imageFile!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widget'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildDatePicker(context),
            const SizedBox(height: 20),
            buildColorPicker(context),
            const SizedBox(height: 20),
            buildFilePicker(),
          ],
        ),
      ),
    );
  }
}
