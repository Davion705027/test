extension MapExtensions on Map<String, dynamic> {
  dynamic get(String keyPath) {
    List<String> keys = keyPath.split('.');
    dynamic value = this;

    for (var key in keys) {
      if (value is Map<String, dynamic>) {
        value = value[key];
      } else if (value is List<dynamic> &&
          key.contains('[') &&
          key.contains(']')) {
        var index =
            int.parse(key.substring(key.indexOf('[') + 1, key.indexOf(']')));
        value = value[index];
      } else {
        return null;
      }
    }

    return value;
  }

  T? safe<T>(dynamic key) {
    if (containsKey(key)) {
      return this[key] as T;
    }
    return null;
  }
}
