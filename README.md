# Flutter Todoist Time Tracking App


This project is a **Time Tracking Kanban Board App** built with Flutter for a take-home challenge.

It focuses on:

- ✅ Clean Architecture implementation
- ✅ SOLID principles and Test-Driven Development (TDD)
- ✅ Emphasis on core Software Engineering best practices

## 🧪 Take-Home Challenge Expectations

The goal of this take-home challenge is to build a **Task Time Tracking Application** using Flutter, centered around a Kanban board layout and integrating with the [Todoist REST API v2](https://developer.todoist.com/rest/v2/#overview).

If the functionality that you want to implement is not provided by the API services, use local solutions as needed.



---

### ✅ Core Features

1. **Kanban Board**
    - Display tasks in three columns: `To Do`, `In Progress`, and `Done`.
    - Users able to:
        - Create new tasks
        - Move tasks between columns to reflect progress
          <img src="screenshots/board.png" alt="Kanban Board" height="400"/>
          <img src="screenshots/create_task.png" alt="Create Task" height="400"/>

2. **Task Timer**
    - Each task has a timer feature to track time spent.
    - Users should be able to start and stop the timer.

4. **Task Comments**
    - Allow users to add comments to individual tasks
    - Display existing comments for each task

<img src="screenshots/task_detail.png" alt="Task Detail" height="400"/>

3. **Completed Task History**
    - Provide a history view of all completed tasks.
    - Each completed task shows:
        - Time spent
        - Completion date
          <img src="screenshots/task_history.png" alt="Task Detail" height="400"/>


5. **Caching Mechanism** *(Bonus)*
    - Implemented a caching layer to persist and retrieve task data efficiently
    - Enhances performance and provides offline-read support
---

# 🚀 Feature Explanation

### 🧱 1. Kanban Board

A visually intuitive Kanban board with three primary columns: `To Do`, `In Progress`, and `Done`.

- Tasks are fetched from the Todoist API and will be saved locally in the database for working in offline mode.
- Users can **create** tasks with the Todoist API .
- Task status are handled by `label` field in the task API.

**📂 Related Files:**
- `tasks_controller.dart` – Holds the UI state and handles events from the UI
- `get_tasks_use_case.dart` – Fetchs tasks and listens to update the UI for the new task.
- `update_task_status_use_case.dart` – Applys new status for the task in a remote and local way.

---

### ⏱️ 2. Task Timer

Each task supports a timer to help users track how long they work on it.

- Users can **start** and **stop** a timer for the tasks with the `toDo` or `inProgress` status.

**📂 Related Files:**
- `time_tracking_use_case.dart` – Handles time tracking status for the task and interacts with the repository to update the tracking time.
- `time_tracking` –  an entity that represents the tracked time for a task

---

### 📆 3. Completed Task History

Provides a dedicated view to review all completed tasks.

- Completed tasks are displayed in a list with:
    - Task title
    - Time spent
    - Completion date
- When a task compelted the `close` task Todoist API will be called and the completed tasks will be added to the database.
- There is just an API for the active tasks in Todist API, so the completed tasks will be retreive through the app dabase.

**📂 Related Files:**
- `completed_task_repository.dart` - saves and retrieves the completed tasks and returns the new completed task for updating the UI.
---

### 💬 4. Task Comments

Allows collaboration and tracking task-related notes.

- Users can **add comments** to any task.
- Comments are displayed in the task detail section.
  **📂 Related Files:**


---

### 💾 5. Caching Mechanism (Bonus)

To improve performance and reliability, a caching mechanism was implemented:

- ✅ Uses local storage (e.g., `SharedPreferences` or `Hive`) for:
    - Timer sessions
    - Comments
    - Task state when API is unavailable
- ✅ Optimized for offline access and faster load times.
- ✅ Automatically syncs back to Todoist when connectivity is restored.

---

### 🧰 6. Engineering Practices

The project is built with strong software engineering principles:

- ✅ **Clean Architecture**: Separation of concerns between UI, business logic, and data.
- ✅ **SOLID Principles**: Ensures the app is scalable and maintainable.
- ✅ **TDD**: Unit tests written before implementation to catch bugs early.
- ✅ **CI/CD Ready**: Structure is optimized for automated testing and deployment pipelines.
- ✅ **Performance Focus**: Lazy loading, efficient list rendering, and memory-safe architecture.

---


## 🔐 Before running the project: API Authentication Setup

To connect with the [Todoist REST API v2](https://developer.todoist.com/rest/v2/#overview), you'll need to set up an authentication token.

1. Visit your [Todoist Developer Dashboard](https://app.todoist.com/app/settings/integrations/developer).
2. Generate or copy your **Personal API Token**.
3. At the root of this project, create a file named `.env`.
4. Add the following line to your `.env` file:

```env
AUTH_TOKEN=02343536456464567457
```
---

### 📝 Notes

- Focus on **clean code**, **best practices**, and **user-centered design**.
- Use **SOLID principles**, **MVP**, and optionally **Clean Architecture**.
- Performance and maintainability are key.
- Bonus for writing **unit tests** and using **TDD** principles.

---

Good luck, and have fun building! 🚀

---

## ✨ Features

### ✅ Functional Requirements

1. **Kanban Board**
    - Create, edit, delete, and move tasks between columns (`To Do`, `In Progress`, `Done`).

2. **Task Timer**
    - Start/stop time tracking on tasks.
    - View total tracked time.

3. **Completed Task History**
    - View completed tasks, time spent, and completion date.

4. **Comments**
    - Add and view comments on each task.

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter (latest stable version)
- Dart SDK
- An IDE (Android Studio or VS Code)
- Internet access (for Todoist API)

### 🔧 Setup

1. **Clone the repo**:
   ```bash
   git clone https://github.com/farzaamam/flutter_todoist.git
   cd flutter_todoist