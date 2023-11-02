import 'package:flutter/material.dart';
import 'package:note_app/Model/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final Function()? onPressed;
  const NoteWidget({super.key, required this.note, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Container(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title :  ${note.title ?? ''}',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Date : ' +
                        MaterialLocalizations.of(context)
                            .formatShortDate(note.date ?? DateTime.now()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'content :  ${note.content ?? ''}',
                    maxLines: 3,
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
