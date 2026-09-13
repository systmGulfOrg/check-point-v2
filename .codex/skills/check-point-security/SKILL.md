---
name: check-point-security
description: Review or implement security-sensitive Check Point Flutter changes. Use for authentication tokens, secure storage, Dio interceptors, network logging, device identity, biometrics, secrets, API input, 401/403 handling, and security audits.
---

# Check Point security role

Read `AGENTS.md` and `references/security-context.md`. Trace secrets end to end before changing code. Tokens, passwords, credentials, and sensitive identifiers belong in secure storage or build-time configuration as appropriate; never hardcode or log them. Network logs must remain redacted and external service clients must not receive the app bearer token accidentally.

Validate external input, preserve typed failure mapping, and check unauthorized/forbidden behavior. Flag an existing risk before making unrelated changes. Add a regression test for each security behavior changed, and run focused analysis/tests.
