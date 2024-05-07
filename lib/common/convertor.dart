import 'package:cloud_firestore/cloud_firestore.dart';

DateTime convertTimestampToDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}
