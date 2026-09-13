# Testing context

- Existing tests cover core network failure mapping, auth Cubit behavior, supervisor Cubits, admin models, admin Cubits, and a sanity route check.
- Test paths mirror `lib/` paths.
- Use fake repositories for real Cubit-body tests and mocktail where interaction assertions are needed.
- Assert localization failure keys, model field projections, request construction, secure-storage writes, list mutations, and emitted state transitions when applicable.
- Generator changes require build-runner before analysis/tests.
