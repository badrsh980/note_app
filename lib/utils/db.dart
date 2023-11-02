import 'dart:convert';
import 'package:note_app/Model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  DB._();
  static DB get instance => DB._();

  final String key = 'notes';
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  reset() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get all notes
  Future<List<Note>> get future async {
    await reset();

    if (_prefs?.getString(key) == null) {
      await _prefs?.setString(key, json.encode([]));
      await reset();
    }

    String? source = _prefs?.getString(key);
    List<Map<String, dynamic>> mapList = List.from(
      json.decode(source ?? '[]'),
    );

    return mapList.map((e) => Note.fromJson(e)).toList();
  }

// Update All Notes
  _updateAll(List<Note> notes) async {
    await reset();

    await _prefs?.setString(
        key, json.encode(notes.map((e) => e.json).toList()));
  }

  // Insert a note
  insert(Note note) async {
    final notes = await future;
    notes.add(note);
    await _updateAll(notes);
  }

  // Update a note
  updateNote(Note note) async {
    final notes = await future;
    final index =
        notes.indexWhere((existingNote) => existingNote.id == note.id);
    if (index >= 0) {
      notes[index] = note;
      await _updateAll(notes);
    }
  }

  // Delete a note
  delete(Note note) async {
    final notes = await future;

    final index = notes.indexWhere((e) => e.title == note.title);

    if (index >= 0) {
      notes.removeAt(index);

      await _updateAll(notes);
    }
  }
}
