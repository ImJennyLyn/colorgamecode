class AuthenticationService {
  static List<Map<String, String>> users = [];

  // Sign up method
  static Future<bool> signUp(String username, String password) async {
    // Simulate an asynchronous operation (e.g., contacting a server)
    await Future.delayed(Duration(seconds: 2));

    // Check if the username is already taken
    if (users.any((user) => user['username'] == username)) {
      return false; // Username is taken
    }

    // Add the new user
    users.add({'username': username, 'password': password});
    return true; // Sign-up success
  }

  // Log in method
  static Future<bool> logIn(String username, String password) async {
    // Simulate an asynchronous operation (e.g., contacting a server)
    await Future.delayed(Duration(seconds: 2));

    // Check if the provided username and password match any user
    return users.any(
        (user) => user['username'] == username && user['password'] == password);
  }
}
