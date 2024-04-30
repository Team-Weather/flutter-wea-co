class ProfileImage {
  int id;
  String imagePath;

  ProfileImage({required this.id, required this.imagePath});

  @override
  String toString() {
    return 'ProfileImage{id: $id, imagePath: $imagePath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imagePath == other.imagePath;

  @override
  int get hashCode => id.hashCode ^ imagePath.hashCode;
}
