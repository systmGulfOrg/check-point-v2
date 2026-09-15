# Technical Specification & Architecture Plan
## نظام إدارة الموارد البشرية والمهام (Leaves & Projects Modules)

### 1. مخطط قاعدة البيانات (Database Schema Design)
تم تصميم قواعد البيانات بأسلوب علائقي متين يدعم التوسع المستقبلي.

#### جدول المستخدمين والصلاحيات (Users & Roles)
* **Users**: `id`, `name`, `email`, `password_hash`, `role_id`, `supervisor_id` (FK to Users), `created_at`
* **Roles**: `id`, `role_name` (Employee, Supervisor, Admin)

#### موديول الإجازات والأذونات (Leaves & Permissions)
* **Leave_Types**: `id`, `name` (سنوي, عارضة...), `requires_medical_proof` (boolean), `max_consecutive_days`, `deducts_from_balance` (boolean).
* **Leave_Balances**: `id`, `user_id` (FK), `leave_type_id` (FK), `year`, `total_allocated`, `used_balance`, `remaining_balance`, `carried_over`.
* **Leave_Requests**: `id`, `user_id` (FK), `leave_type_id` (FK), `start_date`, `end_date`, `total_days`, `status` (Pending, Supervisor_Approved, Final_Approved, Rejected, Cancelled), `reason`, `attachment_url`, `created_at`.
* **Short_Leaves (Permissions)**: `id`, `user_id` (FK), `date`, `start_time`, `end_time`, `total_hours`, `status`, `reason`.
* **Holidays (الأعياد الرسمية)**: `id`, `name`, `date`, `is_recurring`.

#### موديول إدارة المشاريع والمهام (Projects & Tasks)
* **Projects**: `id`, `name`, `description`, `start_date`, `end_date`, `status`, `created_by`.
* **Project_Members**: `project_id`, `user_id`, `role_in_project` (Manager, Member).
* **Tasks**: `id`, `project_id` (FK), `title`, `description`, `priority` (Low, Medium, High, Urgent), `status` (Backlog, To-Do, In-Progress, In-Review, Done), `due_date`, `assignee_id` (FK), `reviewer_id` (FK), `created_by` (FK), `attachment_url`, `created_at`.
* **Task_Activity_Log**: `id`, `task_id` (FK), `user_id` (FK), `old_status`, `new_status`, `comment`, `timestamp`.

---

### 2. خريطة مسارات الـ API (API Endpoints Map)
مبنية على أساسيات RESTful مع الالتزام بـ Clean Architecture.

#### Leaves & Permissions Endpoints
* `GET /api/v1/leaves/types` - (All Roles) - جلب أنواع الإجازات.
* `GET /api/v1/leaves/balances` - (Employee, Supervisor, Admin) - جلب الرصيد.
* `POST /api/v1/leaves/request` - (Employee, Supervisor) - تقديم طلب إجازة.
* `GET /api/v1/leaves/requests` - (All Roles) - جلب طلبات الموظف (للمشرف: طلبات فريقه).
* `PATCH /api/v1/leaves/:id/status` - (Supervisor, Admin) - تحديث حالة الطلب (موافقة/رفض).
* `POST /api/v1/permissions/request` - (Employee) - طلب استئذان (ساعات).
* `POST /api/v1/holidays` - (Admin) - إضافة عطلة رسمية.

#### Projects & Tasks Endpoints
* `POST /api/v1/projects` - (Admin, Supervisor) - إنشاء مشروع جديد.
* `GET /api/v1/projects` - (All Roles) - جلب المشاريع (حسب الصلاحية).
* `POST /api/v1/tasks` - (Supervisor, Admin) - إنشاء مهمة داخل مشروع وإسنادها.
* `GET /api/v1/tasks` - (All Roles) - جلب المهام المسندة للموظف أو فريقه.
* `PATCH /api/v1/tasks/:id/status` - (Employee) - تحديث الحالة فقط.
* `PATCH /api/v1/tasks/:id` - (Supervisor, Admin) - تعديل المهمة بشكل كامل.
* `GET /api/v1/tasks/:id/logs` - (All Roles) - جلب سجل نشاطات المهمة.

