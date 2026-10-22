Map<String, dynamic> legacyPageValue(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is List) {
    return <String, dynamic>{
      'items': value,
      'data': value,
      'totalCount': value.length,
    };
  }
  return <String, dynamic>{};
}
