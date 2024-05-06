abstract interface class LocationRemoteDataSource {
  Future<String> getDong({required double lat, required double lng});
}
