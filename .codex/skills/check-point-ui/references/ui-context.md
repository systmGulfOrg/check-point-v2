# UI context

- Shared UI primitives are under `lib/core/widgets/`; styles, assets, colors, and decorations are centralized under `lib/core/styles/`.
- Forms use `CustomTextFormField`, not Flutter's raw `TextFormField`.
- Auth UI is composed from named widgets under `lib/features/auth/presentation/widgets/`, including login listener and submit widgets.
- `AppRouter` uses Navigator 1.0, centralized route constants, and DI-created Bloc providers.
- The project supports Arabic/English and RTL. User-facing strings must be localization keys.
- Existing screens use responsive dimensions and the current app theme; inspect nearby screens before adding UI.
- Current visual baseline: warm off-white page backgrounds, white cards, orange brand actions/gradient, slate text, pale blue-gray borders, rounded cards and fields, restrained shadows, and compact dashboard tiles. These are observations of the current implementation, not permission to bypass centralized tokens.
- Preserve the app's established component grammar: `AuthShellWidget`/`AuthCardWidget`, `CustomButton`, `CustomTextFormField`, named loading skeletons, `AnimatedListItemWidget`, status badges, bottom navigation, and the existing admin/employee/supervisor card patterns.
- Prefer the same padding, radius, text-style, icon-size, and animation values used by the closest existing component. If a new value is genuinely needed, add it centrally and explain why.
- Component parity is required: the nearest existing screen/widget is the visual reference for spacing, typography, color, radius, borders, shadows, icons, states, and motion. A new component is incomplete until it looks native beside that reference in Arabic RTL and English LTR.
- Extend existing core tokens/widgets when a pattern repeats; do not introduce ad-hoc colors, text styles, assets, spacing, dialogs, or animation values in feature code.
