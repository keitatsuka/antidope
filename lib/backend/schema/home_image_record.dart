import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HomeImageRecord extends FirestoreRecord {
  HomeImageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  bool hasImagePath() => _imagePath != null;

  void _initializeFields() {
    _imagePath = snapshotData['imagePath'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('homeImage');

  static Stream<HomeImageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HomeImageRecord.fromSnapshot(s));

  static Future<HomeImageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HomeImageRecord.fromSnapshot(s));

  static HomeImageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HomeImageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HomeImageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HomeImageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HomeImageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HomeImageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHomeImageRecordData({
  String? imagePath,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'imagePath': imagePath,
    }.withoutNulls,
  );

  return firestoreData;
}

class HomeImageRecordDocumentEquality implements Equality<HomeImageRecord> {
  const HomeImageRecordDocumentEquality();

  @override
  bool equals(HomeImageRecord? e1, HomeImageRecord? e2) {
    return e1?.imagePath == e2?.imagePath;
  }

  @override
  int hash(HomeImageRecord? e) => const ListEquality().hash([e?.imagePath]);

  @override
  bool isValidKey(Object? o) => o is HomeImageRecord;
}
