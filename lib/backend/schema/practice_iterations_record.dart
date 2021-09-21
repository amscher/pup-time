import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'practice_iterations_record.g.dart';

abstract class PracticeIterationsRecord
    implements
        Built<PracticeIterationsRecord, PracticeIterationsRecordBuilder> {
  static Serializer<PracticeIterationsRecord> get serializer =>
      _$practiceIterationsRecordSerializer;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'item_id')
  String get itemId;

  @nullable
  @BuiltValueField(wireName: 'level_id')
  String get levelId;

  @nullable
  @BuiltValueField(wireName: 'num_iterations')
  int get numIterations;

  @nullable
  @BuiltValueField(wireName: 'num_iterations_recommended')
  int get numIterationsRecommended;

  @nullable
  @BuiltValueField(wireName: 'started_date')
  DateTime get startedDate;

  @nullable
  @BuiltValueField(wireName: 'last_updated_date')
  DateTime get lastUpdatedDate;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PracticeIterationsRecordBuilder builder) =>
      builder
        ..itemId = ''
        ..levelId = ''
        ..numIterations = 0
        ..numIterationsRecommended = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('practice_iterations');

  static Stream<PracticeIterationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  PracticeIterationsRecord._();
  factory PracticeIterationsRecord(
          [void Function(PracticeIterationsRecordBuilder) updates]) =
      _$PracticeIterationsRecord;

  static PracticeIterationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createPracticeIterationsRecordData({
  DocumentReference user,
  String itemId,
  String levelId,
  int numIterations,
  int numIterationsRecommended,
  DateTime startedDate,
  DateTime lastUpdatedDate,
}) =>
    serializers.toFirestore(
        PracticeIterationsRecord.serializer,
        PracticeIterationsRecord((p) => p
          ..user = user
          ..itemId = itemId
          ..levelId = levelId
          ..numIterations = numIterations
          ..numIterationsRecommended = numIterationsRecommended
          ..startedDate = startedDate
          ..lastUpdatedDate = lastUpdatedDate));
