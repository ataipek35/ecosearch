/// Static validation helpers (utility class pattern from the Forms lecture).
class ValidationUtils {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email.trim());
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!isValidEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Use at least 8 characters';
    }
    return null;
  }

  /// New password for the reset flow: 8+ characters with a letter and a number.
  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Use at least 8 characters';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Include at least one letter and one number';
    }
    return null;
  }

  static String? validateResetCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter the 6-digit code';
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value.trim())) {
      return 'The code must be 6 digits';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateBarcode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a barcode';
    }
    if (!RegExp(r'^[0-9]{8,14}$').hasMatch(value.trim())) {
      return 'Barcode must be 8 to 14 digits';
    }
    return null;
  }
}
