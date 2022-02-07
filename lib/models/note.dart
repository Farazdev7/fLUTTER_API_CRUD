import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final String NoteID;
  final String noteTitle;
  final String noteContent;
  final DateTime? createDateTime;
  final DateTime? lastEditDateTime;

  Note({
    required this.NoteID,
    required this.createDateTime,
    required this.lastEditDateTime,
    required this.noteTitle,
    required this.noteContent,
  });
  factory Note.FromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