---

### 3. هيكلية تطبيق Flutter (App State & Architecture)
استخدام بنية تعتمد على فصل الطبقات مدعومة بمهارات Checkpoint (Bloc/Cubit, GetIt, Freezed, Retrofit).

#### Layering Structure (Clean Architecture Concept)
* **Data Layer (`data/`)**: 
  * `models/`: DTOs مثل `LeaveRequestModel`, `TaskModel`.
  * `apis/`: Retrofit Services للاتصال بالمسارات المذكورة بالأعلى.
  * `repos/`: `LeaveRepoImpl`, `TaskRepoImpl` لإرجاع `ApiResult<T>`.
* **Domain Layer (`domain/` - للمنطق المعقد)**:
  * `repos/`: العقود (Interfaces).
  * `use_cases/`: مثل `CalculateLeaveDaysUseCase` (لاستبعاد العطل)، `SubmitLeaveUseCase`.
* **Presentation Layer (`presentation/`)**:
  * `cubit/`: `LeavesCubit` (للأرصدة والطلبات), `TasksCubit` (لسحب مهام المشاريع وتغيير حالتها).
  * `screens/`: واجهات منفصلة مثل `RequestLeaveScreen`, `TaskBoardScreen`.
  * `widgets/`: مكونات مشتركة كالبطاقات (Task Card, Leave Status Chip).

#### UI/UX Flows
* **Employee Flow**: لوحة تحكم تظهر الرصيد المتبقي -> زر طلب إجازة/استئذان -> قائمة المهام بتصميم Kanban أو List قابلة للسحب لتغيير الحالة (Drag to update status).
* **Supervisor Flow**: واجهة إشعارات لطلبات المرؤوسين (اعتماد/رفض) -> شاشة عرض حالة المشروع -> إنشاء مهام جديدة.

---

### 4. جدول خطة التنفيذ (Phased Implementation Roadmap)

#### Phase 1: Database Setup & Core Leaves Module
* **Backend**: بناء هيكل الـ Database، نظام الـ Auth والـ RBAC (الصلاحيات)، وإعداد مسارات أرصدة الإجازات.
* **Mobile**: بناء واجهة الإعدادات الأولية (Auth)، وشاشة عرض الأرصدة وسجل الإجازات الخاص بالموظف.
* **المخرجات**: الموظف يستطيع رؤية رصيده بناءً على الـ Backend.

#### Phase 2: Leave Approvals, Short Leaves & Holidays Logic
* **Backend**: بناء منطق استبعاد العطلات عند تقديم إجازة (استدعاء جدول الـ Holidays)، وإعداد مسارات تحديث الحالة.
* **Mobile**: بناء واجهات تقديم طلب إجازة/استئذان، وواجهة المشرف لاعتماد الطلبات.
* **المخرجات**: دورة حياة كاملة للإجازات تعمل من التقديم حتى الاعتماد/الرفض مع احتساب دقيق للأيام.

#### Phase 3: Projects & Tasks Core
* **Backend**: بناء جداول المشاريع والمهام (CRUD)، وسجل الأنشطة (Activity Logs).
* **Mobile**: بناء شاشة المشاريع، وتصميم واجهة المهام وتفاصيل المهمة.
* **المخرجات**: المشرف يستطيع إنشاء المهام وإسنادها للموظفين.

#### Phase 4: Tasks Interaction & Final Integration
* **Backend**: مسارات تعديل المهام وتحديث الحالات وإرسال الإشعارات.
* **Mobile**: تطبيق تغيير حالة المهمة (In-Progress, Done) بواسطة الموظف المستند، مع عكس التحديثات فورياً وعرض الـ Activity Log.
* **المخرجات**: نظام مهام حيوي متكامل مع الإجازات (مثلاً تنبيه عند إسناد مهمة لموظف مجاز).
