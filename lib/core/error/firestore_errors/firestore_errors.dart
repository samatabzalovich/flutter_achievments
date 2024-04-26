import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_achievments/core/error/exception.dart';

const Map<String, FireStoreError> firestoreErrorMapping = {
  'permission-denied': PermissionDenied(),
  'unauthenticated': Unauthenticated(),
  'already-exists': AlreadyExists(),
  'not-found': NotFound(),
};

abstract class FireStoreError extends ApiException {

  const FireStoreError({
    required String dialogTitle,
    required String dialogText,
  }) : super(dialogTextCode: dialogText, dialogTitleCode: dialogTitle, statusCode: 401);

  factory FireStoreError.from(FirebaseException exception) =>
      firestoreErrorMapping[exception.code.toLowerCase().trim()] ??
      const FirestoreErrorUnknown();
}

class FirestoreErrorUnknown extends FireStoreError {
  const FirestoreErrorUnknown()
      : super(
          dialogTitle: 'firestoreErrorUnknown',
          dialogText: 'firestoreErrorUnknownText', //An unknown error occurred. Please try again later.
        );
}

// firestore/permission-denied

class PermissionDenied extends FireStoreError {
  const PermissionDenied()
      : super(
          dialogTitle: 'error',
          dialogText: 'permissionDeniedText', // No object exists at the desired reference.
        );
}

// firestore/unauthenticated

class Unauthenticated extends FireStoreError {
  const Unauthenticated()
      : super(
          dialogTitle: 'error',
          dialogText: 'unauthenticatedText', // No bucket is configured for Firebase Storage.
        );
}


// firestore/already-exists

class AlreadyExists extends FireStoreError {
  const AlreadyExists()
      : super(
          dialogTitle: 'error',
          dialogText: 'alreadyExistsText', // No bucket is configured for Firebase Storage.
        );
}

// firestore/not-found

class NotFound extends FireStoreError {
  const NotFound()
      : super(
          dialogTitle: 'error',
          dialogText: 'notFoundText', // No bucket is configured for Firebase Storage.
        );
}