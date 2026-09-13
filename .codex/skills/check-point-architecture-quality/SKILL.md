---
name: check-point-architecture-quality
description: Implement or review Check Point Flutter architecture and code quality. Use for feature structure, Cubit/Bloc, Freezed, Retrofit, repositories, use cases, DI, ApiResult failures, routing, naming, generated code, and refactors.
---

# Check Point architecture role

Read `AGENTS.md` and `references/architecture-context.md`. Preserve downward dependencies and feature-first structure. Use models directly, never entities. Keep simple one-call Cubits direct to repositories; introduce a use case only for meaningful business logic, orchestration, transformation, or reuse. Keep injected fields public and constructors named. Register dependencies centrally in the prescribed order.

Repositories catch and map exceptions to `ApiResult`; Cubits consume results exhaustively. Never hand-edit generated files. After touching generator inputs, run the required build-runner command and then analyze/test the affected feature.
