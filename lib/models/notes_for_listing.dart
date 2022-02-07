import 'package:json_annotation/json_annotation.dart';
part 'notes_for_listing.g.dart';

@JsonSerializable()
class NotesForListing {
  final String NoteID;
  final String noteTitle;
  final DateTime? createDateTime;
  final DateTime? lastEditDateTime;

  NotesForListing({
    required this.NoteID,
    required this.createDateTime,
    required this.lastEditDateTime,
    required this.noteTitle,
  });
  factory NotesForListing.FromJson(Map<String, dynamic> json) =>
      _$NotesForListingFromJson(json);
  Map<String, dynamic> toJson() => _$NotesForListingToJson(this);
}
