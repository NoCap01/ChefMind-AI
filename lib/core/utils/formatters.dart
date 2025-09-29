import 'package:intl/intl.dart';

class AppFormatters {
  // Currency formatting
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 2,
  );

  static String currency(double amount) {
    return _currencyFormatter.format(amount);
  }

  // Number formatting
  static String decimal(double number, {int decimalPlaces = 1}) {
    return number.toStringAsFixed(decimalPlaces);
  }

  static String percentage(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  static String compact(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  // Date formatting
  static final DateFormat _dateFormatter = DateFormat('MMM d, y');
  static final DateFormat _timeFormatter = DateFormat('h:mm a');
  static final DateFormat _dateTimeFormatter = DateFormat('MMM d, y • h:mm a');

  static String date(DateTime dateTime) {
    return _dateFormatter.format(dateTime);
  }

  static String time(DateTime dateTime) {
    return _timeFormatter.format(dateTime);
  }

  static String dateTime(DateTime dateTime) {
    return _dateTimeFormatter.format(dateTime);
  }

  static String relativeDatetime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today • ${time(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday • ${time(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${DateFormat('EEEE').format(dateTime)} • ${time(dateTime)}';
    } else {
      return AppFormatters.dateTime(dateTime);
    }
  }

  // Recipe specific formatting
  static String cookingTime(Duration duration) {
    if (duration.inHours > 0) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      if (minutes > 0) {
        return '$hours hr $minutes min';
      } else {
        return '$hours hr';
      }
    } else {
      return '${duration.inMinutes} min';
    }
  }

  static String servings(int servings) {
    return '$servings serving${servings == 1 ? '' : 's'}';
  }

  static String rating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String ratingWithCount(double rating, int count) {
    return '${rating.toStringAsFixed(1)} (${compact(count)})';
  }

  static String calories(double calories) {
    return '${calories.toStringAsFixed(0)} cal';
  }

  static String weight(double grams) {
    if (grams >= 1000) {
      return '${(grams / 1000).toStringAsFixed(1)} kg';
    } else {
      return '${grams.toStringAsFixed(0)}g';
    }
  }

  static String volume(double milliliters) {
    if (milliliters >= 1000) {
      return '${(milliliters / 1000).toStringAsFixed(1)} L';
    } else {
      return '${milliliters.toStringAsFixed(0)} ml';
    }
  }

  // Ingredient quantity formatting
  static String ingredientQuantity(double quantity, String unit) {
    String formattedQuantity;

    if (quantity == quantity.truncate()) {
      formattedQuantity = quantity.truncate().toString();
    } else if (quantity < 1) {
      // Handle fractions better for small amounts
      if (quantity == 0.25) return '1/4 $unit';
      if (quantity == 0.33 || quantity == 0.333) return '1/3 $unit';
      if (quantity == 0.5) return '1/2 $unit';
      if (quantity == 0.67 || quantity == 0.667) return '2/3 $unit';
      if (quantity == 0.75) return '3/4 $unit';
      formattedQuantity = quantity
          .toStringAsFixed(2)
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    } else {
      formattedQuantity =
          quantity.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
    }

    return '$formattedQuantity $unit';
  }

  // Text formatting
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static String camelCaseToTitle(String camelCase) {
    return camelCase
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }

  // Social formatting
  static String followersCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M followers';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K followers';
    } else {
      return '$count follower${count == 1 ? '' : 's'}';
    }
  }

  static String likesCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M likes';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K likes';
    } else {
      return '$count like${count == 1 ? '' : 's'}';
    }
  }
}
