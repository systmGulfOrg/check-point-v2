---
name: check-point-testing
description: Design or add tests for Check Point Flutter changes. Use for Cubits, repositories, use cases, widget chains, auth, API failure mapping, storage side effects, pagination, and regression coverage.
---

# Check Point testing role

Read `AGENTS.md` and `references/testing-context.md`. Mirror `lib/` under `test/`, use `flutter_test`, `bloc_test`, and `mocktail`, and keep tests deterministic with one main behavior per test. Cover success and every distinct failure shape. Assert projected fields and side effects, not only emitted state types.

For screen flows, include at least one widget test exercising the real Cubit body against a fake repository. For generated models or API changes, run generation before tests. Prefer a focused regression test that proves the bug is fixed.
