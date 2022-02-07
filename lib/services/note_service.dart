import 'dart:convert';

import 'package:apicrudoperation/models/note.dart';
import 'package:apicrudoperation/models/note_insert.dart';
import 'package:apicrudoperation/models/notes_for_listing.dart';
import 'package:apicrudoperation/screens/note_list.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';

  static const headers = {
    'apiKey': "8290f403-9cfc-41ab-b5f5-6915d68796a1",
    'Content-Type': 'application/json',
  };
  var errorcode;

  Future<List<NotesForListing>> getNoteList() {
    final notes = <NotesForListing>[];
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        for (var item in jsonData) {
          notes.add(NotesForListing.FromJson(item));
        }
        return notes;
      } else {
        errorcode = data.statusCode;
        notes.add(NotesForListing(
            NoteID: 'error occured master',
            createDateTime: time,
            lastEditDateTime: time,
            noteTitle: 'error $errorcode'));
        return notes;
      }
    });
  }

  Future<Note> getNote(String noteID) {
    return http
        .get(Uri.parse(API + '/notes/' + noteID), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        return Note.FromJson(jsonData);
      } else {
        errorcode = data.statusCode;
        return Note(
            NoteID: 'null',
            createDateTime: time,
            lastEditDateTime: time,
            noteTitle: 'error $errorcode',
            noteContent: 'no kontent');
      }
    });
  }

  //create a note
  Future<bool> createNote(NoteInsert item) {
    return http
        .post(Uri.parse(API + '/notes/'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    });
  }

  //update a note
  Future<bool> updateNote(NoteInsert item, String noteID) {
    return http
        .put(Uri.parse(API + '/notes/' + noteID),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    });
  }

  //delete a note
  Future<bool> daleteNote(String noteID) {
    return http
        .delete(Uri.parse(API + '/notes/' + noteID), headers: headers)
        .then((data) {
      if (data.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    });
  }
}
