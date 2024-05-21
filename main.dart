import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemoListScreen(),
    );
  }
}

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({Key? key}) : super(key: key);

  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  final List<String> _memos = [];

  void _addMemo(String memo) {
    setState(() {
      _memos.add(memo);
    });
  }

  void _deleteMemo(int index) {
    setState(() {
      _memos.removeAt(index);
    });
  }

  void _showAddMemoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newMemo = '';
        return AlertDialog(
          title: const Text('Add Memo'),
          content: TextField(
            onChanged: (value) {
              newMemo = value;
            },
            decoration: const InputDecoration(hintText: "Enter memo here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newMemo.isNotEmpty) {
                  _addMemo(newMemo);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo App'),
      ),
      body: ListView.builder(
        itemCount: _memos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_memos[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteMemo(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
