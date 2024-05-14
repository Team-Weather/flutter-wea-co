extension DateTimeFormat on DateTime {
  String toFormat() {
    final midday = hour > 12 ? '오후' : '오전';
    return '$month월 $day일    $midday ${hour > 12 ? hour - 12 : hour}시 $minute분';
  }
}