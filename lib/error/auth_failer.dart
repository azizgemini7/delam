 class AuthFailuer implements Exception {
  final String title;
  final String message;

  AuthFailuer({this.title, this.message});
}
