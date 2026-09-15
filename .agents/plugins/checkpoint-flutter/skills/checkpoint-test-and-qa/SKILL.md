---
name: checkpoint-test-and-qa
description: >-
  Use this skill when the user asks to test, QA, or review code changes in the Checkpoint HRM project.
---

# Checkpoint Test & QA

This skill guides the agent in rigorously testing both the backend (Fastify/Prisma) and mobile (Flutter) applications.

## Steps for Backend QA

1. **Typechecking**: Always run `npm run typecheck` in the `apps/api` directory to catch any TypeScript issues.
2. **Linting**: Run `npm run lint` if configured.
3. **Unit Testing**: Run `npm run test` (Vitest) in the `apps/api` directory to run existing tests.
4. **Schema Review**: Ensure Prisma schema is properly generated (`npx prisma generate`). Note: On older Node versions, this might fail formatting, so check for compilation errors directly.

## Steps for Mobile QA (Flutter)

1. **Static Analysis**: Run `flutter analyze` in the project root to detect syntax errors, missing imports, or unused variables.
2. **Code Generation Checks**: Ensure all `@freezed`, `@RestApi`, and `@JsonSerializable` files are correctly generated without warnings. If `toJson` is missing, ensure the `_$ModelToJson` method is accessible or `toJson` is explicitly defined.
3. **Dependency Check**: Run `flutter pub get` and `flutter packages upgrade` to resolve conflicting analyzer or SDK versions.
4. **Widget Testing**: Run `flutter test` for any existing tests.

## Bug Fixing Rules
- Always fix compiler errors (TypeScript/Dart) before assuming a feature is complete.
- Do not suppress errors blindly; find the root cause (e.g. missing import, wrong type mapping).
