import 'package:cloud_firestore/cloud_firestore.dart';

/// Timestamp를 DateTime으로 변경합니다.
DateTime convertTimestampToDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}

/// DateTime를 Timestamp으로 변경합니다.
Timestamp convertDateTimeToTimestamp(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}
