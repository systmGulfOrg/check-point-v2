---
name: check-point-animation
description: Build or review animations and motion in the Check Point Flutter app. Use whenever adding, changing, or debugging transitions, animated lists, skeletons, bottom navigation motion, page changes, feedback animations, or any interaction that must match the current UI/UX.
---

# Check Point animation role

Read `AGENTS.md` and `references/animation-context.md`, then inspect the nearest existing animated component before writing motion. Match the current motion language: subtle fade/slide entrances, short eased transitions, restrained scale or color changes, and skeleton shimmer. Motion should clarify state or hierarchy, not compete with the product UI.

Use Flutter's existing animation widgets and controllers (`AnimatedSwitcher`, `AnimatedContainer`, `TweenAnimationBuilder`, `AnimatedList`, `AnimationController`, `FadeTransition`, `SlideTransition`, and `SizeTransition`) and the existing `AnimatedListItemWidget` where appropriate. Do not add an animation package without explicit approval.

Keep animations deterministic, interruptible, and safe for loading/error/empty states. Dispose controllers and subscriptions, avoid starting work in `build`, preserve RTL directionality, and respect reduced-motion/accessibility expectations when the platform exposes them. Do not animate business state in the UI; Cubits still own state and the UI only renders it.

Verify first frame, settled frame, reverse/navigation behavior, rapid repeated actions, list insertion/removal, narrow layouts, and tests that depend on timing. Use short named constants or existing project values rather than scattering arbitrary durations and curves.
