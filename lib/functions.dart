import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

@CloudFunction()
Response function(Request request) => Response.ok('Hello, World!');

@CloudFunction()
Response function2(Request request) => Response.ok('Hello, World2!');
