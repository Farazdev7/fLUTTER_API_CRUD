// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      NoteID: json['noteID'] as String,
      createDateTime: json['createDateTime'] == null
          ? null
          : DateTime.parse(json['createDateTime'] as String),
      lastEditDateTime: json['lastEditDateTime'] == null
          ? null
          : DateTime.parse(json['lastEditDateTime'] as String),
      noteTitle: json['noteTitle'] as String,
      noteContent: json['noteContent'] as String,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'noteID': instance.NoteID,
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'lastEditDateTime': instance.lastEditDateTime?.toIso8601String(),
    };
