# Animation context

- Route transitions are centralized in `lib/core/routes/app_router.dart`: fade routes use roughly 300ms forward/220ms reverse; slide routes use roughly 320ms forward/250ms reverse with eased fade/slide.
- `lib/core/widgets/animated_list_item_widget.dart` is the shared staggered fade-and-slide entrance for list items, with capped per-index delay and an ease-out curve.
- Existing motion includes `AnimatedSwitcher` for screen/state changes, `AnimatedContainer` for selected controls and map/status surfaces, `TweenAnimationBuilder` for small emphasis effects, and controller-driven skeleton shimmer.
- Existing animated widgets are used across admin, employee, supervisor, auth role selection, bottom navigation, dashboards, lists, maps, and skeleton loaders. Inspect the nearest implementation before adding another pattern.
- Keep animation values consistent with nearby components, avoid excessive simultaneous motion, and make sure animation does not introduce layout overflow or rebuild large unrelated subtrees.
