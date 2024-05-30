enum ExceptionAlertType {
  oneButtonDialog(value: 1),
  twoButtonDialog(value: 2),
  snackBar(value: 3);

  final int value;

  const ExceptionAlertType({required this.value});
}
