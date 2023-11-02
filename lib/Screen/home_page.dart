import 'package:flutter/material.dart';
import 'package:note_app/Model/note_model.dart';
import 'package:note_app/Screen/note.view.dart';
import 'package:note_app/utils/db.dart';
import 'package:note_app/widgets/loading_widget.dart';
import 'package:note_app/widgets/note_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: newNote, child: Icon(Icons.add_rounded)),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.deepPurple,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                child: Text(
                  "Notes",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Note>>(
              future: DB.instance.future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoadingWidget();

                List<Note> notes = snapshot.data ?? [];

                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    var note = notes[index];

                    return NoteWidget(
                      note: note,
                      onPressed: () => showNote(note),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  newNote() async {
    await push(const NoteView());
    setState(() {});
  }

//ShowNote
  showNote(Note note) async {
    await push(NoteView(note: note));
    setState(() {});
  }

//Delete Note
  deleteNote(Note note) async {
    await DB.instance.delete(note);
    setState(() {});
  }

//Update Note
  updateNote(Note note) async {
    await push(NoteView(note: note));
    setState(() {});
  }
//Push view

  push(Widget view) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );
}
