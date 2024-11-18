class EValidate {
  // Empty text validation

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
  }

// EMAIL ADDRESS
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegularExpression = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegularExpression.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

// PASSWORD
  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  // PHONE NUMBER
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required.";
    }

    // Regular expression for phone number validation (assuming a 13 digit PH phone number format)
    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return "Invalid phone number format (11-digit number is required)";
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Product price is required.";
    }

    final priceRegExp = RegExp(r'^\d{}$');
    if (!priceRegExp.hasMatch(value)) {
      return "Invalid price (Only input numbers)";
    }
    return null;
  }
}
