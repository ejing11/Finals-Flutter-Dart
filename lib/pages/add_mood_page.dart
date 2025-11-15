import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class AddMoodPage extends StatefulWidget {
  const AddMoodPage({super.key});

  @override
  _AddMoodPageState createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, String>> moods = [
    {'name': 'Happy', 'icon': 'assets/images/happy.png'},
    {'name': 'Sad', 'icon': 'assets/images/sad.png'},
    {'name': 'Angry', 'icon': 'assets/images/angry.png'},
    {'name': 'Tired', 'icon': 'assets/images/tired.png'},
    {'name': 'Excited', 'icon': 'assets/images/excited.png'},
    {'name': 'Confused', 'icon': 'assets/images/confused.png'},
    {'name': 'Stressed', 'icon': 'assets/images/stressed.png'},
    {'name': 'Calm', 'icon': 'assets/images/calm.png'},
  ];

  String _selectedMood = '';
  String _selectedIcon = '';

  @override
  void initState() {
    super.initState();
    _selectedMood = moods[0]['name']!;
    _selectedIcon = moods[0]['icon']!;
  }

  void _submit() {
    final entry = MoodEntry(
      mood: _selectedMood,
      note: _noteController.text.trim(),
      iconPath: _selectedIcon,
    );
    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Mood')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your mood',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: moods.map((m) {
                  final name = m['name']!;
                  final icon = m['icon']!;
                  final selected = name == _selectedMood;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedMood = name;
                      _selectedIcon = icon;
                    }),
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.indigo.shade100
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected ? Colors.indigo : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(icon, width: 36),
                          SizedBox(width: 8),
                          Text(name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text('Optional note', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'How are you feeling today?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.check),
                label: Text('Save Mood'),
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
