import 'dart:typed_data';

/// See: https://cloud.google.com/functions/docs/calling/cloud-firestore
enum _CloudEventType {
  created,
  updated,
  deleted,
  written,
  ;

  String get v1EventType => 'google.cloud.firestore.document.v1.$name';
}

class FirestoreTriggerCloudEventMock {
  FirestoreTriggerCloudEventMock.created()
      : _cloudEventType = _CloudEventType.created;

  FirestoreTriggerCloudEventMock.updated()
      : _cloudEventType = _CloudEventType.updated;

  FirestoreTriggerCloudEventMock.deleted()
      : _cloudEventType = _CloudEventType.deleted;

  final _CloudEventType _cloudEventType;

  final String _projectName = '';

  final String _collectionName = 'users';

  final String _documentId = '';

  Uint8List get requestBody => _bytesByEventType;

  ///
  Map<String, String> get requestHeaders => {
        'ce-id': 'cloud-event-id-here',
        'ce-source':
            '//firestore.googleapis.com/projects/$_projectName/databases/(default)',
        'ce-specversion': '1.0',
        'ce-type': _cloudEventType.v1EventType,
        'Content-Type': 'application/protobuf',
        'ce-dataschema':
            'https://github.com/googleapis/google-cloudevents/blob/main/proto/google/events/cloud/firestore/v1/data.proto',
        'ce-subject': 'documents/$_collectionName/$_documentId',
        'ce-time': '2023-06-21T12:21:25.413855Z',
      };

  Map<String, Map<String, Object>> get cloudEventDataAsJson =>
      switch (_cloudEventType) {
        _CloudEventType.created => {
            'value': {
              'name':
                  'projects/flutter-account-book/databases/(default)/documents/$_collectionName/$_documentId',
              'fields': {
                'message': {'stringValue': 'hello'},
              },
              'createTime': '2024-01-23T13:56:02.547087Z',
              'updateTime': '2024-01-23T13:56:02.547087Z',
            },
          },
        _CloudEventType.updated => {},
        _CloudEventType.deleted => {},
        _CloudEventType.written => {},
      };

  Uint8List get _bytesByEventType => Uint8List.fromList(
        switch (_cloudEventType) {
          _CloudEventType.created => [
              10,
              137,
              1,
              10,
              86,
              112,
              114,
              111,
              106,
              101,
              99,
              116,
              115,
              47,
              102,
              108,
              117,
              116,
              116,
              101,
              114,
              45,
              97,
              99,
              99,
              111,
              117,
              110,
              116,
              45,
              98,
              111,
              111,
              107,
              47,
              100,
              97,
              116,
              97,
              98,
              97,
              115,
              101,
              115,
              47,
              40,
              100,
              101,
              102,
              97,
              117,
              108,
              116,
              41,
              47,
              100,
              111,
              99,
              117,
              109,
              101,
              110,
              116,
              115,
              47,
              117,
              115,
              101,
              114,
              115,
              47,
              67,
              70,
              121,
              107,
              55,
              97,
              87,
              49,
              75,
              107,
              75,
              113,
              106,
              67,
              70,
              111,
              68,
              110,
              80,
              113,
              18,
              19,
              10,
              7,
              109,
              101,
              115,
              115,
              97,
              103,
              101,
              18,
              8,
              138,
              1,
              5,
              104,
              101,
              108,
              108,
              111,
              26,
              12,
              8,
              242,
              138,
              191,
              173,
              6,
              16,
              152,
              197,
              239,
              132,
              2,
              34,
              12,
              8,
              242,
              138,
              191,
              173,
              6,
              16,
              152,
              197,
              239,
              132,
              2,
            ],
          _CloudEventType.updated => [],
          _CloudEventType.deleted => [],
          _CloudEventType.written => [],
        },
      );
}
