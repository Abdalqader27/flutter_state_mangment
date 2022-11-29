import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    routes: {
      '/new-contact': (context) => const NewContactView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cookBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final contact = cookBook.get(index);
          return ListTile(
            title: Text(contact!.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
         await Navigator.of(context).pushNamed('/new-contact');
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact View'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: 'Enter your text here...'),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact);
              Navigator.of(context).pop();
            },
            child: const Text('Add Contact'),
          ),
        ],
      ),
    );
  }
}

class Contact {
  final String name;
  Contact({required this.name});
}

class ContactBook {
  ContactBook._();
  static final ContactBook _instance = ContactBook._();

  factory ContactBook() => _instance;

  List<Contact> _contact = [];

  int get length => _contact.length;

  Contact? get(int index) => length > index ? _contact[index] : null;

  void add(Contact contact) {
    _contact.add(contact);
  }

  void remove(Contact contact) {
    _contact.remove(contact);
  }
}
