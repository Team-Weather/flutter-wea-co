enum ExceptionAlert {
  dialog(value: 1),
  snackBar(value: 2),
  twoButtonDialog(value: 3);

  final int value;

  const ExceptionAlert({required this.value});
}
