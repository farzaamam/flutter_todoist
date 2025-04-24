# Flutter Todoist Time Tracking App

This project is a **Time Tracking Kanban Board App** built with Flutter as part of a take-home challenge.

It focuses on:

- ✅ Clean Architecture implementation
- ✅ SOLID principles and Test-Driven Development (TDD)
- ✅ Emphasis on core software engineering best practices

---

## 🧪 Take-Home Challenge Expectations

The goal of this challenge is to build a **Task Time Tracking Application** using Flutter, centered around a Kanban board layout and integrated with the [Todoist REST API v2](https://developer.todoist.com/rest/v2/#overview).

If a desired functionality is not provided by the API, local solutions may be used.

---

## ✅ Core Features

1. **Kanban Board**
    - Displays tasks in three columns: `To Do`, `In Progress`, and `Done`.
    - Users can:
        - Create new tasks
        - Move tasks between columns to reflect progress

    <img src="screenshots/board.png" alt="Kanban Board" height="400"/>
    <img src="screenshots/create_task.png" alt="Create Task" height="400"/>

2. **Task Timer**
    - Each task includes a timer to track time spent.
    - Users can start and stop the timer.

3. **Task Comments**
    - Users can add comments to individual tasks.
    - Comments are displayed for each task.

    <img src="screenshots/task_detail.png" alt="Task Detail" height="400"/>

4. **Completed Task History**
    - Displays a history view of completed tasks.
    - Each completed task shows:
        - Time spent
        - Completion date

    <img src="screenshots/task_history.png" alt="Task History" height="400"/>

5. **Caching Mechanism** *(Bonus)*
    - Caches task data to improve performance and support offline reading.

---

## 🚀 Feature Explanation

### 🧱 1. Kanban Board

A visually intuitive Kanban board with three primary columns: `To Do`, `In Progress`, and `Done`.

- Tasks are fetched from the Todoist API and stored locally for offline usage.
- Users can **create** tasks via the Todoist API.
- Task statuses are managed using the `label` field from the Todoist API.

**📂 Related Files:**
- `tasks_controller.dart` – Manages UI state and handles events
- `get_tasks_use_case.dart` – Fetches and updates tasks
- `update_task_status_use_case.dart` – Applies status updates remotely and locally

---

### ⏱️ 2. Task Timer

Each task supports a timer to help users track how long they’ve worked on it.

- Users can **start** and **stop** the timer for tasks in `To Do` or `In Progress` states.

**📂 Related Files:**
- `time_tracking_use_case.dart` – Manages time tracking logic
- `time_tracking.dart` – Entity representing tracked time

---

### 📆 3. Completed Task History

Dedicated view to review all completed tasks.

- Displays:
    - Task title
    - Time spent
    - Completion date
- Upon completion, the `close task` API from Todoist is called.
- Since the API only provides active tasks, completed tasks are stored and retrieved from the local database.

**📂 Related Files:**
- `completed_task_repository.dart` – Saves/retrieves completed tasks and updates the UI
- `task_repository.dart` – Updates task status and marks tasks as completed

---

### 💬 4. Task Comments

Supports collaboration through task-based comments.

- Users can **add** and **view** comments for tasks.

**📂 Related Files:**
- `comment_repository.dart` – Creates and fetches comments

---

### 💾 5. Caching Mechanism (Bonus)

Enhances performance and ensures data availability offline.

- Uses `drift` and `flutter_drift` for local database implementation.

**📂 Related Files:**
- `database.dart` – Sets up and manages the local database
- `task_repository_impl.dart` – Implements offline logic and caching

---

### 🧰 6. Engineering Practices

Built with robust engineering principles:

- ✅ **Clean Architecture** – Separates UI, domain, and data layers
- ✅ **SOLID Principles** – Ensures maintainability and scalability
- ✅ **TDD** – Core mechanisms tested via unit tests

---

## 🛠️ Setup & Running the Project

### 🔧 1. Clone the Repository & Running the project

```bash
git clone https://github.com/farzaamam/flutter_todoist.git
cd flutter_todoist
```
### 🔧 2. API Authentication Setup
To integrate with the [Todoist REST API v2](https://developer.todoist.com/rest/v2/#overview), follow these steps:

1. Go to your [Todoist Developer Dashboard](https://app.todoist.com/app/settings/integrations/developer).
2. Generate or copy your **Personal API Token**.
3. Create a `.env` file at the root of the project.
4. Add the following line to your `.env` file:
```env
AUTH_TOKEN=0213243455
```
### 🔧 3. Running the project

```bash
flutter pub get 
flutter run
```

### 🔧 4. Running the unit tests

```bash
flutter test 
```

### 🔧 5. Working output in Android

```bash
flutter build apk --debug
```
Get the output from this path: ``build/app/outputs/flutter-apk/app-debug.apk``
