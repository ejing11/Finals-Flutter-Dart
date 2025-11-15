import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import 'add_mood_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MoodEntry> _moodList = [];

  void _addMood(MoodEntry entry) {
    setState(() => _moodList.insert(0, entry));
  }

  Future<void> _openAddMood() async {
    final result = await Navigator.push<MoodEntry>(
      context,
      MaterialPageRoute(builder: (_) => AddMoodPage()),
    );
    if (result != null) _addMood(result);
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('About MoodMate'),
        content: Text(
          'MoodMate — a simple daily mood tracker built with Flutter.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MoodMate'), centerTitle: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddMood,
        tooltip: 'Add Mood',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(
                icon: Icon(Icons.format_quote),
                onPressed: () => Navigator.pushNamed(context, '/quotes'),
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () => _showAbout(context),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: _moodList.isEmpty
                    ? null
                    : () => setState(() => _moodList.clear()),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Log your mood and reflect on your day.'),
                      ],
                    ),
                  ),
                  Icon(Icons.mood, size: 40, color: Colors.indigo),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Entries',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text('${_moodList.length} total'),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: _moodList.isEmpty
                  ? Center(
                      child: Text(
                        'No moods logged yet. Tap + to add one.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _moodList.length,
                      itemBuilder: (context, index) {
                        final entry = _moodList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Image.asset(entry.iconPath, width: 48),

                            // MAIN CONTENT
                            title: Text(
                              entry.mood,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (entry.note.isNotEmpty) Text(entry.note),
                                SizedBox(height: 4),
                                Text(
                                  '${entry.createdAt.toLocal()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,

                            // DELETE BUTTON ON THE SIDE
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Delete Entry'),
                                    content: Text(
                                      'Are you sure you want to delete this mood entry?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldDelete == true) {
                                  setState(() {
                                    _moodList.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
