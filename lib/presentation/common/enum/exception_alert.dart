enum ExceptionAlert {
  dialog(value: 1),
  snackBar(value: 2),
  dialogTwoButton(value: 3);

  final int value;

  const ExceptionAlert({required this.value});
}
