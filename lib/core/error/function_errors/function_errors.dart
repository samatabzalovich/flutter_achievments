// import 'package:firebase_core/firebase_core.dart' show FirebaseException;
// import 'package:flutter_achievments/core/error/exception.dart';

// const Map<String, StorageError> authErrorMapping = {
//   'object-not-found': ObjectNotFound(),
//   'bucket-not-found': StorageBucketNotFound(),
//   'quota-exceeded': QuotaExceeded(),
//   'unauthenticated': Unauthenticated(),
//   'retry-limit-exceeded': RetryLimitExceeded(),
//   'invalid-checksum': InvalidChecksum(),
//   'canceled': Canceled(),
//   'server-file-wrong-size': ServerFileWrongSize(),
// };

// abstract class StorageError extends ApiException {


//   const StorageError({
//     required String dialogTitle,
//     required String dialogText,
//   }) : super(dialogTextCode: dialogText, dialogTitleCode: dialogTitle, statusCode: 401);

//   factory StorageError.from(FirebaseException exception) =>
//       authErrorMapping[exception.code.toLowerCase().trim()] ??
//       const StorageErrorUnknown();
// }

// class StorageErrorUnknown extends StorageError {
//   const StorageErrorUnknown()
//       : super(
//           dialogTitle: 'storageErrorUnknown',
//           dialogText: 'storageErrorUnknownText', //An unknown error occurred. Please try again later.
//         );
// }
