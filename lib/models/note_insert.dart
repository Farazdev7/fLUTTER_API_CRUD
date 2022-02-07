import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class NoteInsert {
  String noteTitle;
  String noteContent;
  NoteInsert({
    required this.noteContent,
    required this.noteTitle,
  });

  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'noteContent': noteContent,
    };
  }
}
