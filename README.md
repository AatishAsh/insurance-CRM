# Customer Detail Management (Offline-First CRM)

[![Flutter](https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Database](https://img.shields.io/badge/Database-Isar%20NoSQL-4479A1)](https://isar.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows%20%7C%20Linux-4CAF50)](#platform-support)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#)

An enterprise-grade, offline-first Customer Relationship and Task Management system developed for insurance and financial operations. Built using Flutter, the application compiles to native Android (`.apk`) and Windows (`.exe`) from a unified codebase, eliminating cloud dependencies while supporting decentralized peer-to-peer Wi-Fi synchronization.

---

## Table of Contents
1. [Core Features](#core-features)
2. [Architectural Overview](#architectural-overview)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Prerequisites & Development Setup](#prerequisites--development-setup)
6. [Data Models & Schema](#data-models--schema)
7. [Storage & Attachment Architecture](#storage--attachment-architecture)
8. [Decentralized P2P Wi-Fi Sync](#decentralized-p2p-wi-fi-sync)
9. [Build & Release Commands](#build--release-commands)
10. [Testing & Quality Assurance](#testing--quality-assurance)

---

## Core Features

- **Offline-First Data Management**: Complete functionality without an active internet connection. All customer records, policies, and tasks are stored locally.
- **Customer Profiles & Policy Tracking**: Deep customer portfolios spanning Personal, Family, Professional, and Insurance Policy details across multiple companies.
- **Smart Attachment Management**: Upload, preview, and organize identification and policy documents (PDFs, images) with persistent relative file referencing.
- **Work & Task Workflow**: Daily task planning, status cycle tracking (Open, In-Progress, Pending, Completed), and daily notes.
- **Marketing & Performance Pipelines**: Lead generation tracker with stage flows, performance metrics, and activity logging.
- **Export & PDF Generation**: Generates official Customer Profiles and Daily Event Summary PDF reports with printing and sharing support.
- **App-Level Offline Security**: Device-level PIN/password lock screen with biometric/hashed authentication backed by encrypted secure storage.
- **P2P Wi-Fi Synchronization**: Zero-cloud device discovery (mDNS) and HTTP-based binary sync between mobile and desktop devices on the same local network.

---

## Architectural Overview

The application follows an offline-first layered architecture powered by **Riverpod** for reactive state handling and **Isar** for embedded NoSQL storage:

```
┌────────────────────────────────────────────────────────┐
│                    Presentation Layer                  │
│   (Screens, Adaptive Layouts, Formats, Brand Theme)    │
└───────────────────────────▲────────────────────────────┘
                            │ Watches / Triggers
┌───────────────────────────┴────────────────────────────┐
│                    State & Providers                   │
│   (CustomerProvider, WorkProvider, AuthProvider, etc.) │
└───────────────────────────▲────────────────────────────┘
                            │ Calls Services
┌───────────────────────────┴────────────────────────────┐
│                      Service Layer                     │
│  - DatabaseService (Isar CRUD, Transactions, Queries)  │
│  - AppStorageService (Cross-platform file resolution)  │
│  - SyncService (mDNS Bonsoir + Shelf HTTP Server)      │
│  - SecurityService (FlutterSecureStorage + SHA-256)    │
│  - DashboardExportService / BackupService              │
└────────────────────────────────────────────────────────┘
```

---

## Technology Stack

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.x / Dart 3.x | Cross-platform UI framework |
| **State Management** | `flutter_riverpod` (^2.5.1) | Reactive, decoupled state management |
| **Local Database** | `isar` & `isar_flutter_libs` (^3.1.0+1) | Ultra-fast embedded NoSQL database |
| **Local Storage** | `path_provider` (^2.1.2) | System path resolution (Documents / External) |
| **Security** | `flutter_secure_storage` (^9.0.0) & `crypto` | Encrypted key-value store & SHA-256 hashing |
| **P2P Networking** | `bonsoir` (^5.0.0) & `shelf` / `shelf_router` | Local mDNS discovery and embedded sync server |
| **Document/PDF** | `pdf` (^3.10.8) & `printing` (^5.13.1) | Programmatic PDF document compilation |
| **File I/O** | `file_picker` & `image_picker` | User file/image selection from host platform |

---

## Project Structure

```text
customer_detail_management/
├── android/                   # Native Android host project & Gradle configuration
├── windows/                   # Native Windows C++ desktop host runner
├── linux/                     # Native Linux desktop host runner
├── assets/
│   └── images/                # Brand logos and iconography
├── lib/
│   ├── main.dart              # App bootstrap, Riverpod ProviderScope, theme init
│   ├── models/                # Isar schemas and data entities (*.dart & *.g.dart)
│   │   ├── company.dart
│   │   ├── customer.dart
│   │   ├── daily_note.dart
│   │   ├── insurance_company.dart
│   │   ├── marketing_lead.dart
│   │   ├── performance_record.dart
│   │   └── work_task.dart
│   ├── providers/             # Riverpod StateNotifiers and dependency injection
│   │   ├── auth_provider.dart
│   │   ├── customer_provider.dart
│   │   ├── daily_notes_provider.dart
│   │   ├── events_provider.dart
│   │   ├── marketing_provider.dart
│   │   ├── performance_provider.dart
│   │   ├── settings_provider.dart
│   │   └── work_provider.dart
│   ├── screens/               # Screen widgets with adaptive Desktop/Mobile design
│   │   ├── auth_gate.dart
│   │   ├── customer_detail_screen.dart
│   │   ├── customer_form_screen.dart
│   │   ├── customer_list_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── marketing_screen.dart
│   │   ├── performance_screen.dart
│   │   ├── security_lock_screen.dart
│   │   ├── sync_screen.dart
│   │   ├── upcoming_events_screen.dart
│   │   └── work_management_screen.dart
│   ├── services/              # Pure business logic, persistence, and hardware APIs
│   │   ├── app_storage_service.dart
│   │   ├── backup_service.dart
│   │   ├── dashboard_export_service.dart
│   │   ├── database_service.dart
│   │   ├── security_service.dart
│   │   └── sync_service.dart
│   ├── theme/                 # Design tokens, color palettes, and ThemeData
│   └── widgets/               # Reusable UI components, formatters, and dialogs
├── test/                      # Unit and widget test suites
├── pubspec.yaml               # Package manifests and asset declarations
└── analysis_options.yaml      # Static analysis and linter rules
```

---

## Prerequisites & Development Setup

### 1. Environment Requirements
- **Flutter SDK**: `^3.47.0` (or stable >=3.0.0)
- **Dart SDK**: `^3.13.0`
- **JDK**: OpenJDK 17 or 21
- **Android SDK**: API level 34+ with platform-tools and build-tools installed
- **Windows Desktop (Optional)**: Visual Studio 2022 with "Desktop development with C++" workload

### 2. Initial Setup
Clone the repository and install all Dart/Flutter dependencies:

```bash
git clone <repository-url>
cd customer_detail_management
flutter pub get
```

### 3. Code Generation (Isar Schemas)
When modifying any Isar model in `lib/models/`, run `build_runner` to regenerate the corresponding `.g.dart` schema files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

To continuously watch for model changes during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## Data Models & Schema

All core entities implement:
- **`Id id = Isar.autoIncrement`**: Local unique ID.
- **`uuid` (String)**: Globally unique identifier for conflict-free cross-device syncing.
- **`updatedAt` (DateTime)**: Timestamp used for **Last-Write-Wins (LWW)** synchronization.
- **`isDeleted` (bool)**: Soft-deletion flag to propagate deletions accurately across peer nodes.

### Schema Catalog
- **`Customer`**: Holds personal info, contact info, family relations, policy records, and list of attached documents (`CustomerDocument`).
- **`Company` / `InsuranceCompany`**: Pre-seeded and user-configured insurance providers (e.g., LIC, Star Health, HDFC Ergo).
- **`WorkTask`**: Workflow tasks with status cycles, assigned policies, and due dates.
- **`MarketingLead`**: Prospects with interaction histories, converted status, and follow-ups.
- **`PerformanceRecord`**: Business metric entries (new policies, premium volume, incentives).
- **`DailyNote`**: Scratchpad entries indexed by date.

---

## Storage & Attachment Architecture

Customer attachment files (Aadhaar cards, policy PDFs, client photographs) are decoupled from absolute device paths to ensure seamless cross-platform backup and restore.

### Directory Resolution ([`AppStorageService`](lib/services/app_storage_service.dart))

| Host OS | Resolved Base Directory | Final Attachment Folder |
| :--- | :--- | :--- |
| **Windows Desktop** | `C:\Users\<Username>\Documents` | `C:\Users\<Username>\Documents\customer_documents\` |
| **Android APK** | External App Storage (`/storage/emulated/0/Android/data/.../files`) | `.../files/customer_documents/` |
| **Linux Desktop** | `~/.local/share/customer_detail_management` | `~/.local/share/customer_detail_management/customer_documents/` |

### Storage Behavior
- **Relative Linking**: Models only store the generated file name (`<timestamp>_<originalName>`).
- **Binary Fallback**: If standard filesystem link/copy operations fail across volume boundaries, `AppStorageService` falls back to streamed byte chunk copy (`readAsBytes` / `writeAsBytes`).

---

## Decentralized P2P Wi-Fi Sync

The sync engine operates completely offline without intermediary cloud servers:

1. **Discovery (mDNS)**:
   - Uses `bonsoir` to broadcast and discover a dedicated service identifier (`_shinecraft-sync._tcp`) over the local Wi-Fi subnet.
2. **Embedded HTTP Server (`shelf`)**:
   - The serving node hosts a lightweight server on port `8080` (or next available).
3. **Synchronization Protocol**:
   - `GET /sync/data`: Serializes database entities modified since the last sync watermark.
   - `POST /sync/push`: Submits local changes to the peer.
   - `GET /sync/file/:name`: Streams physical attachment files between devices to mirror local document stores.
4. **Conflict Resolution**:
   - Evaluates `updatedAt` timestamps. If the incoming record has a newer timestamp than the local record, the local record is overwritten (Last-Write-Wins).

---

## Build & Release Commands

### Android Release APK
To compile an optimized, standalone release APK:

```bash
flutter build apk --release
```
- **Output Artifact**: `build/app/outputs/flutter-apk/app-release.apk`
- **Minimum SDK**: Configured via Flutter defaults (minSdkVersion 21)
- **Target SDK**: Android API 34+

To build split per-ABI APKs (smaller individual download sizes):
```bash
flutter build apk --release --split-per-abi
```

### Windows Desktop Release
To compile the standalone Windows 64-bit desktop application:

```bash
flutter build windows --release
```
- **Output Directory**: `build/windows/x64/runner/Release/`
- **Executable**: `customer_detail_management.exe` (distribute with bundled DLLs and `data/` folder).

### Linux Desktop Release
```bash
flutter build linux --release
```

---

## Testing & Quality Assurance

### Static Analysis
Ensure code style, deprecations, and null-safety adhere to project guidelines:
```bash
flutter analyze
```

### Automated Tests
Run unit tests and widget tests:
```bash
flutter test
```

### Recommended Developer Workflows
- **Running in Debug Mode**:
  ```bash
  flutter run -d windows    # Run Windows desktop target
  flutter run -d <device-id> # Run on connected Android phone/emulator
  ```
- **Cleaning Build Cache**:
  ```bash
  flutter clean
  flutter pub get
  ```
