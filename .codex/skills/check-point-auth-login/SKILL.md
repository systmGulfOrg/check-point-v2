---
name: check-point-auth-login
description: Implement or review Check Point authentication and login work. Use for roles, login requests, session persistence, device identity, biometrics, auth Cubits/use cases/repositories, and auth tests.
---

# Check Point auth role

Read `AGENTS.md` and `references/auth-login-context.md`. Preserve the existing `auth/data/repos` contract convention unless the task explicitly requests a migration. Keep orchestration in `LoginUseCase`, state transitions in Cubits, and API/storage access in repositories and core services.

Treat role matching, device identity, token persistence, biometric fallback, logout/clear behavior, and localized failure keys as observable behavior. Never expose credentials or raw exceptions. Use secure storage for tokens and secrets. Add tests for success, role mismatch, unavailable biometrics, invalid biometric session, repository failures, and every storage side effect affected by the change.
