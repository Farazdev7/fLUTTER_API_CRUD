import 'package:apicrudoperation/models/note.dart';
import 'package:apicrudoperation/models/note_insert.dart';
import 'package:apicrudoperation/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String noteID;
  NoteModify({required this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  NoteService get noteService => GetIt.instance<NoteService>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;
  late Note note;

  bool isEdiing = false;
  @override
  void initState() {
    super.initState();
    isEdiing = widget.noteID.isNotEmpty;
    if (isEdiing) {
      setState(() {
        _isLoading = true;
      });
      String id = widget.noteID;
      noteService.getNote(id).then((response) {
        note = response;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdiing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Note title'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration:
                        const InputDecoration(hintText: 'content of note'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isEdiing) {
                          //update Note
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteInsert(
                              noteContent: _contentController.text,
                              noteTitle: _titleController.text);
                          String noteID = widget.noteID.toString();
                          bool result =
                              await noteService.updateNote(note, noteID);
                          String status = result
                              ? 'Note Updated Successfully'
                              : 'Error Occured';
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(status),
                              actions: [
                                ElevatedButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          ).then((_) {
                            if (result) {
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          //create Note
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteInsert(
                              noteContent: _contentController.text,
                              noteTitle: _titleController.text);
                          bool result = await noteService.createNote(note);
                          setState(() {
                            _isLoading = false;
                          });
                          String status;
                          if (result == true) {
                            status = 'Note Created Successfully';
                          } else {
                            status = 'Error occurred';
                          }
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(status),
                              actions: [
                                ElevatedButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          ).then((_) {
                            if (result) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
