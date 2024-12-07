class AppRoutes {
  static String HomeRoute = "/home";
  static String DoctorsRoute = "/doctors";
  static String HospitalsRoute = "/hospitals";
  static String profileRoute = "/profile";
  static String loginRoute = "/login";
  static List<String> routesArray = [
    "/home",
    "/doctors",
    "/hospitals",
    "/profile",
    "/login"
  ];
  static Map<String, int> routesIndex = {
    "/home": 0,
    "/doctors": 1,
    "/hospitals": 2,
    "/profile": 3,
    "/login": 4
  };
}
