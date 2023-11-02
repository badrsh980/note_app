import 'package:flutter/material.dart';
import 'package:note_app/Model/note_model.dart';
import 'package:note_app/utils/db.dart';
import 'package:note_app/widgets/loading_widget.dart';

class NoteView extends StatefulWidget {
  final Note? note;
  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController _textCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    _textCtrl.text = widget.note?.title ?? '';
    _contentCtrl.text = widget.note?.content ?? '';

    super.initState();
  }

  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: Text(
                MaterialLocalizations.of(context).formatShortDate(
                  widget.note?.date ?? DateTime.now(),
                ),
                style: TextStyle(fontSize: 12),
              ),
              actions: [
                IconButton(
                  onPressed: delete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: save,
                  icon: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                TextField(
                  controller: _textCtrl,
                  decoration: InputDecoration(hintText: "Enter your Totle"),
                ),
                Expanded(
                    child: TextField(
                  maxLength: 3000,
                  maxLines: 300,
                  controller: _contentCtrl,
                  decoration: const InputDecoration(
                    hintText: 'content',
                    border: InputBorder.none,
                  ),
                ))
              ],
            ),
          );
  }

  //save Note
  save() async {
    final note = Note(
      id: widget.note?.id,
      title: _textCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
    );
    setLoading(true);

    if (widget.note == null) {
      await insert(note);
    } else {
      await update(note);
    }
  }

  //InsertNote
  insert(Note note) async {
    await DB.instance.insert(note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  //Update Mote
  update(Note note) async {
    await DB.instance.updateNote(note);
    if (!mounted) return;
    Navigator.pop(context);
  }

  //Delete Note
  delete() async {
    setLoading(true);
    await DB.instance.delete(widget.note!);
    if (!mounted) return;
    Navigator.pop(context);
  }

  setLoading([bool enabled = false]) {
    _isLoading = enabled;
  }
}
