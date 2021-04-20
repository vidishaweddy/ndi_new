class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/session";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}