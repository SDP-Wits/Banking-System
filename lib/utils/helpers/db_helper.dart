String? doubleQuote(String? string) {
  if (string == null) {
    return "null";
  }
  return '"' + string + '"';
}
