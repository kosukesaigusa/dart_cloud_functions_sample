library;

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

import 'src/test_utils.dart';
import 'test_shared.dart';

void main() {
  test('valid proto input', () async {
    // final proc = await _hostCloudEventHandler();

    const subject = 'documents/users/ghXNtePIFmdDOBH3iEMH';
    final response = await _makeRequest(
      protobytes,
      {
        'ce-id': '785865c0-2b16-439b-ad68-f9672343863a',
        'ce-source':
            '//firestore.googleapis.com/projects/dart-redirector/databases/(default)',
        'ce-specversion': '1.0',
        'ce-type': 'google.cloud.firestore.document.v1.updated',
        'Content-Type': 'application/protobuf',
        'ce-dataschema':
            'https://github.com/googleapis/google-cloudevents/blob/main/proto/google/events/cloud/firestore/v1/data.proto',
        'ce-subject': subject,
        'ce-time': '2023-06-21T12:21:25.413855Z',
      },
    );
    expect(response.statusCode, 200);
    expect(response.body, isEmpty);
    expect(
      response.headers,
      allOf(
        containsTextPlainHeader,
        containsPair('x-data-runtime-types', 'Uint8List'),
      ),
    );
    // await expectLater(
    //   proc.stdout,
    //   emitsInOrder(
    //     [
    //       startsWith('INFO: event subject: $subject'),
    //       startsWith('DEBUG:'),
    //     ],
    //   ),
    // );

    // await finishServerTest(
    //   proc,
    //   requestOutput: endsWith('POST    [200] /'),
    // );

    // final stderrOutput = await proc.stderrStream().join('\n');
    // final json = jsonDecode(stderrOutput) as Map<String, dynamic>;

    // expect(json, jsonOutput);
  });
}

Future<http.Response> _makeRequest(
    Object? body, Map<String, String> headers) async {
  // final requestUrl = Uri.parse('http://localhost:$autoPort/');
  final requestUrl = Uri.parse('http://localhost:8080/');

  final response = await http.post(
    requestUrl,
    body: body,
    headers: headers,
  );
  return response;
}

Future<TestProcess> _hostCloudEventHandler() async {
  final proc = await startServerTest(
    arguments: [
      '--target=oncreateuser',
      '--signature-type=cloudevent',
    ],
    expectedListeningPort: 0,
  );
  return proc;
}

final containsTextPlainHeader =
    containsPair('content-type', 'text/plain; charset=utf-8');
