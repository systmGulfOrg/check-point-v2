---
name: check-point-ui
description: Build or review Check Point Flutter UI so every new or changed component matches the existing Check Point UI/UX. Use for screens, widgets, forms, BlocBuilder/Listener layout, localization, RTL, responsive sizing, theme, assets, and Navigator 1.0 routing in this repository.
---

# Check Point UI role

Read `AGENTS.md` and `references/ui-context.md` before acting. Treat the current app UI as the design source of truth. Before creating any new component, inspect the closest existing screen/widget and reproduce its visual and interaction patterns.

Use existing core widgets, styles, colors, assets, routes, and translations before adding anything. Match the current spacing rhythm, card radius, borders, shadows, typography hierarchy, orange brand colors/gradient, light/dark surfaces, loading skeletons, empty/error states, dialogs, buttons, fields, badges, and interaction states. Use `CustomTextFormField`, `.tr()`, directional layout APIs, `flutter_screenutil_plus`, and centralized theme tokens. Keep Bloc builders/listeners/selectors in named widget files and on the smallest subtree. Do not put submission, validation, branching, repository calls, or API calls in screens. Preserve current visual language and RTL behavior on Arabic and English layouts.

Every new component must pass this parity checklist before delivery:

1. Reuse the nearest existing component or core token; do not invent a parallel design.
2. Use the same padding, radius, border, shadow, icon sizing, text styles, colors, and interaction treatment unless there is a documented reason to extend the design system.
3. Check Arabic and English, RTL/LTR, long labels, narrow phones, large screens, keyboard/insets, and overflow.
4. Implement loading, empty, error, disabled, focused, pressed, and success states when the component can reach them.
5. Read `check-point-animation` for any animated behavior and match the nearest existing motion.
6. If the existing UI cannot express the component, extend a central style/core widget or add a named reusable widget in the established location; do not hide one-off styling inside a screen.

Before considering a UI task complete, check narrow phones, large screens, keyboard/insets, long Arabic labels, empty/loading/error states, disabled/pressed/focused states, and overflow. Reuse or extend a core token/widget when the same pattern appears twice; do not inline a new color, text style, asset, spacing system, or decoration.

Verify changed UI with focused tests, analysis, and a widget test when the screen-to-Cubit behavior changes.
