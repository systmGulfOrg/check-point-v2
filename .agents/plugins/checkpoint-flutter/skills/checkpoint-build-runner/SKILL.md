---
name: checkpoint-build-runner
description: >-
  Use this skill whenever you have modified or created Freezed, json_serializable, or Retrofit files to run the code generator.
---

# Run Build Runner

Whenever you modify any file containing `@freezed`, `@JsonSerializable()`, or `@RestApi()` annotations, you MUST run this command to generate the `.freezed.dart` and `.g.dart` files.

## Command

Run this command in the terminal at the root of the project:

```bash
dart run build_runner build --delete-conflicting-outputs
```
