enum GenderCode {
  man(value: 1, name: '남자'),
  women(value: 2, name: '여자'),
  unknown(value: -1, name: 'unknown');

  final int value;
  final String name;

  const GenderCode({required this.value, required this.name});

  GenderCode fromValue(int value) {
    return switch (value) {
      1 => GenderCode.man,
      2 => GenderCode.women,
      _ => GenderCode.unknown,
    };
  }

  GenderCode fromName(String name) {
    return switch (name) {
      '남자' => GenderCode.man,
      '여자' => GenderCode.women,
      _ => GenderCode.unknown,
    };
  }
}
