import 'package:apicrudoperation/models/notes_for_listing.dart';
import 'package:apicrudoperation/screens/note_delete.dart';
import 'package:apicrudoperation/screens/note_modift.dart';
import 'package:apicrudoperation/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

DateTime time = DateTime.now();

class NoteListSceen extends StatefulWidget {
  @override
  State<NoteListSceen> createState() => _NoteListSceenState();
}

class _NoteListSceenState extends State<NoteListSceen> {
  String formateDateTime(DateTime? dateTime) {
    return '${dateTime?.day}/${dateTime?.month}/${dateTime?.year}';
  }

  NoteService get service => GetIt.instance<NoteService>();
  List<NotesForListing>? _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNoteList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (_) => NoteModify(
                        noteID: '',
                      )))
              .then((value) => _fetchNotes());
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (_) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.separated(
            itemCount: _apiResponse!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 16),
                  child: const Align(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                key: ValueKey(_apiResponse?[index].NoteID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context,
                      builder: (
                        _,
                      ) =>
                          const NoteDeleteDialogue());
                  if (result) {
                    final bool deleteResult =
                        await service.daleteNote(_apiResponse![index].NoteID);
                    String status = deleteResult
                        ? 'Note Deleted Successfully'
                        : 'An error occured';
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
                            )).then((value) => _fetchNotes());
                  }
                },
                child: ListTile(
                  tileColor: Colors.white,
                  textColor: Colors.black,
                  leading: const CircleAvatar(
                    child: Icon(Icons.note),
                  ),
                  title: Text(
                    _apiResponse![index].noteTitle.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                  subtitle: Text(
                      'Last edited ${formateDateTime(_apiResponse![index].lastEditDateTime ?? _apiResponse![index].createDateTime)}'),
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                          builder: (_) => NoteModify(
                                noteID: _apiResponse![index].NoteID,
                              )),
                    )
                        .then((value) {
                      _fetchNotes();
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.green,
            ),
          ),
        );
      }),
    );
  }
}
