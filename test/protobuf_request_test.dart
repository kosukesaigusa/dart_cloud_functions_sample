import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

import 'helper/creating_document.dart';
import 'src/test_utils.dart';

void main() {
  test('valid proto input', () async {
    // final proc = await _hostCloudEventHandler();
    final response = await http.post(
      Uri.parse('http://localhost:8080/'),
      body: protobufBytesWhenCreatingDocument,
      headers: {
        'ce-id': '785865c0-2b16-439b-ad68-f9672343863a',
        'ce-source':
            '//firestore.googleapis.com/projects/flutter-account-book/databases/(default)',
        'ce-specversion': '1.0',
        'ce-type': 'google.cloud.firestore.document.v1.updated',
        'Content-Type': 'application/protobuf',
        'ce-dataschema':
            'https://github.com/googleapis/google-cloudevents/blob/main/proto/google/events/cloud/firestore/v1/data.proto',
        'ce-subject': 'documents/users/ghXNtePIFmdDOBH3iEMH',
        'ce-time': '2023-06-21T12:21:25.413855Z',
      },
    );
    expect(response.statusCode, 200);
    expect(response.body, isEmpty);
    expect(
      response.headers,
      allOf(
        containsPair('content-type', 'text/plain; charset=utf-8'),
        containsPair('x-data-runtime-types', 'Uint8List'),
      ),
    );
    // await finishServerTest(
    //   proc,
    //   requestOutput: endsWith('POST    [200] /'),
    // );

    // final stderrOutput = await proc.stderrStream().join('\n');
    // final json = jsonDecode(stderrOutput) as Map<String, dynamic>;

    // expect(json, jsonOutput);
  });
}

Future<TestProcess> _hostCloudEventHandler() async {
  final proc = await startServerTest(
    arguments: [
      '--target=oncreateuser',
      '--signature-type=cloudevent',
    ],
  );
  return proc;
}
