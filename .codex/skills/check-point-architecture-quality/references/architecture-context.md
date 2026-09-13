# Architecture context

- Layers are presentation → optional domain → data. No domain entities or entity mappings.
- Simple flows use UI → Cubit → repository; use cases are for orchestration, business rules, transformation, or reuse.
- API results use the project's `ApiResult<T>` union and failures are mapped through the core network failure machinery.
- Retrofit services are feature data APIs; generated `.g.dart`, `.freezed.dart`, and `.env` generated files are not hand-edited.
- GetIt registrations are centralized in `service_locator.dart`: external clients, data services, repositories, use cases, then factory Cubits.
- Existing repository placement may be legacy; extend it consistently unless migration is explicit.
