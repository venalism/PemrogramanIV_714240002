import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import 'models/contact.dart';

class ContactScreen extends StatefulWidget {
  final List<Contact> contacts;
  final void Function(Contact) onAdd;
  final void Function(int, Contact) onUpdate;
  final void Function(int) onDelete;

  const ContactScreen({
    super.key,
    required this.contacts,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _fileCtrl = TextEditingController();
  final _fmt = DateFormat('dd-MM-yyyy');

  DateTime? _date;
  Color _color = Colors.blue; // warna bawaan
  String? _fileName;
  Uint8List? _fileBytes;
  int? _editIndex; // null = mode tambah, bukan null = mode ubah

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _dateCtrl.dispose();
    _fileCtrl.dispose();
    super.dispose();
  }

  // ---------- Validator ----------
  String? _validateName(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Nama wajib diisi';
    if (!RegExp(r'^[A-Za-z ]+$').hasMatch(s)) {
      return 'Nama hanya boleh berisi huruf dan spasi';
    }
    final words = s.split(RegExp(r' +'));
    if (words.length < 2) return 'Nama minimal terdiri dari dua kata';
    for (final w in words) {
      if (!RegExp(r'^[A-Z]').hasMatch(w)) {
        return 'Setiap kata harus diawali huruf kapital';
      }
    }
    return null;
  }

  String? _validatePhone(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Nomor telepon wajib diisi';
    if (!RegExp(r'^[0-9]+$').hasMatch(s)) {
      return 'Nomor hanya boleh berisi digit 0-9';
    }
    if (!s.startsWith('62')) return 'Nomor harus diawali 62 (tanpa +)';
    if (s.length < 8 || s.length > 13) {
      return 'Panjang nomor 8-13 digit (termasuk 62)';
    }
    return null;
  }

  String? _validateDate(String? _) =>
      _date == null ? 'Tanggal wajib dipilih' : null;

  String? _validateFile(String? _) =>
      _fileName == null ? 'Berkas wajib dipilih' : null;

  // ---------- Picker ----------
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year + 5),
    );
    if (!mounted || picked == null) return; // batal: pilihan lama dipertahankan
    setState(() {
      _date = picked;
      _dateCtrl.text = _fmt.format(picked);
    });
  }

  Future<void> _pickColor() async {
    Color temp = _color;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pilih warna'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _color,
            onColorChanged: (c) => temp = c,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _color = temp);
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );
    final file = result?.files.single;
    if (!mounted || file == null) return;
    setState(() {
      _fileName = file.name;
      _fileBytes = file.bytes;
      _fileCtrl.text = file.name;
    });
  }

  // ---------- CRUD ----------
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi isian yang belum valid terlebih dahulu'),
        ),
      );
      return;
    }
    final c = Contact(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text,
      date: _date!,
      color: _color,
      fileName: _fileName!,
      fileBytes: _fileBytes,
    );
    final editing = _editIndex != null;
    if (editing) {
      widget.onUpdate(_editIndex!, c);
    } else {
      widget.onAdd(c);
    }
    _clearForm();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(editing ? 'Kontak diperbarui' : 'Kontak ditambahkan'),
      ),
    );
  }

  void _startEdit(int i) {
    final c = widget.contacts[i];
    setState(() {
      _editIndex = i;
      _nameCtrl.text = c.name;
      _phoneCtrl.text = c.phone;
      _date = c.date;
      _dateCtrl.text = _fmt.format(c.date);
      _color = c.color;
      _fileName = c.fileName;
      _fileBytes = c.fileBytes;
      _fileCtrl.text = c.fileName;
    });
  }

  void _clearForm() {
    setState(() {
      _editIndex = null;
      _nameCtrl.clear();
      _phoneCtrl.clear();
      _dateCtrl.clear();
      _fileCtrl.clear();
      _date = null;
      _fileName = null;
      _fileBytes = null;
      _color = Colors.blue;
    });
    _formKey.currentState?.reset();
  }

  void _confirmDelete(int i) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kontak'),
        content: Text('Hapus kontak "${widget.contacts[i].name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              widget.onDelete(i);
              if (_editIndex == i) {
                _clearForm();
              } else if (_editIndex != null && _editIndex! > i) {
                _editIndex = _editIndex! - 1;
              }
              Navigator.pop(ctx);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // ---------- UI ----------
  InputDecoration _deco(String label, {String? hint, Widget? suffix}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffix,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final editing = _editIndex != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: _deco('Nama', hint: 'Contoh: Budi Santoso'),
                    validator: _validateName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: _deco('Nomor Telepon', hint: '628123456789'),
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _dateCtrl,
                    readOnly: true,
                    onTap: _pickDate,
                    decoration: _deco(
                      'Tanggal',
                      hint: 'dd-MM-yyyy',
                      suffix: const Icon(Icons.calendar_today),
                    ),
                    validator: _validateDate,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('Warna kontak')),
                      ElevatedButton(
                        onPressed: _pickColor,
                        child: const Text('Pilih Warna'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _fileCtrl,
                    readOnly: true,
                    onTap: _pickFile,
                    decoration: _deco(
                      'Berkas',
                      hint: 'Pilih berkas',
                      suffix: const Icon(Icons.attach_file),
                    ),
                    validator: _validateFile,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(editing ? 'Update' : 'Submit'),
                        ),
                      ),
                      if (editing) ...[
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _clearForm,
                          child: const Text('Batal Ubah'),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'List Data',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            if (widget.contacts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('Belum ada kontak')),
              ),
            ...List.generate(widget.contacts.length, (i) {
              final c = widget.contacts[i];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: c.color),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(c.phone),
                                Text(_fmt.format(c.date)),
                                Text(
                                  c.fileName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _startEdit(i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _confirmDelete(i),
                          ),
                        ],
                      ),
                      if (c.isImage && c.fileBytes != null) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            c.fileBytes!,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Text('Pratinjau tidak tersedia'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
