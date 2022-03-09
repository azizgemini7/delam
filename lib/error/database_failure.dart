class DatabaseFailuer implements Exception {
  final String title;
  final String message;

  DatabaseFailuer({this.title, this.message});
}
