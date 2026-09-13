---
name: check-point-performance
description: Diagnose or improve Check Point Flutter performance. Use for unnecessary rebuilds, Bloc scope, large lists, pagination, filtering, network images, controllers, map/location work, caching, and expensive build methods.
---

# Check Point performance role

Read `AGENTS.md` and `references/performance-context.md`. Measure or inspect the actual hot path first. Keep expensive work out of `build`, use the smallest Bloc subtree, use builders for dynamic collections, guard pagination, and dispose every controller/subscription. Prefer the existing packages and services; do not add overlapping dependencies.

Make the smallest change that improves the identified path and verify behavior with focused tests plus analysis. Do not trade correctness, loading/error states, localization, or security for an unmeasured optimization.
