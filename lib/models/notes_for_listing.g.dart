// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_for_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesForListing _$NotesForListingFromJson(Map<String, dynamic> json) =>
    NotesForListing(
      NoteID: json['noteID'] as String,
      createDateTime: json['createDateTime'] == null
          ? null
          : DateTime.parse(json['createDateTime'] as String),
      lastEditDateTime: json['lastEditDateTime'] == null
          ? null
          : DateTime.parse(json['lastEditDateTime'] as String),
      noteTitle: json['noteTitle'] as String,
    );

Map<String, dynamic> _$NotesForListingToJson(NotesForListing instance) =>
    <String, dynamic>{
      'noteID': instance.NoteID,
      'noteTitle': instance.noteTitle,
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'lastEditDateTime': instance.lastEditDateTime?.toIso8601String(),
    };
