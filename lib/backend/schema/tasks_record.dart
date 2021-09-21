import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'tasks_record.g.dart';

abstract class TasksRecord implements Built<TasksRecord, TasksRecordBuilder> {
  static Serializer<TasksRecord> get serializer => _$tasksRecordSerializer;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'due_date')
  DateTime get dueDate;

  @nullable
  @BuiltValueField(wireName: 'created_date')
  DateTime get createdDate;

  @nullable
  String get status;

  @nullable
  @BuiltValueField(wireName: 'item_id')
  String get itemId;

  @nullable
  @BuiltValueField(wireName: 'level_id')
  String get levelId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TasksRecordBuilder builder) => builder
    ..status = ''
    ..itemId = ''
    ..levelId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tasks');

  static Stream<TasksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static TasksRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => TasksRecord(
        (c) => c
          ..user = safeGet(() => toRef(snapshot.data['user']))
          ..dueDate = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['due_date']))
          ..createdDate = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_date']))
          ..status = snapshot.data['status']
          ..itemId = snapshot.data['item_id']
          ..levelId = snapshot.data['level_id']
          ..reference = TasksRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<TasksRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'tasks',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  TasksRecord._();
  factory TasksRecord([void Function(TasksRecordBuilder) updates]) =
      _$TasksRecord;

  static TasksRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createTasksRecordData({
  DocumentReference user,
  DateTime dueDate,
  DateTime createdDate,
  String status,
  String itemId,
  String levelId,
}) =>
    serializers.toFirestore(
        TasksRecord.serializer,
        TasksRecord((t) => t
          ..user = user
          ..dueDate = dueDate
          ..createdDate = createdDate
          ..status = status
          ..itemId = itemId
          ..levelId = levelId));
