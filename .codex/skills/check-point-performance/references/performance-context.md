# Performance context

- The app has admin, supervisor, and employee dynamic lists, filters, dashboards, maps, location verification, skeleton loading, and pagination-sensitive flows.
- Use `ListView.builder`/`GridView.builder` for dynamic lists and keep filtering/sorting out of `build`.
- Keep Bloc builders/selectors local to the subtree that consumes the state.
- Reuse existing cached/network and skeleton patterns where present; inspect the feature before changing behavior.
- Controllers, focus nodes, animation controllers, and subscriptions must be created outside `build` and disposed.
