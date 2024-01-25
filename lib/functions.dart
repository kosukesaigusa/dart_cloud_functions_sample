import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';

import 'src/config.dart';
import 'src/function_types.dart';

@CloudFunction()
Future<void> oncreateuser(CloudEvent event, RequestContext context) async {
  final subject = event.subject;
  final headers = context.request.headers;
  final eventDataRuntimeType = event.data.runtimeType;
  final xDataRunTimeTypes = context.responseHeaders['x-data-runtime-types'];
  final eventData = event.data! as List<int>;

  context.logger.info('subject: $subject');
  context.logger.info('headers: ${jsonEncode(headers)}');
  context.logger.info('eventDataRuntimeType: $eventDataRuntimeType');
  context.logger.info('xDataRunTimeTypes: $xDataRunTimeTypes');
  context.logger.info('eventData: ${eventData.join(', ')}');

  context.responseHeaders['x-data-runtime-types'] =
      event.data.runtimeType.toString();
  final documentEventData =
      DocumentEventData.fromBuffer(event.data! as List<int>);
  final json = documentEventData.toProto3Json()! as Map<String, dynamic>;
  stderr.writeln(jsonEncode(json));
  final documentSnapshot = await firestore
      .doc(
        '/v2Expense/hWou6fxFY6MZcGFxpHKkYcH4Iym2/expenses/qjKzjA0bWIzuxbcnS807',
      )
      .get();
  print(documentSnapshot);
}
