import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';

import '../environment_variable.dart';

final _adminApp = FirebaseAdminApp.initializeApp(
  EnvironmentVariable.projectName,
  Credential.fromServiceAccountParams(
    clientId: EnvironmentVariable.clientId,
    privateKey: EnvironmentVariable.privateKey,
    email: EnvironmentVariable.clientEmail,
  ),
);

final firestore = Firestore(_adminApp);
