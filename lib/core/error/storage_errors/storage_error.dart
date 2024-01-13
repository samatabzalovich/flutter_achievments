import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_achievments/core/error/exception.dart';

const Map<String, StorageError> authErrorMapping = {
  'object-not-found': ObjectNotFound(),
  'bucket-not-found': StorageBucketNotFound(),
  'quota-exceeded': QuotaExceeded(),
  'unauthenticated': Unauthenticated(),
  'retry-limit-exceeded': RetryLimitExceeded(),
  'invalid-checksum': InvalidChecksum(),
  'canceled': Canceled(),
  'server-file-wrong-size': ServerFileWrongSize(),
};

abstract class StorageError extends ApiException {


  const StorageError({
    required String dialogTitle,
    required String dialogText,
  }) : super(dialogTextCode: dialogText, dialogTitleCode: dialogTitle, statusCode: 401);

  factory StorageError.from(FirebaseException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const StorageErrorUnknown();
}

class StorageErrorUnknown extends StorageError {
  const StorageErrorUnknown()
      : super(
          dialogTitle: 'storageErrorUnknown',
          dialogText: 'storageErrorUnknownText', //An unknown error occurred. Please try again later.
        );
}

// storage/object-not-found	

class ObjectNotFound extends StorageError {
  const ObjectNotFound()
      : super(
          dialogTitle: 'objectNotFound',
          dialogText: 'objectNotFoundText', // No object exists at the desired reference.
        );
}

// storage/bucket-not-found

class StorageBucketNotFound extends StorageError {
  const StorageBucketNotFound()
      : super(
          dialogTitle: 'bucketNotFound',
          dialogText: 'bucketNotFoundText', // No bucket is configured for Firebase Storage.
        );
}
class AuthErrorInvalidLogin extends StorageError {
  const AuthErrorInvalidLogin()
      : super(
          dialogTitle: 'Invalid login',
          dialogText: 'Please double check your email or password and try again!',
        );
}

class QuotaExceeded extends StorageError {
  const QuotaExceeded()
      : super(
          dialogTitle: 'quotaExceeded',
          dialogText: 'quotaExceededText', // The quota for storage has been exceeded.
        );
}

// storage/unauthenticated

class Unauthenticated extends StorageError {
  const Unauthenticated()
      : super(
          dialogTitle: 'unauthenticated',
          dialogText: 'unauthenticatedText', // User is unauthenticated. Authenticate and try again.
        );
}

// storage/retry-limit-exceeded

class RetryLimitExceeded extends StorageError {
  const RetryLimitExceeded()
      : super(
          dialogTitle: 'retryLimitExceeded',
          dialogText: 'retryLimitExceededText', // The maximum number of retries has been exceeded.
        );
}

// storage/invalid-checksum

class InvalidChecksum extends StorageError {
  const InvalidChecksum()
      : super(
          dialogTitle: 'invalidChecksum',
          dialogText: 'invalidChecksumText', // The checksum of the file does not match.
        );
}

// storage/canceled

class Canceled extends StorageError {
  const Canceled()
      : super(
          dialogTitle: 'canceled',
          dialogText: 'canceledText', // The operation has been canceled.
        );
}

// storage/server-file-wrong-size

class ServerFileWrongSize extends StorageError {
  const ServerFileWrongSize()
      : super(
          dialogTitle: 'serverFileWrongSize',
          dialogText: 'serverFileWrongSizeText', // The file on the server is not the expected size.
        );
}