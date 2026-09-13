---
name: check-point-coordinator
description: Coordinate Flutter work in the Check Point project. Use this whenever a task touches this repository, its architecture, UI, authentication, security, performance, testing, or generated code; route mixed tasks to the focused Check Point skills.
---

# Check Point coordinator

Use the repository's `AGENTS.md` as the highest-priority source of truth. Read it before changing code, then read only the references relevant to the task from `references/`.

## Route by concern

- UI, screens, widgets, localization, RTL, theme, routing, visual parity: `check-point-ui`.
- Animations, transitions, skeletons, animated lists, motion/accessibility: `check-point-animation`.
- Login, roles, sessions, biometrics, device identity: `check-point-auth-login`.
- Tokens, secrets, storage, interceptors, logging, threat review: `check-point-security`.
- Rebuilds, lists, pagination, caching, controllers, expensive work: `check-point-performance`.
- Layers, repositories, use cases, DI, Freezed, Retrofit, naming: `check-point-architecture-quality`.
- Tests, regression coverage, failure shapes, side effects: `check-point-testing`.

Mixed changes may use several specialists, but keep the implementation smallest and preserve unrelated user changes. Inspect the current code before deciding; do not invent a parallel convention when an existing project convention is discoverable.

## Delivery contract

Before editing, inspect `git status --short`. After editing, run focused tests and static analysis appropriate to the change. If Freezed, JSON serialization, or Retrofit sources changed, run `dart run build_runner build --delete-conflicting-outputs`. Report changed files, checks run, and any remaining risk.

## Project references

The focused references in this skill are a compact map of current code. They supplement, never replace, `AGENTS.md`.
