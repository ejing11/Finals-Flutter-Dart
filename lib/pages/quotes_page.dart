import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final List<String> quotes = [
    'Be kind to yourself.',
    'Every day is a new beginning.',
    'Happiness is a choice.',
    'You are stronger than you think.',
    'Take it one day at a time.',
  ];

  final TextEditingController _controller = TextEditingController();

  void _addQuote() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        quotes.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  void _deleteQuote(int index) {
    setState(() {
      quotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motivational Quotes')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new quote',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _addQuote, child: Text('Add')),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) => Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      quotes[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteQuote(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
