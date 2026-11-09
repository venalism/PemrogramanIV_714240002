import 'package:flutter/material.dart';
import 'models/contact.dart';
import 'home_screen.dart';
import 'contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Pemrograman IV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: const AppShell(),
    );
  }
}

/// Pemilik state tunggal: daftar kontak hidup selama sesi aplikasi,
/// sehingga data tetap ada saat berpindah Home <-> Daftar Kontak.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  final List<Contact> _contacts = [];

  void _go(int i) => setState(() => _index = i);
  void _add(Contact c) => setState(() => _contacts.add(c));
  void _update(int i, Contact c) => setState(() => _contacts[i] = c);
  void _delete(int i) => setState(() => _contacts.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            contactCount: _contacts.length,
            onOpenContacts: () => _go(1),
          ),
          ContactScreen(
            contacts: _contacts,
            onAdd: _add,
            onUpdate: _update,
            onDelete: _delete,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _go,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: 'Daftar Kontak'),
        ],
      ),
    );
  }
}