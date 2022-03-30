String countryFlag(String countryCode) {
  final String flag = countryCode.toUpperCase().replaceAllMapped(
        RegExp('[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
      );
  return flag;
}

String countryFlagWithSpecialCases(String countryCode) {
  if (countryCode == "en") {
    return countryFlag("gb");
  } else {
    return countryFlag(countryCode);
  }
}
