abstract interface class RemoteLocationDataSource {
  Future<String> getDong({required double lat, required double lng});
}
