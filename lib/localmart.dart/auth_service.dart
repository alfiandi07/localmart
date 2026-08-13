class UserAccount {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String profileImageUrl;
  final String status;
  final DateTime joinedDate;

  UserAccount({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.profileImageUrl = '',
    this.status = 'Member Terverifikasi',
    DateTime? joinedDate,
  }) : joinedDate = joinedDate ?? DateTime.now();
}

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  UserAccount? _currentUser;

  // In-memory registered users repository (pre-seeded with a demo user)
  final List<UserAccount> _registeredUsers = [
    UserAccount(
      fullName: 'Budi Santoso',
      email: 'user@localmart.com',
      phone: '081234567890',
      password: 'password123',
      status: 'Member Premium UMKM',
      joinedDate: DateTime(2024, 1, 15),
    ),
  ];

  /// Get currently logged-in user account.
  UserAccount get currentUser =>
      _currentUser ?? _registeredUsers.first;

  /// Check if a user is logged in.
  bool get isLoggedIn => _currentUser != null;

  /// Register a new account.
  /// Returns `true` if successful, `false` if email or phone is already registered.
  bool register(UserAccount account) {
    final emailLower = account.email.trim().toLowerCase();
    final phoneTrim = account.phone.trim();

    final isExisting = _registeredUsers.any(
      (u) =>
          u.email.trim().toLowerCase() == emailLower ||
          u.phone.trim() == phoneTrim,
    );

    if (isExisting) {
      return false;
    }

    _registeredUsers.add(account);
    _currentUser = account;
    return true;
  }

  /// Check if an email or phone number is registered.
  bool isRegistered(String identifier) {
    final query = identifier.trim().toLowerCase();
    return _registeredUsers.any(
      (u) => u.email.trim().toLowerCase() == query || u.phone.trim() == query,
    );
  }

  /// Attempt login with email/phone and password.
  /// Returns the [UserAccount] if credentials are valid, `null` otherwise.
  UserAccount? login(String identifier, String password) {
    final query = identifier.trim().toLowerCase();
    try {
      final account = _registeredUsers.firstWhere(
        (u) =>
            (u.email.trim().toLowerCase() == query ||
                u.phone.trim() == query) &&
            u.password == password,
      );
      _currentUser = account;
      return account;
    } catch (_) {
      return null;
    }
  }

  /// Set the active logged-in user.
  void setCurrentUser(UserAccount account) {
    _currentUser = account;
  }

  /// Logout current user session.
  void logout() {
    _currentUser = null;
  }
}
