Map<String, String> filterMap(Map<String, String> inputMap) {
  return Map.fromEntries(
    inputMap.entries.where((entry) => entry.value.isNotEmpty),
  );
}
