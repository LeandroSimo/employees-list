class Utils {
  static String formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      final formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
      return formattedDate;
    } catch (e) {
      return isoDate;
    }
  }

  static String formatPhoneNumber(String phoneNumber) {
    try {
      final cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

      if (cleanedPhoneNumber.length == 13) {
        final ddd = cleanedPhoneNumber.substring(2, 4);
        final firstPart = cleanedPhoneNumber.substring(4, 9);
        final secondPart = cleanedPhoneNumber.substring(9);
        return '+55 ($ddd) $firstPart-$secondPart';
      } else {
        return phoneNumber;
      }
    } catch (e) {
      return phoneNumber;
    }
  }
}
