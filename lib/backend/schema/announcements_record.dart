import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AnnouncementsRecord extends FirestoreRecord {
  AnnouncementsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "publishDate" field.
  DateTime? _publishDate;
  DateTime? get publishDate => _publishDate;
  bool hasPublishDate() => _publishDate != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _message = snapshotData['message'] as String?;
    _publishDate = snapshotData['publishDate'] as DateTime?;
    _isActive = snapshotData['isActive'] as bool?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('announcements');

  static Stream<AnnouncementsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AnnouncementsRecord.fromSnapshot(s));

  static Future<AnnouncementsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AnnouncementsRecord.fromSnapshot(s));

  static AnnouncementsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AnnouncementsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AnnouncementsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AnnouncementsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AnnouncementsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AnnouncementsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAnnouncementsRecordData({
  String? title,
  String? message,
  DateTime? publishDate,
  bool? isActive,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'message': message,
      'publishDate': publishDate,
      'isActive': isActive,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class AnnouncementsRecordDocumentEquality
    implements Equality<AnnouncementsRecord> {
  const AnnouncementsRecordDocumentEquality();

  @override
  bool equals(AnnouncementsRecord? e1, AnnouncementsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.message == e2?.message &&
        e1?.publishDate == e2?.publishDate &&
        e1?.isActive == e2?.isActive &&
        e1?.type == e2?.type;
  }

  @override
  int hash(AnnouncementsRecord? e) => const ListEquality()
      .hash([e?.title, e?.message, e?.publishDate, e?.isActive, e?.type]);

  @override
  bool isValidKey(Object? o) => o is AnnouncementsRecord;
}
