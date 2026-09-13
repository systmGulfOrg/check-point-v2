/// Normalizes legacy list responses so paged models can consume both:
/// `{ value: [...] }` and `{ value: { items: [...] } }`.
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
