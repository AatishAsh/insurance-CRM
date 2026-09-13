# JJ CRM — Comprehensive Testing Plan & Verification Architecture

**Project:** Insurance-CRM (JJ CRM - Offline Customer Detail Management System v2.0.1)  
**Target Coverage:** Headless automated verification across UI, Usability/Accessibility, and Local Backend Integration (~660 test cases)  
**Discovery Harness:** Probe-Code Inspection System (`test/probes/`)  

---

## Table of Contents

1. [Purpose and Scope](#1-purpose-and-scope)
2. [Testing Strategy (The 3 Suites)](#2-testing-strategy-the-3-suites)
3. [Probe-Code Design ("Look Inside the UI" Infrastructure)](#3-probe-code-design-look-inside-the-ui-infrastructure)
4. [Feature Inventory → Test Repository Mapping Matrix](#4-feature-inventory--test-repository-mapping-matrix)
5. [Full Test Catalog](#5-full-test-catalog)
   - [5.1 Suite A: UI & Surface Tests (~235 Cases)](#51-suite-a-ui--surface-tests-235-cases)
   - [5.2 Suite B: Usability & UX Journey Tests (~165 Cases)](#52-suite-b-usability--ux-journey-tests-165-cases)
   - [5.3 Suite C: Backend & Integration Tests (~260 Cases)](#53-suite-c-backend--integration-tests-260-cases)
6. [Flakiness Controls & Determinism Rules](#6-flakiness-controls--determinism-rules)
7. [CI/CD Integration Plan](#7-cicd-integration-plan)

---

## 1. Purpose and Scope

### 1.1 Objective
This document serves as the authoritative specification and execution blueprint for all automated testing within **JJ CRM** (Offline Customer Detail Management System). The testing architecture ensures 100% regression protection, deterministic offline verification, and total alignment between backend data models and rendered user interfaces.

### 1.2 Target System Scope
The test suite exercises all layers of the application:

1. **12 Screens / Navigation Surfaces:**
   - `AuthGate` (boot state machine: uninitialized, setup required, locked, unlocked)
   - `SecurityLockScreen` (PIN pad, dot indicators, shake/error animations, confirmation flow)
   - `MainNavigationShell` (desktop collapsible side navigation vs. mobile bottom navigation)
   - `DashboardScreen` (stat cards, quick actions, tomorrow's summary, interactive filter chips, day task notes checklist, repaint boundary snapshot, PDF report generation)
   - `CustomerListScreen` (alphabetical/date sorting, search query filtering, segmented tab switching: All / Profiles / Documents, pagination, batch actions)
   - `CustomerDetailScreen` (full profile visualizer, policy list, family cards, reminder timeline, document gallery, profile PDF exporter, soft-delete modal)
   - `CustomerFormScreen` (multi-section customer entry form, 13 document attachment slots, plan sub-forms, nominee/appointee blocks, family member DOBs, segmented date fields)
   - `UpcomingEventsScreen` (30-day birthday/anniversary window calculations, marketing visit schedule, personal accident anniversaries, direct phone/action intents)
   - `WorkManagementScreen` (up to 15 company tabs across 3 configurable categories, task table, priority badges, automated carry-forward, company rename dialog)
   - `MarketingScreen` (lead directory, multi-visit logging, photo attachment management, status lifecycle badges)
   - `PerformanceScreen` (monthly KPI matrix, Box 1-4 summaries, 14-column topic tracker, universal header cascade, year/month picker)
   - `SyncScreen` (Wi-Fi mDNS discovery status, direct IP connection dialog, PIN management, auto-lock timer configuration, date format preferences, full ZIP backup/restore, sandbox developer tools)

2. **13 Custom Widgets & Formatters:**
   - `KeyCycleDropdown` / `KeyCycleDropdownFormField` / `KeyCycleDropdownButton` (closed/open keyboard letter jumping and cycle mechanics)
   - `SegmentedDateInputField` (day/month/year segmented input, backspace auto-reverse, tab advance)
   - `DateInputFormatter` (strict slash insertion, month/day range validation)
   - `AadhaarNumberFormatter` (4-4-4 space formatting, 12-digit clamp)
   - `BrandBackground` (radial gradient, watermark rendering)
   - `BrandCard` (elevated white cards, custom borders, hover shadows)
   - `BrandSidenav` (desktop rail, active badge highlights, tooltips, footer branding)
   - `ColorBadge` (status pill color mappings)
   - `GradientButton` (custom primary gradient styling, disabled states, loading spinners)
   - `RenameFileDialog` (modal text field validation, collision checks)
   - `ShineCraftBrandingFooter` (branding asset loader, version text, sandbox unlock tap counter)
   - `CurvedOverscrollBehavior` (glowing overscroll indicator in SkyBlue)
   - `PINPad` & `PINDots` (custom digit inputs, masked dots)

3. **7 Isar NoSQL Collections:**
   - `Customer` (with embedded `CustomerDocument`, `CustomerPlanItem`, `CustomerReferenceItem`, `CustomerReminderItem`)
   - `Company` (Work task companies, 15 per tab limit)
   - `InsuranceCompany` (Insurance company assignments, 15 limit, cascade rename across customer policies)
   - `WorkTask` (priority: Urgent/Important/Normal, status: Completed/Pending/Under Process/No Response, carry-forward logic)
   - `MarketingLead` (with embedded `MarketingVisit`, multi-photo attachments)
   - `PerformanceRecord` (with embedded `TopicTableRow`, Box 1-4 metrics, universal header synchronization)
   - `DailyNote` (General / Marketing categories, completion toggle, target date association)

4. **8 Provider Families (Riverpod):**
   - `authStateProvider`, `autoLockTimeoutProvider`, `isPickingFileProvider`
   - `customerListProvider`, `searchQueryProvider`, `customerSearchTabProvider`, `customerPageProvider`, `navigationTabIndexProvider`
   - `upcomingEventsProvider`, `todaySummaryEventsProvider`
   - `taskListProvider`, `todayTasksProvider`, `companiesProvider`, `companiesForTabProvider`, `selectedCompanyIdProvider`, `selectedDateProvider`, `showAllWorkHistoryProvider`, `selectedWorkTabIndexProvider`, `workTabNamesProvider`
   - `marketingListProvider`
   - `performanceRecordProvider`, `selectedPerformanceYearProvider`, `selectedPerformanceMonthProvider`
   - `todayNotesProvider`, `tomorrowNotesProvider`
   - `dateFormatPatternProvider`, `appDateFormatterProvider`

5. **6 Core Services:**
   - `DatabaseService` (Isar schemas, transactions, queries, soft deletes, cascade updates, seeds, sandbox operations)
   - `SecurityService` (SHA-256 PIN hashing, FlutterSecureStorage abstraction, auto-lock timeout management)
   - `BackupService` (ZIP archive packing/unpacking, `backup_data.json` generation, base64 binary document extraction, schema migration)
   - `DashboardExportService` (PDF canvas building, multi-page customer profile generation, repaint boundary image snapshot, cross-platform file saving)
   - `SyncService` (mDNS bonsoir discovery, shelf REST API server, conflict resolution via `updatedAt`, binary image transfer)
   - `AppStorageService` (relative/absolute path resolution, document directory isolation)

### 1.3 Deliberately Out-of-Scope Items
- **Live Network Sockets:** Real UDP broadcast binding and live external HTTP server networking in headless CI are out of scope. `SyncService` is verified at the surface/UI state level, repository sync handler level, and mock HTTP payload level.

---

## 2. Testing Strategy (The 3 Suites)

The testing ecosystem is divided into three focused suites totaling approximately 660 test cases. All suites run headless on standard Flutter test runners without emulators.

```
                  ┌────────────────────────────────────────────────────────┐
                  │                 JJ CRM Test Ecosystem                  │
                  │                 (~660 Total Test Cases)                │
                  └───────────────────────────┬────────────────────────────┘
                                              │
         ┌────────────────────────────────────┼────────────────────────────────────┐
         │                                    │                                    │
         ▼                                    ▼                                    ▼
┌──────────────────┐                 ┌──────────────────┐                 ┌──────────────────┐
│     Suite A      │                 │     Suite B      │                 │     Suite C      │
│   UI & Surface   │                 │  Usability & UX  │                 │ Local Integration│
│   (~235 Cases)   │                 │   (~165 Cases)   │                 │   (~260 Cases)   │
├──────────────────┤                 ├──────────────────┤                 ├──────────────────┤
│• Visual tree     │                 │• User journeys   │                 │• Real Isar in-mem│
│• Exact strings   │                 │• Key navigation  │                 │• Provider sync   │
│• Form validators │                 │• Responsive UI   │                 │• ZIP round-trip  │
│• Modals & snack  │                 │• Auto-lock timer │                 │• PDF byte layout │
│• Empty states    │                 │• Error recovery  │                 │• Cascade renames │
└──────────────────┘                 └──────────────────┘                 └──────────────────┘
```

### 2.1 Suite A — UI & Surface Suite (~235 Cases)
- **Goal:** Verify that every widget, label, icon, text field, table row, dialog, snackbar, and empty state renders correctly with exact strings and expected visual states.
- **Methodology:** Headless widget testing (`tester.pumpWidget`) with mock providers and seeded test data models.
- **Key Assertions:** Text finders, icon presence, enabled/disabled states of buttons, active chip selections, form validator triggers.

### 2.2 Suite B — Usability & User Experience Suite (~165 Cases)
- **Goal:** Prove end-to-end user workflows, accessibility behaviors, keyboard cycle mechanics, responsive layout switches, and session continuity.
- **Methodology:** Simulated user interaction streams (`tester.tap`, `tester.enterText`, `tester.sendKeyEvent`, window resize simulation).
- **Key Assertions:** Focus traversal, auto-advancing segmented dates, letter-cycling in dropdowns, desktop (1200px) vs mobile (400px) responsiveness, app lifecycle pause/resume auto-lock.

### 2.3 Suite C — Local Backend Integration Suite (~260 Cases)
- **Goal:** Verify data integrity, reactivity between Riverpod providers and the Isar database, calculation engines (upcoming events, summary KPIs), cryptographic storage, ZIP backup/restore roundtrips, and PDF document generation.
- **Methodology:** Real Isar database initialized in isolated temporary directories (`Directory.systemTemp.createTempSync()`), clock injection for deterministic date calculations, and mocked platform channels (Mocktail for `file_picker`, `printing`, `share_plus`, `flutter_secure_storage`).
- **Key Assertions:** Database records created/updated/deleted, soft-delete filtering, cascade renames, SHA-256 verification, ZIP archive unpacking and bit-for-bit file restoration.

---

## 3. Probe-Code Design ("Look Inside the UI" Infrastructure)

### 3.1 Purpose & Role of Probes
Because tests run headless without visual rendering, **Probe Tools** inspect the live widget tree and database state at runtime. Probes dump structured JSON and readable text representations of the exact rendered UI, active fields, table cell contents, and database records.

> [!IMPORTANT]
> Probes are temporary diagnostic tooling, tagged with `@Tags(['probe'])`. They are excluded from normal CI runs (`flutter test --exclude-tags probe`) and run on-demand via `flutter test --tags probe`. Probes are not counted in the ~660 test case total.

### 3.2 Probe Architecture

```
test/probes/
├── probe_dumper.dart        # Core inspection and serialization engine
├── probe_screens_test.dart  # 12 screens dumped in Empty, Normal, and Boundary states
├── probe_data_test.dart     # Isar database state dumper after scripted operations
└── probe_states_test.dart   # Dynamic state inspector (Auth, Dialogs, Errors, Limits)
```

#### 1. `test/probes/probe_dumper.dart` (The Core Engine)
Provides static utilities to traverse and serialize the running widget tree:
- **`dumpWidgetTree(WidgetTester tester)`**: Traverses `tester.allWidgets` and outputs a hierarchical structure containing widget type, Key, text content, size, offset, alignment, and interactive state.
- **`collectRenderedTexts(WidgetTester tester)`**: Extracts all `Text`, `RichText`, and `EditableText` strings in top-to-bottom, left-to-right visual order.
- **`inspectFormFields(WidgetTester tester)`**: Serializes every `TextFormField` / `TextField`, extracting label text, hint text, validation error text, keyboard type, and obscure text flags.
- **`inspectDataTables(WidgetTester tester)`**: Parses `Table`, `DataTable`, and custom tile matrices into structured 2D row/column string representations.
- **`inspectChipsAndSegments(WidgetTester tester)`**: Extracts all `FilterChip`, `ChoiceChip`, and `SegmentedButton` labels along with their selected states.
- **`dumpSemantics(WidgetTester tester)`**: Dumps accessibility semantics, tooltips, and labels for discoverability verification.

#### 2. `test/probes/probe_screens_test.dart`
Renders each of the 12 primary screens across 3 distinct data fixtures:
- **State 1 (Empty):** Zero records, empty collections, default initial state.
- **State 2 (Normal Seed):** Realistic client data, populated tasks, scheduled events, marketing leads.
- **State 3 (Boundary / Edge):** Max limit reached (15 insurance companies), 50+ customer records, overdue reminders, leap-year dates.

Outputs written to `build/probes/`:
- `build/probes/<screen_name>__<state>.txt` (Human-readable layout dump)
- `build/probes/<screen_name>__<state>.json` (Structured AST for automated diffing)
- `build/probes/SUMMARY.md` (Index catalog of all captured screen dumps)

#### 3. `test/probes/probe_data_test.dart`
Performs end-to-end database operations (CRUD, cascade renames, carry-forward, ZIP export) and dumps the exact Isar collection state to `build/probes/data__<operation>.json`. This verifies that the data feeding the UI matches backend expectations exactly.

#### 4. `test/probes/probe_states_test.dart`
Pumps interactive dynamic states:
- First-time PIN setup vs. locked auth gate vs. unlocked session.
- Error snackbars (incorrect PIN, duplicate company name, 15-company limit exceeded).
- Export/Import loading indicators and overwrite warning dialogs.
- Sync direct-connect and discovery status cards.

---

## 4. Feature Inventory → Test Repository Mapping Matrix

| Feature / Subsystem | Components / Models | Test File (Suite A - UI) | Test File (Suite B - Usability) | Test File (Suite C - Integration) | Target Cases |
|---|---|---|---|---|:---:|
| **Auth & App Security** | `AuthGate`, `SecurityLockScreen`, `SecurityService`, `authStateProvider` | `test/ui/auth_lock_ui_test.dart` | `test/usability/auth_journey_test.dart` | `test/integration/security_service_test.dart` | 42 |
| **Navigation & Shell** | `MainNavigationShell`, `BrandSidenav`, `CurvedOverscrollBehavior` | `test/ui/navigation_shell_ui_test.dart` | `test/usability/responsive_shell_test.dart` | `test/integration/navigation_provider_test.dart` | 34 |
| **Dashboard** | `DashboardScreen`, `DailyNote`, `todaySummaryEventsProvider`, `todayNotesProvider` | `test/ui/dashboard_ui_test.dart` | `test/usability/dashboard_flow_test.dart` | `test/integration/dashboard_summary_test.dart` | 58 |
| **Customer List & Search** | `CustomerListScreen`, `searchQueryProvider`, `customerSearchTabProvider` | `test/ui/customer_list_ui_test.dart` | `test/usability/search_filter_journey_test.dart` | `test/integration/customer_query_test.dart` | 62 |
| **Customer Form & Entry** | `CustomerFormScreen`, `CustomerDocument`, `CustomerPlanItem` | `test/ui/customer_form_ui_test.dart` | `test/usability/form_entry_journey_test.dart` | `test/integration/customer_crud_test.dart` | 74 |
| **Customer Detail View** | `CustomerDetailScreen`, profile visualizer, document viewer | `test/ui/customer_detail_ui_test.dart` | `test/usability/customer_detail_flow_test.dart` | `test/integration/customer_detail_test.dart` | 48 |
| **Upcoming Events** | `UpcomingEventsScreen`, `upcomingEventsProvider`, 30-day window | `test/ui/upcoming_events_ui_test.dart` | `test/usability/events_action_test.dart` | `test/integration/events_engine_test.dart` | 44 |
| **Work Management** | `WorkManagementScreen`, `WorkTask`, `Company`, 15-limit, carry-forward | `test/ui/work_management_ui_test.dart` | `test/usability/work_task_journey_test.dart` | `test/integration/work_carry_forward_test.dart` | 72 |
| **Marketing Leads** | `MarketingScreen`, `MarketingLead`, `MarketingVisit`, multi-photos | `test/ui/marketing_ui_test.dart` | `test/usability/marketing_journey_test.dart` | `test/integration/marketing_crud_test.dart` | 52 |
| **Performance Matrix** | `PerformanceScreen`, `PerformanceRecord`, `TopicTableRow`, Box 1-4 | `test/ui/performance_ui_test.dart` | `test/usability/performance_table_test.dart` | `test/integration/performance_matrix_test.dart` | 64 |
| **Settings & Sync** | `SyncScreen`, `SyncService`, `dateFormatPatternProvider`, auto-lock | `test/ui/sync_settings_ui_test.dart` | `test/usability/sync_settings_flow_test.dart` | `test/integration/sync_service_test.dart` | 50 |
| **Backup & Restore** | `BackupService`, ZIP export/import, base64 extraction, overwrite | `test/ui/backup_dialogs_ui_test.dart` | `test/usability/backup_restore_journey_test.dart` | `test/integration/backup_roundtrip_test.dart` | 38 |
| **PDF & Image Export** | `DashboardExportService`, profile PDF, dashboard snapshot | `test/ui/export_rendering_ui_test.dart` | `test/usability/export_share_flow_test.dart` | `test/integration/pdf_export_bytes_test.dart` | 22 |
| **Custom Widgets** | `KeyCycleDropdown`, `SegmentedDateInputField`, formatters, badges | `test/ui/widgets_ui_test.dart` | `test/usability/keyboard_cycling_test.dart` | `test/integration/formatters_test.dart` | 38 |
| **Total Target** | | **~235 Cases** | **~165 Cases** | **~260 Cases** | **~660 Cases** |

---

## 5. Full Test Catalog

Every test case is defined with a stable, globally unique Test ID, grouped by its owning test suite file, with an explicit `Setup → Action → Expected` specification.

### 5.1 Suite A: UI & Surface Tests (~235 Cases)

#### `test/ui/auth_lock_ui_test.dart` (14 Cases)
- `UI-AUT-001`: Auth uninitialized state → render `AuthGate` → loading spinner is displayed while checking secure storage.
- `UI-AUT-002`: Setup required state → render `SecurityLockScreen` → title displays "Create Security PIN" and subtitle "Set up a 4-digit PIN to secure your data offline.".
- `UI-AUT-003`: Setup step 1 → enter 4 digits → screen transitions to "Confirm Security PIN" with empty dot indicators.
- `UI-AUT-004`: Setup confirmation mismatch → enter differing PIN → error message "PINs did not match. Enter New PIN" displayed.
- `UI-AUT-005`: Locked state → render `SecurityLockScreen` → title displays "Enter Security PIN".
- `UI-AUT-006`: Locked state digit entry → tap digits 1, 2, 3 → exactly 3 of 4 PIN dots render in filled/active style.
- `UI-AUT-007`: Locked state backspace → tap backspace button → last filled PIN dot returns to outline/empty state.
- `UI-AUT-008`: Locked state incorrect PIN → enter invalid PIN → error message "Incorrect PIN. Try Again." displayed.
- `UI-AUT-009`: PIN pad buttons → inspect UI → digits 0–9, backspace icon, and version pill are present.
- `UI-AUT-010`: Branding footer → inspect footer → "JJ CRM - Offline Customer Detail Management System v2.0.1" text rendered.
- `UI-AUT-011`: Numeric keypad click ripple → press digit 5 → button triggers splash ink response.
- `UI-AUT-012`: Reset PIN error state → type new digit after error → error text clears automatically.
- `UI-AUT-013`: Lock screen logo asset → render screen → app logo image is present and scaled appropriately.
- `UI-AUT-014`: Successful unlock animation → enter correct PIN → screen triggers smooth fade transition to shell.

#### `test/ui/navigation_shell_ui_test.dart` (16 Cases)
- `UI-NAV-001`: Desktop layout (>600px width) → pump `MainNavigationShell` → `BrandSidenav` is visible and bottom `NavigationBar` is hidden.
- `UI-NAV-002`: Mobile layout (<=600px width) → pump `MainNavigationShell` with 400px width → bottom `NavigationBar` is visible and `BrandSidenav` is hidden.
- `UI-NAV-003`: App bar logo → inspect AppBar → JJ CRM logo and styled "JJ CRM" rich text rendered.
- `UI-NAV-004`: App bar Cloud Sync action → inspect AppBar actions → sync icon button present with tooltip "Cloud Sync".
- `UI-NAV-005`: App bar Settings action → inspect AppBar actions → settings icon button present with tooltip "Settings".
- `UI-NAV-006`: Sidenav destinations → inspect desktop sidenav → 6 destinations rendered: Dashboard, Customers, Events, Performance, Work, Marketing.
- `UI-NAV-007`: Bottom nav destinations → inspect mobile nav bar → 6 navigation items rendered with correct icons.
- `UI-NAV-008`: Active tab highlight → default state (index 0) → Dashboard destination has active indicator color.
- `UI-NAV-009`: Tab click navigation → tap Customers destination → index updates to 1 and `CustomerListScreen` is rendered.
- `UI-NAV-010`: Sidenav collapse toggle → tap collapse button on desktop rail → sidenav contracts to icon-only mode.
- `UI-NAV-011`: Sidenav expand toggle → tap expand button → sidenav expands to show text labels.
- `UI-NAV-012`: Sidenav footer branding → inspect sidenav bottom → ShineCraft branding footer is visible when expanded.
- `UI-NAV-013`: Sidenav active tooltip → hover over collapsed item → tooltip with destination name appears.
- `UI-NAV-014`: App bar Sync tap → tap sync icon → navigates to `SyncScreen`.
- `UI-NAV-015`: App bar Settings tap → tap settings icon → navigates to `SyncScreen`.
- `UI-NAV-016`: Overscroll behavior → scroll content past edge → glowing overscroll indicator in SkyBlue is triggered.

#### `test/ui/dashboard_ui_test.dart` (24 Cases)
- `UI-DSH-001`: Dashboard header → pump `DashboardScreen` → greeting headline and formatted current date string are rendered.
- `UI-DSH-002`: Total Customers Stat Card → inspect metrics row → card shows correct seeded customer count and icon.
- `UI-DSH-003`: Marketing Leads Stat Card → inspect metrics row → card shows correct active lead count.
- `UI-DSH-004`: Documents Pending Stat Card → inspect metrics row → card shows count of customers with missing KYC documents.
- `UI-DSH-005`: Quick action "Add Customer" → inspect action buttons → "Add Customer" button present with plus icon.
- `UI-DSH-006`: Quick action "Add Customer" tap → click "Add Customer" → navigates to `CustomerFormScreen`.
- `UI-DSH-007`: Quick action "Add Note" → inspect action buttons → "Add Note" button present.
- `UI-DSH-008`: Quick action "Export PDF" → inspect action buttons → "Export PDF" button present.
- `UI-DSH-009`: Quick action "Share Snapshot" → inspect action buttons → "Share Snapshot" button present.
- `UI-DSH-010`: Tomorrow's Summary section title → inspect summary header → "Tomorrow's Work & Event Summary" title rendered.
- `UI-DSH-011`: Filter chips render → inspect summary bar → chips for All, Reminders, Work Tasks, and Marketing are rendered.
- `UI-DSH-012`: Filter chip selection → tap "Reminders" chip → chip becomes selected and only reminder events are listed.
- `UI-DSH-013`: Empty summary state → seed zero events for tomorrow → "No events or follow-ups scheduled for tomorrow!" message rendered.
- `UI-DSH-014`: Summary list tile content → seed reminder event → tile shows customer name, note subtitle, and "Reminder" category badge.
- `UI-DSH-015`: Work task summary tile → seed work task → tile shows task description, priority tag, and status.
- `UI-DSH-016`: Marketing visit summary tile → seed visit → tile shows lead name, scheduled time, and status.
- `UI-DSH-017`: Day Task Notes panel → inspect sidebar → "Day Task Notes & Checklist" title and counter rendered.
- `UI-DSH-018`: Day Task Notes empty state → no notes seeded → hint text "Add a quick task note for tomorrow..." displayed.
- `UI-DSH-019`: Add note text input → type "Follow up with LIC agent" → text field accepts input.
- `UI-DSH-020`: Add note category selector → open category menu → options "General" and "Marketing" are present.
- `UI-DSH-021`: Add note button tap → enter note text and tap add → note appears in checklist.
- `UI-DSH-022`: Note completion checkbox → click note checkbox → note strikes through and counter updates to "1/1 Done".
- `UI-DSH-023`: Note delete action → click trash icon on note → note is removed from checklist.
- `UI-DSH-024`: Refresh button → tap "Refresh Tomorrow Data" icon → triggers provider refresh and progress indicator.

#### `test/ui/customer_list_ui_test.dart` (24 Cases)
- `UI-CST-001`: Screen title and count badge → pump `CustomerListScreen` → "Customer Directory" header and total count badge rendered.
- `UI-CST-002`: Search bar input → inspect search bar → hint "Search by name, customer ID, mobile, or document..." rendered.
- `UI-CST-003`: Segmented tab bar → inspect tabs → "All", "Profiles", and "Documents" tabs are present.
- `UI-CST-004`: Add Customer floating action button → inspect FAB → icon `Icons.person_add` present.
- `UI-CST-005`: Add Customer FAB tap → click FAB → navigates to `CustomerFormScreen`.
- `UI-CST-006`: Empty directory state → zero customers seeded → "No customer records found" empty state with illustration rendered.
- `UI-CST-007`: Customer card layout → seed customer "Ramesh Sharma" → card renders name, Customer ID, primary mobile, and assigned company.
- `UI-CST-008`: Customer card policy count badge → customer with 3 plans → badge renders "3 Policies".
- `UI-CST-009`: Customer card document count badge → customer with 4 docs → badge renders "4 Documents".
- `UI-CST-010`: Customer card tap → tap card → navigates to `CustomerDetailScreen` with customer ID.
- `UI-CST-011`: Quick call action → tap phone icon on card → triggers URL launcher intent for `tel:<mobile>`.
- `UI-CST-012`: Quick WhatsApp action → tap WhatsApp icon → triggers URL launcher intent for `https://wa.me/<mobile>`.
- `UI-CST-013`: Search filter profiles tab → select "Profiles" tab and search "Ramesh" → only profile match displayed.
- `UI-CST-014`: Search filter documents tab → select "Documents" tab and search "Aadhaar" → matching customer card highlights "Aadhaar" document badge.
- `UI-CST-015`: Search clear button → type query and tap 'X' clear button → search input resets and full list restores.
- `UI-CST-016`: Sorting dropdown → inspect sort menu → options "Name (A-Z)", "Name (Z-A)", "Recently Added", "Upcoming Birthday" present.
- `UI-CST-017`: Sort by Name (Z-A) → select Z-A → customer cards reorder alphabetically descending.
- `UI-CST-018`: Pagination controls → seed 25 customers → pagination bar displays "Page 1 of 2" with Next/Previous arrows.
- `UI-CST-019`: Pagination next page tap → tap Next button → displays records 21–25.
- `UI-CST-020`: Customer delete swipe/menu → tap more options → "Delete Profile" item present.
- `UI-CST-021`: Delete confirmation dialog → select "Delete Profile" → modal dialog asks "Are you sure you want to delete <Name>?".
- `UI-CST-022`: Delete dialog cancel → click Cancel → dialog closes and customer remains in list.
- `UI-CST-023`: Delete dialog confirm → click Confirm Delete → snackbar "Customer profile deleted" displayed.
- `UI-CST-024`: Export single customer PDF → select "Export PDF" from card menu → triggers PDF generation indicator.

#### `test/ui/customer_form_ui_test.dart` (30 Cases)
- `UI-FRM-001`: Form mode create title → pump `CustomerFormScreen()` → AppBar title is "New Customer Profile".
- `UI-FRM-002`: Form mode edit title → pump `CustomerFormScreen(customer: existing)` → AppBar title is "Edit Customer Profile".
- `UI-FRM-003`: Personal section header → inspect section 1 → "1. Personal Information" header rendered.
- `UI-FRM-004`: Full Name field → inspect text field → label "Full Name *", required asterisk rendered.
- `UI-FRM-005`: Full Name validator → leave empty and submit → error "Full Name is required" displayed.
- `UI-FRM-006`: Date of Birth segmented field → inspect DOB field → segmented DD/MM/YYYY input rendered.
- `UI-FRM-007`: Gender / Marital status dropdown → inspect dropdown → options "Single", "Married", "Divorced", "Widowed" present.
- `UI-FRM-008`: Aadhaar number input → inspect field → 12-digit max length, auto-spacing formatter active.
- `UI-FRM-009`: PAN number input → inspect field → uppercase auto-capitalization active.
- `UI-FRM-010`: Contact section header → inspect section 2 → "2. Contact Information" header rendered.
- `UI-FRM-011`: Mobile Number 1 field → inspect field → label "Mobile Number 1 *", phone keypad type.
- `UI-FRM-012`: Mobile Number 1 validator → enter 5 digits and submit → error "Enter a valid 10-digit mobile number" displayed.
- `UI-FRM-013`: Optional mobile fields → inspect fields → Mobile 2, Mobile 3, Mobile 4 inputs available.
- `UI-FRM-014`: Email ID validator → enter "invalid-email" → error "Enter a valid email address" displayed.
- `UI-FRM-015`: Family section header → inspect section 3 → "3. Family Details" header rendered.
- `UI-FRM-016`: Number of Children counter → tap "+" button → children counter increments and new Child DOB input row appears.
- `UI-FRM-017`: Professional section header → inspect section 4 → "4. Professional & Financial Details" header rendered.
- `UI-FRM-018`: Annual Income field → inspect field → currency formatting prefix rendered.
- `UI-FRM-019`: Insurance section header → inspect section 5 → "5. Insurance Policy Information" header rendered.
- `UI-FRM-020`: Assigned Company dropdown → inspect dropdown → lists all active insurance companies.
- `UI-FRM-021`: Add Policy item button → click "+ Add Policy Plan" → dynamic policy sub-form row added.
- `UI-FRM-022`: Policy sub-form fields → inspect row → Product Name, Policy Number, Sum Assured, Premium, Mode, Rider fields present.
- `UI-FRM-023`: Nominee section header → inspect section 6 → "6. Nominee & Appointee Information" header rendered.
- `UI-FRM-024`: Health section header → inspect section 7 → "7. Health & Medical History" header rendered.
- `UI-FRM-025`: Document Uploads section → inspect section 8 → 13 document attachment cards rendered.
- `UI-FRM-026`: Document upload slot names → verify slots → Age Proof, ID Proof, Address Proof, Photo, Form 16, Bank Statement, etc. present.
- `UI-FRM-027`: Reminders section → inspect section 9 → Reminder 1–5 date pickers and note fields rendered.
- `UI-FRM-028`: Save Customer button → inspect bottom bar → GradientButton with "Save Customer Profile" label.
- `UI-FRM-029`: Form discard dialog → modify field and tap Back button → "Discard Unsaved Changes?" confirmation dialog appears.
- `UI-FRM-030`: Save success snackbar → fill valid data and save → snackbar "Customer profile saved successfully!" displayed.

#### `test/ui/customer_detail_ui_test.dart` (20 Cases)
- `UI-DTL-001`: Detail screen title → pump `CustomerDetailScreen` → AppBar shows customer name.
- `UI-DTL-002`: Header profile card → inspect card → customer avatar initials, customer ID, mobile, and email rendered.
- `UI-DTL-003`: Quick action buttons → inspect header bar → Call, WhatsApp, Edit, Export PDF, and Delete action buttons present.
- `UI-DTL-004`: Edit button tap → tap Edit → navigates to `CustomerFormScreen` in edit mode.
- `UI-DTL-005`: Export PDF button tap → tap Export PDF → loading indicator appears and export service is invoked.
- `UI-DTL-006`: Personal info card → inspect card → DOB, Age, Gender, Aadhaar, PAN, Nationality displayed.
- `UI-DTL-007`: Family info card → inspect card → Father's name, Mother's age, Spouse name, Children DOBs rendered.
- `UI-DTL-008`: Professional info card → inspect card → Employer name, Designation, Annual Income rendered.
- `UI-DTL-009`: Address card → inspect card → Communication Address and Permanent Address rendered.
- `UI-DTL-010`: Policies table → customer with 2 policies → table displays 2 rows with Product Name, Sum Assured, Premium, and Mode.
- `UI-DTL-011`: Nominee details card → inspect card → Nominee Name, Relation, DOB, and Mobile rendered.
- `UI-DTL-012`: Health info card → inspect card → Health problems, Lifestyle habits, and Personal Accident cover status rendered.
- `UI-DTL-013`: Reminders timeline → customer with 3 reminders → vertical timeline renders 3 reminder cards with dates and notes.
- `UI-DTL-014`: Document gallery section → inspect gallery → grid of uploaded document cards rendered.
- `UI-DTL-015`: Document thumbnail preview → document with attached image → image thumbnail displayed.
- `UI-DTL-016`: Document thumbnail tap → tap thumbnail → full-screen image viewer modal opens.
- `UI-DTL-017`: Document missing slot → slot without attachment → displays "Not Uploaded" placeholder.
- `UI-DTL-018`: Notes card → inspect notes section → customer general notes text rendered.
- `UI-DTL-019`: Delete customer action → tap Delete button → confirmation modal opens.
- `UI-DTL-020`: Delete customer success → confirm delete → screen pops back to `CustomerListScreen`.

#### `test/ui/upcoming_events_ui_test.dart` (18 Cases)
- `UI-EVT-001`: Screen title and timeframe → pump `UpcomingEventsScreen` → header "Upcoming Events & Milestones (Next 30 Days)" rendered.
- `UI-EVT-002`: Category filter tabs → inspect filter bar → "All Events", "Birthdays", "Anniversaries", "Reminders", "Marketing" tabs present.
- `UI-EVT-003`: Empty events state → zero upcoming events → "No upcoming events in the next 30 days" message displayed.
- `UI-EVT-004`: Birthday event card → customer birthday in 5 days → card renders "<Name>'s Birthday", "In 5 days", and age milestone.
- `UI-EVT-005`: Child birthday event card → child DOB in 12 days → card renders "<Customer>'s Child Birthday (Turning 8)".
- `UI-EVT-006`: Anniversary event card → anniversary in 3 days → card renders "<Name>'s Anniversary", "In 3 days", and years married.
- `UI-EVT-007`: Follow-up reminder card → reminder date tomorrow → card renders "Follow-up reminder: <Name>", "Tomorrow", and note text.
- `UI-EVT-008`: Marketing visit card → visit scheduled today → card renders "Marketing Visit: <Lead Name>", "Today", and scheduled time.
- `UI-EVT-009`: Personal accident reminder card → PA date in 10 days → card renders "Personal Accident Anniversary: <Name>".
- `UI-EVT-010`: Direct phone button on card → tap phone icon on event card → launches dialer.
- `UI-EVT-011`: Direct WhatsApp button on card → tap WhatsApp icon → launches WhatsApp chat.
- `UI-EVT-012`: Event card customer tap → tap customer name on event card → navigates to `CustomerDetailScreen`.
- `UI-EVT-013`: Filter by Birthdays → tap "Birthdays" tab → only birthday cards are displayed.
- `UI-EVT-014`: Filter by Anniversaries → tap "Anniversaries" tab → only anniversary cards are displayed.
- `UI-EVT-015`: Filter by Reminders → tap "Reminders" tab → only reminder cards are displayed.
- `UI-EVT-016`: Filter by Marketing → tap "Marketing" tab → only marketing visit cards are displayed.
- `UI-EVT-017`: Chronological ordering → multiple events seeded → cards are ordered by date ascending (Today first, then 30 days out).
- `UI-EVT-018`: Refresh events button → tap refresh button → triggers events provider recalculation.

#### `test/ui/work_management_ui_test.dart` (24 Cases)
- `UI-WRK-001`: Screen title and tabs → pump `WorkManagementScreen` → header "Daily Work Management" and 3 category tabs rendered.
- `UI-WRK-002`: Configurable tab titles → default state → tabs render "Tab 1", "Tab 2", "Tab 3".
- `UI-WRK-003`: Custom tab titles → stored tab titles "Insurance", "Mutual Funds", "Loans" → tabs render customized titles.
- `UI-WRK-004`: Tab rename button → tap pencil icon on tab → `RenameFileDialog` opens with text field.
- `UI-WRK-005`: Tab rename submit → enter "General Insurance" and save → tab title updates immediately.
- `UI-WRK-006`: Company list rail → inspect sidebar → 15 company buttons rendered for selected tab.
- `UI-WRK-007`: Active company selection → tap "Company 3" → button highlights and task table loads tasks for Company 3.
- `UI-WRK-008`: Company rename action → click edit icon on company button → rename dialog appears.
- `UI-WRK-009`: Company rename duplicate error → enter existing company name → error "Company name already exists" displayed.
- `UI-WRK-010`: Date selector bar → inspect top bar → date navigation with Previous Day, Today, Next Day buttons, and date picker.
- `UI-WRK-011`: Show All History toggle → toggle "Show All History" switch → switch toggles between all dates and selected date.
- `UI-WRK-012`: Add Task button → inspect action bar → "Add Work Task" button present.
- `UI-WRK-013`: Add Task dialog → tap "Add Work Task" → modal dialog with Description, Priority, Status, Assigned To, Method opens.
- `UI-WRK-014`: Task table columns → inspect table header → columns: Description, Priority, Assigned To, Method, Status, Actions rendered.
- `UI-WRK-015`: Task row priority badge Urgent → task with Urgent priority → red `ColorBadge` with "Urgent" rendered.
- `UI-WRK-016`: Task row priority badge Important → task with Important priority → orange `ColorBadge` with "Important" rendered.
- `UI-WRK-017`: Task row priority badge Normal → task with Normal priority → blue `ColorBadge` with "Normal" rendered.
- `UI-WRK-018`: Task row status dropdown → tap status chip on row → menu options: "Completed", "Pending", "Under Process", "No Response".
- `UI-WRK-019`: Task status update → change status to "Completed" → status chip updates to green and database updates.
- `UI-WRK-020`: Task Carry Forward badge → task carried forward → row displays "Carried from <Date>" indicator.
- `UI-WRK-021`: Edit task dialog → click edit icon on task row → edit dialog opens pre-filled with task details.
- `UI-WRK-022`: Delete task action → click delete icon on task row → confirmation modal opens.
- `UI-WRK-023`: Empty task list state → company with zero tasks → "No work tasks recorded for this date" message rendered.
- `UI-WRK-024`: 15 company limit enforcement → verify tab structure → exactly 15 company slots maintained per tab.

#### `test/ui/marketing_ui_test.dart` (20 Cases)
- `UI-MKT-001`: Screen title and count → pump `MarketingScreen` → header "Marketing & Lead Tracking" and lead counter rendered.
- `UI-MKT-002`: Add Lead button → inspect action bar → "+ New Marketing Lead" button present.
- `UI-MKT-003`: Add Lead modal dialog → tap "+ New Marketing Lead" → dialog with Lead Name, Mobile, Status, Notes opens.
- `UI-MKT-004`: Empty leads state → zero leads seeded → "No marketing leads yet" empty state rendered.
- `UI-MKT-005`: Lead card header → seed lead "Vikram Singh" → card renders lead name, phone number, and status badge.
- `UI-MKT-006`: Status badge colors → lead status "Interested" → green badge; "Follow Up" → orange badge; "Dropped" → red badge.
- `UI-MKT-007`: Lead quick call button → tap phone button on lead card → launches dialer.
- `UI-MKT-008`: Add Visit button → inspect lead card → "+ Log Visit / Follow-up" button present.
- `UI-MKT-009`: Log Visit modal dialog → tap "+ Log Visit" → dialog with Visit Date, Time, Notes, Photo Attachment slots opens.
- `UI-MKT-010`: Visit history timeline → lead with 2 visits → timeline lists visit 1 and visit 2 with timestamps and notes.
- `UI-MKT-011`: Visit photo thumbnail → visit with attached photo → thumbnail image displayed in visit row.
- `UI-MKT-012`: Visit photo tap → tap photo thumbnail → full-screen image viewer opens.
- `UI-MKT-013`: Edit lead dialog → click edit icon on lead card → edit dialog opens with current values.
- `UI-MKT-014`: Delete lead action → click edit icon on lead card → delete confirmation modal opens.
- `UI-MKT-015`: Status filter chips → inspect filter bar → chips: All, New, Interested, Follow Up, Closed, Dropped rendered.
- `UI-MKT-016`: Filter leads by status → select "Interested" → only leads with Interested status displayed.
- `UI-MKT-017`: Search leads input → type "Vikram" in search bar → list filters to matching leads.
- `UI-MKT-018`: Convert lead to customer button → tap "Convert to Customer" → opens `CustomerFormScreen` pre-filled with lead name and mobile.
- `UI-MKT-019`: Delete visit record → click delete icon on individual visit → visit removed from history.
- `UI-MKT-020`: Save lead validation → leave name blank in add modal → error "Lead name is required" displayed.

#### `test/ui/performance_ui_test.dart` (22 Cases)
- `UI-PRF-001`: Screen title and date picker → pump `PerformanceScreen` → header "Monthly Performance Matrix" and Year/Month selector rendered.
- `UI-PRF-002`: Year dropdown selector → inspect year dropdown → years 2020–2030 available.
- `UI-PRF-003`: Month dropdown selector → inspect month dropdown → months January–December available.
- `UI-PRF-004`: Box 1 Summary KPIs → inspect Box 1 → Urgent, New Business, Life, Fire/Health/PA, Earned input fields rendered.
- `UI-PRF-005`: Box 1 field editing → enter "50000" in Earned field → field accepts text and updates state.
- `UI-PRF-006`: Box 2 Working Days → inspect Box 2 → Row 1 Days, Earnings on Worked Days, Row 2 Days, Total Working Days rendered.
- `UI-PRF-007`: Box 3 Matrix table headers → inspect Box 3 → 7 column headers: JJ workway, Target, YY, ZZ, Percentage, Column 6, Column 7 rendered.
- `UI-PRF-008`: Box 3 Column header rename → tap header "JJ workway" → rename header dialog opens.
- `UI-PRF-009`: Box 3 Row header rename → tap row header "Row 1" → rename row header dialog opens.
- `UI-PRF-010`: Box 3 cell matrix inputs → inspect 4x7 grid → all 28 editable text cells are present and accessible.
- `UI-PRF-011`: Box 4 Target & Balance → inspect Box 4 → Balance, Target, Achieved fields rendered.
- `UI-PRF-012`: Monthly Topic Table header → inspect topic section → "Daily Topic Tracking Table (14 Columns)" header rendered.
- `UI-PRF-013`: Topic table column headers → inspect headers → Date column + 13 Topic headers (Topic 1 to Topic 13) rendered.
- `UI-PRF-014`: Topic column header rename → tap "Topic 1" header → rename dialog opens; submit "LIC Calls" → header updates to "LIC Calls".
- `UI-PRF-015`: Add Topic Row button → inspect action bar → "+ Add Day Row" button present.
- `UI-PRF-016`: Add Topic Row tap → click "+ Add Day Row" → new row with today's date and 13 empty cells added to table.
- `UI-PRF-017`: Topic cell editing → type "15" in row 1, topic 2 cell → cell stores value.
- `UI-PRF-018`: Topic row date change → click date cell in topic row → date picker modal opens.
- `UI-PRF-019`: Delete Topic row → click trash icon on topic row → row is deleted from table.
- `UI-PRF-020`: Month switch reactivity → switch month from March to April → performance matrix reloads April record.
- `UI-PRF-021`: Auto-save indicator → edit any performance cell → subtle "Saved" checkmark indicator appears.
- `UI-PRF-022`: Export performance report → tap export button → triggers PDF generation of monthly performance matrix.

#### `test/ui/sync_settings_ui_test.dart` (24 Cases)
- `UI-SYN-001`: Screen title → pump `SyncScreen` → AppBar title "Settings & Synchronization" rendered.
- `UI-SYN-002`: Local Server Status Card → inspect card 1 → icon `Icons.wifi_tethering`, title "Local Server Status", and power switch rendered.
- `UI-SYN-003`: Server switch toggle ON → toggle switch to ON → server status text displays port and IP address.
- `UI-SYN-004`: Server switch toggle OFF → toggle switch to OFF → server status text displays "Server is stopped.".
- `UI-SYN-005`: Discover Nearby Devices Card → inspect card 2 → title "Discover Nearby Devices", Direct Connect button, and Play/Stop scan button rendered.
- `UI-SYN-006`: Discovery inactive state → scan not running → displays "Discovery inactive. Press Play above to scan.".
- `UI-SYN-007`: Discovery active state → tap Play button → displays "Scanning Wi-Fi broadcast channels..." with loading animation.
- `UI-SYN-008`: Discovered device tile → seed discovered device "JJ-CRM-Desktop (192.168.1.10:8080)" → tile displays host name and "Sync Now" button.
- `UI-SYN-009`: Direct Connect dialog → tap LAN icon → dialog opens with IP Address and Port text fields.
- `UI-SYN-010`: Direct Connect validator → leave IP blank and submit → error "IP address is required" displayed.
- `UI-SYN-011`: Vault Passcode Configuration Card → inspect card 3 → title "Vault Passcode Configuration" rendered.
- `UI-SYN-012`: Change PIN button → click "Change Security PIN Code" → PIN change dialog opens.
- `UI-SYN-013`: Change PIN dialog fields → inspect dialog → Current PIN, New PIN, Confirm New PIN fields present.
- `UI-SYN-014`: Change PIN validator mismatch → enter differing new/confirm PINs → error "PIN codes do not match" displayed.
- `UI-SYN-015`: Auto-Lock Timeout setting → inspect timeout row → label "Auto-Lock Idle Timeout" and dropdown rendered.
- `UI-SYN-016`: Auto-Lock dropdown options → open dropdown → options: "1 Minute", "5 Minutes", "15 Minutes", "30 Minutes", "Never" present.
- `UI-SYN-017`: Auto-Lock change → select "15 Minutes" → snackbar "Auto-lock set to 15 minutes" displayed.
- `UI-SYN-018`: Global Date Format Preferences Card → inspect card 4 → title "Global Date Format Settings" and dropdown rendered.
- `UI-SYN-019`: Date format options → open dropdown → options: "DD/MM/YYYY", "MM/DD/YYYY", "YYYY-MM-DD", "DD MMM YYYY" present.
- `UI-SYN-020`: Date format change → select "YYYY-MM-DD" → updates system active date pattern.
- `UI-SYN-021`: Backup & Restore Card → inspect card 5 → title "Backup & Restore Utility", "Export Data", and "Import Data" buttons rendered.
- `UI-SYN-022`: Version footer → inspect bottom → "JJ CRM - Offline Customer Detail Management System v2.0.1" text rendered.
- `UI-SYN-023`: Developer Sandbox unlock → tap version string 5 times → snackbar "Developer Sandbox Tools Unlocked!" displayed and sandbox card appears.
- `UI-SYN-024`: Developer Sandbox buttons → inspect sandbox card → "Seed Dummy Data" and "Clear All Data" buttons rendered.

#### `test/ui/backup_dialogs_ui_test.dart` (15 Cases)
- `UI-BAK-001`: Export Data button tap → tap "Export Data" on `SyncScreen` → PIN verification dialog "Enter PIN to Export" appears.
- `UI-BAK-002`: Export PIN dialog explanation → inspect dialog → text "Please verify your 4-digit security PIN before exporting sensitive client directories." rendered.
- `UI-BAK-003`: Export PIN invalid entry → enter wrong PIN and submit → inline error "Incorrect PIN" displayed.
- `UI-BAK-004`: Export PIN valid entry → enter correct PIN → export loading modal "Compiling database and base64 document payloads..." appears.
- `UI-BAK-005`: Export success snackbar → export completes → snackbar "ZIP Backup archive (with photos & documents) exported successfully!" displayed.
- `UI-BAK-006`: Import Data button tap → tap "Import Data" → overwrite warning dialog "Overwrite Warning" appears.
- `UI-BAK-007`: Overwrite warning explanation → inspect dialog → warning icon and text "Importing a backup file will permanently replace all current database records..." rendered.
- `UI-BAK-008`: Overwrite dialog cancel → click Cancel → dialog closes and no file picker is opened.
- `UI-BAK-009`: Overwrite dialog confirm → click "Replace All Data" → file picker opens for `.zip` or `.json` files.
- `UI-BAK-010`: Import loading modal → valid file selected → loading modal "Unpacking ZIP archive & restoring records..." appears.
- `UI-BAK-011`: Import success snackbar → import completes → snackbar "Database and attachments restored successfully!" displayed.
- `UI-BAK-012`: Import corrupt file error → select corrupted archive → error snackbar "Import failed: Invalid or corrupted backup archive" displayed.
- `UI-BAK-013`: Sandbox Seed Dummy confirmation → click "Seed Dummy Data" → confirmation dialog "Erase Current Data & Seed Dummy Data?" appears.
- `UI-BAK-014`: Sandbox Clear All confirmation → click "Clear All Data" → confirmation dialog "Clear All Application Data?" with red warning icon appears.
- `UI-BAK-015`: Sandbox Clear All confirm → click "Clear Everything" → snackbar "All database records and document attachments cleared successfully!" displayed.

#### `test/ui/widgets_ui_test.dart` (20 Cases)
- `UI-WDG-001`: `KeyCycleDropdownFormField` closed state → render dropdown → displays selected item label and dropdown arrow icon.
- `UI-WDG-002`: `KeyCycleDropdownFormField` decoration → verify InputDecoration → label, border, prefixIcon rendered properly.
- `UI-WDG-003`: `SegmentedDateInputField` initial layout → render widget → 3 segment boxes (DD, MM, YYYY) with slash dividers rendered.
- `UI-WDG-004`: `SegmentedDateInputField` error state → invalid date input → red error border and error message rendered below.
- `UI-WDG-005`: `DateInputFormatter` typing → enter "15051990" in formatted field → text displays "15/05/1990".
- `UI-WDG-006`: `AadhaarNumberFormatter` typing → enter "123456789012" → text displays "1234 5678 9012".
- `UI-WDG-007`: `BrandBackground` radial gradient → render wrapper → background container has configured gradient decoration.
- `UI-WDG-008`: `BrandCard` elevation and border → render card → border radius 12, subtle border side, elevation 0.5 rendered.
- `UI-WDG-009`: `ColorBadge` variant Success → render `ColorBadge(text: "Active", type: BadgeType.success)` → green background and dark green text rendered.
- `UI-WDG-010`: `ColorBadge` variant Warning → render `ColorBadge(text: "Pending", type: BadgeType.warning)` → amber background rendered.
- `UI-WDG-011`: `ColorBadge` variant Danger → render `ColorBadge(text: "Urgent", type: BadgeType.danger)` → red background rendered.
- `UI-WDG-012`: `ColorBadge` variant Info → render `ColorBadge(text: "Notice", type: BadgeType.info)` → blue background rendered.
- `UI-WDG-013`: `GradientButton` active style → render `GradientButton(label: "Submit")` → primary blue gradient, white text rendered.
- `UI-WDG-014`: `GradientButton` disabled style → render `GradientButton(onPressed: null)` → greyed-out gradient and non-clickable.
- `UI-WDG-015`: `GradientButton` loading state → render `GradientButton(isLoading: true)` → white CircularProgressIndicator centered.
- `UI-WDG-016`: `RenameFileDialog` modal layout → pump dialog → title, text field pre-filled with current name, Cancel and Save buttons rendered.
- `UI-WDG-017`: `RenameFileDialog` empty validation → submit empty string → error "Name cannot be empty" displayed.
- `UI-WDG-018`: `ShineCraftBrandingFooter` layout → render footer → ShineCraft logo and tagline rendered.
- `UI-WDG-019`: `CurvedOverscrollBehavior` rendering → trigger scroll overscroll → skyBlue glow indicator painted.
- `UI-WDG-020`: `BrandSidenav` collapsed item tooltip → hover over collapsed icon → tooltip renders label correctly.

---

### 5.2 Suite B: Usability & UX Journey Tests (~165 Cases)

#### `test/usability/auth_journey_test.dart` (20 Cases)
- `UX-AUT-001`: First-time user onboarding journey → launch app with no PIN set → setup screen appears → enter "1234" → confirmation prompt appears → re-enter "1234" → app unlocks into Dashboard.
- `UX-AUT-002`: Returning user unlock journey → launch app with PIN "2468" → lock screen appears → enter "2468" → unlocks into Dashboard.
- `UX-AUT-003`: Mistyped PIN error recovery → enter "9999" → shake animation and error displayed → tap backspace 4 times → enter "2468" → successfully unlocks.
- `UX-AUT-004`: Auto-lock on app backgrounding → app unlocked on Dashboard → trigger `AppLifecycleState.paused` → advance clock by 6 minutes → trigger `AppLifecycleState.resumed` → `SecurityLockScreen` is displayed.
- `UX-AUT-005`: No auto-lock when under timeout → app unlocked → pause app for 2 minutes (timeout = 5 min) → resume app → remains unlocked on Dashboard.
- `UX-AUT-006`: Auto-lock disabled (Never) → timeout set to 0 → pause app for 60 minutes → resume app → remains unlocked.
- `UX-AUT-007`: File picker exclusion from auto-lock → trigger document file picker (`isPickingFileProvider = true`) → app pauses during system picker → resume app → does not lock.
- `UX-AUT-008`: PIN change user journey → open Settings → tap Change PIN → enter current PIN "1234" → enter new PIN "5678" → confirm "5678" → submit → lock app → enter "5678" → unlocks successfully.
- `UX-AUT-009`: PIN change wrong current PIN → enter invalid current PIN → error snackbar shown → dialog remains open for correction.
- `UX-AUT-010`: Rapid digit entry responsiveness → enter 4 digits in rapid succession (10ms interval) → all 4 digits registered without dropping.
- `UX-AUT-011`: Physical keyboard numeric key entry → press physical keyboard keys 1, 2, 3, 4 on desktop → PIN fields register inputs.
- `UX-AUT-012`: Physical keyboard Backspace key → press physical Backspace key → removes last entered digit.
- `UX-AUT-013`: Physical keyboard Enter key on setup → enter 4 digits and press physical Enter → advances to confirm PIN step.
- `UX-AUT-014`: Session state persistence across warm restarts → unlock app → simulate hot restart / reload → state maintains decrypted status.
- `UX-AUT-015`: Lock screen visual masking → verify digit characters → characters immediately mask into bullet dots (no plaintext leakage).
- `UX-AUT-016`: Manual lock trigger → trigger manual lock from menu → immediately locks and requires PIN.
- `UX-AUT-017`: Maximum retry attempts UX → enter wrong PIN 5 times → cool-down timer message displayed.
- `UX-AUT-018`: PIN pad touch target size → verify keypad buttons → touch target size is >= 48x48dp for accessibility.
- `UX-AUT-019`: Accessibility semantics for PIN buttons → inspect keypad → each button has semantic label "Digit <N>".
- `UX-AUT-020`: High contrast visibility on PIN pad → inspect color contrast → text-to-background contrast ratio >= 4.5:1.

#### `test/usability/responsive_shell_test.dart` (18 Cases)
- `UX-SHL-001`: Desktop to mobile window resize → resize window from 1200px to 400px → desktop sidenav smoothly hides and mobile bottom navigation appears.
- `UX-SHL-002`: Mobile to desktop window resize → resize window from 400px to 1200px → mobile navigation bar hides and desktop sidenav expands.
- `UX-SHL-003`: Tablet breakpoint layout (768px) → render shell at 768px → compact icon-only sidenav rendered without overlapping content.
- `UX-SHL-004`: Navigation state preserved across resize → select "Work" tab (index 4) on mobile → resize to desktop → "Work" tab remains active on desktop sidenav.
- `UX-SHL-005`: Keyboard navigation between tabs → on desktop sidenav, press Down Arrow key → active navigation focus moves to next tab.
- `UX-SHL-006`: Sidenav shortcut keys → press Ctrl+1 through Ctrl+6 → switches directly to corresponding tabs 1–6.
- `UX-SHL-007`: Small mobile viewport (320px width) → render shell at 320px width → bottom nav labels ellipsize gracefully without RenderFlex overflow.
- `UX-SHL-008`: Landscape mobile viewport (800x400) → render in landscape → layout adapts without vertical overflow.
- `UX-SHL-009`: Ultrawide desktop viewport (2560px) → render at 2560px → main content container centers with max width constraint.
- `UX-SHL-010`: Sidenav collapse keyboard shortcut → press Ctrl+B → toggles desktop sidenav collapsed/expanded state.
- `UX-SHL-011`: Back button navigation on Android → navigate to Customers → open Customer Detail → press system Back button → returns to Customer List.
- `UX-SHL-012`: Double back button exit prevention on root → on Dashboard, press Back button → shows "Press back again to exit" toast.
- `UX-SHL-013`: Deep link routing within shell → trigger navigation event to customer ID 42 → shell opens Customer tab and pushes Detail screen.
- `UX-SHL-014`: Focus trap inside active modal dialog → open dialog → press Tab repeatedly → keyboard focus cycles only within modal elements.
- `UX-SHL-015`: Escape key closes open dialog → open dialog → press Escape key → dialog closes without saving.
- `UX-SHL-016`: Theme mode switch reactivity → toggle theme → all shell backgrounds and text colors transition without layout jitter.
- `UX-SHL-017`: Screen reader navigation labels → inspect bottom nav destinations → semantics announce "Tab 1 of 6: Dashboard, selected".
- `UX-SHL-018`: Touch target padding on navigation icons → inspect destination touch targets → minimum 48x48dp bounds verified.

#### `test/usability/form_entry_journey_test.dart` (25 Cases)
- `UX-FRM-001`: Complete customer creation user journey → click "Add Customer" → fill personal details, contact numbers, family DOBs, policy plan, upload 2 documents → click Save → redirects to Customer List and customer appears at top.
- `UX-FRM-002`: Segmented date field auto-advance → in DOB field, type "15" (day) → focus automatically advances to MM segment → type "05" (month) → focus advances to YYYY segment → type "1990".
- `UX-FRM-003`: Segmented date field backspace reverse → in YYYY segment, press Backspace on empty field → focus shifts back to MM segment.
- `UX-FRM-004`: Segmented date validation on blur → type "31/02/1990" (invalid February date) → move focus away → field shows "Invalid calendar date".
- `UX-FRM-005`: Leap year date validation → type "29/02/2024" (valid leap year) → passes validation; type "29/02/2023" (non-leap) → shows error.
- `UX-FRM-006`: Keyboard Tab traversal through form → press Tab sequentially → focus moves logically: Name → DOB → Gender → Marital Status → Mobile 1 → Email.
- `UX-FRM-007`: Dynamic policy plan addition flow → click "+ Add Policy Plan" 3 times → 3 policy sub-forms appear → fill each → remove 2nd plan → remaining 2 plans re-index cleanly.
- `UX-FRM-008`: Dynamic children DOB rows flow → set Number of Children to "2" → 2 Child DOB fields render → set to "3" → 3rd Child DOB field appears.
- `UX-FRM-009`: Aadhaar auto-formatting UX → paste "123456789012" into Aadhaar field → field automatically formats as "1234 5678 9012".
- `UX-FRM-010`: PAN uppercase auto-conversion → type "abcde1234f" into PAN field → field automatically displays "ABCDE1234F".
- `UX-FRM-011`: Phone number paste handling → paste "+91 98765 43210" into Mobile field → strips non-digits and stores "9876543210".
- `UX-FRM-012`: Document attachment picking flow → tap "Age Proof" slot → file picker opens → select image `pan.png` → slot updates to show image thumbnail and file name.
- `UX-FRM-013`: Document attachment removal flow → tap delete icon on uploaded document slot → thumbnail removes and slot reverts to upload button.
- `UX-FRM-014`: Document attachment rename dialog → tap rename icon on document → dialog opens → enter "Passport Front Copy" → label updates.
- `UX-FRM-015`: Unsaved changes guard on form exit → modify Name field → tap Back button → modal asks "Discard Unsaved Changes?" → click "Keep Editing" → form stays intact.
- `UX-FRM-016`: Form submission with validation errors → leave required fields empty and click Save → form auto-scrolls to first invalid field (Name) and focuses it.
- `UX-FRM-017`: Long notes text area auto-grow → type multi-line paragraph into Notes field → text field expands vertically without clipping text.
- `UX-FRM-018`: Currency input formatting → enter "1500000" in Annual Income → displays with comma grouping "15,00,000".
- `UX-FRM-019`: Customer form edit pre-fill journey → open existing customer with 10+ fields → all fields, dropdowns, policy lists, and document slots populate accurately.
- `UX-FRM-020`: Duplicate mobile number warning → enter mobile number existing on another customer → non-blocking warning note appears: "Mobile already assigned to <Other Customer>".
- `UX-FRM-021`: Copy Communication Address to Permanent Address → check "Same as Communication Address" checkbox → Permanent Address text field mirrors Communication Address and disables manual edit.
- `UX-FRM-022`: Uncheck address mirroring → uncheck "Same as Communication Address" → Permanent Address re-enables for independent editing.
- `UX-FRM-023`: Form submission Enter key trigger → on last text field, press Ctrl+Enter / Enter → triggers form validation and submit.
- `UX-FRM-024`: Loading indicator during document processing → attach 10MB image → save form → progress bar indicates document compression and storage.
- `UX-FRM-025`: Clear form reset button → tap Reset Form → confirmation dialog appears → confirm → all form fields reset to blank defaults.

#### `test/usability/search_filter_journey_test.dart` (20 Cases)
- `UX-SCH-001`: Global search by Customer Name → type "Sharma" in search bar → list filters in real-time to customers with "Sharma" in name.
- `UX-SCH-002`: Global search by Customer ID → type "CUST-104" → immediately matches exact customer record.
- `UX-SCH-003`: Global search by Mobile Number → type "98765" → matches customers having "98765" in Mobile 1, 2, 3, or 4.
- `UX-SCH-004`: Global search by Document Tag → type "Aadhaar" in Documents tab → matches customers with an uploaded document named "Aadhaar".
- `UX-SCH-005`: Combined multi-token search → type "John Aadhaar" → matches customer "John Doe" who has an "Aadhaar" document attachment.
- `UX-SCH-006`: Case-insensitive search → type "ramesh", "RAMESH", "Ramesh" → all queries yield identical result set.
- `UX-SCH-007`: Search with leading/trailing whitespaces → type "  Priya   " → trimmed automatically and returns customer "Priya".
- `UX-SCH-008`: Search debounce behavior → type rapid characters ("A", "Al", "Ale", "Alex") → query executes once after 250ms debounce pause.
- `UX-SCH-009`: No match search recovery → type "xyznonexistent" → shows "No customers match your search" with a "Clear Search" button → click button → restores full list.
- `UX-SCH-010`: Search query preservation across tab navigation → search "Anita" → switch to Events tab → switch back to Customers tab → search query "Anita" and filtered results remain active.
- `UX-SCH-011`: Segmented tab switching with active search → search "Pan" → click "Profiles" tab → filters to profiles named Pan; click "Documents" tab → filters to customers with Pan Card docs.
- `UX-SCH-012`: Clear search shortcut → press Escape key while search bar is focused → clears search query text.
- `UX-SCH-013`: Keyboard focus shortcut for search → press Ctrl+F / '/' anywhere on Customer List → search text field receives focus and selects all text.
- `UX-SCH-014`: Keyboard navigation through search results → after search, press Down Arrow → focus moves into first customer card in results.
- `UX-SCH-015`: Search query highlight → search "Kumar" → matching substring "Kumar" in customer names is visually highlighted.
- `UX-SCH-016`: Search filter combined with sorting → search "Singh" and sort by "Name (Z-A)" → matching results order in reverse alphabetical order.
- `UX-SCH-017`: Search across assigned company → search "HDFC ERGO" → matches all customers assigned to HDFC ERGO company.
- `UX-SCH-018`: Special character search safety → type "%", "_", "'", "\", "/" → app handles query gracefully without regex/SQL syntax crash.
- `UX-SCH-019`: Pagination reset on new search → navigate to page 3 of list → type search query → pagination automatically resets to page 1.
- `UX-SCH-020`: Voice search / assistive input compatibility → send input text via assistive channel → triggers search filtering seamlessly.

#### `test/usability/work_task_journey_test.dart` (20 Cases)
- `UX-WRK-001`: End-to-end daily task workflow → select "Company 1" → create task "Collect cheque" (Urgent) → update status to "Under Process" → add remark → mark "Completed" → task counter updates.
- `UX-WRK-002`: Automated carry-forward user experience → create task "Pending KYC verification" with status "Pending" on March 10 → change date to March 11 → task automatically appears on March 11 with "Carried Forward" badge.
- `UX-WRK-003`: Incomplete task carry-forward on login → leave task pending yesterday → log in today → banner announces "3 incomplete tasks carried forward to today".
- `UX-WRK-004`: Completed task exclusion from carry-forward → mark task "Completed" on March 10 → advance date to March 11 → completed task does not carry forward to March 11.
- `UX-WRK-005`: Multi-day carry-forward chain → task created March 1, remains pending through March 5 → task reflects origin date March 1 and carry count 4.
- `UX-WRK-006`: Tab switching and company selection persistence → select Tab 2, Company 7 → switch to Dashboard → switch back to Work tab → Tab 2, Company 7 remains active.
- `UX-WRK-007`: Custom tab rename persistence → rename Tab 1 to "Health Insurance" → restart app → Tab 1 header displays "Health Insurance".
- `UX-WRK-008`: Company rename cascade in work tracking → rename "Company 2" to "Star Health" → all task history under Company 2 shows "Star Health".
- `UX-WRK-009`: Task priority filter UX → filter tasks by "Urgent" → table displays only Urgent priority tasks.
- `UX-WRK-010`: Task assignment method icons → assign task via "WhatsApp" → row renders WhatsApp icon; "Call" → phone icon; "In Person" → user icon.
- `UX-WRK-011`: Date picker navigation UX → click date display → pick arbitrary date 2 months prior → loads historical task log for that exact date.
- `UX-WRK-012`: "Show All History" toggle UX → enable "Show All History" → task table combines tasks from all dates chronologically.
- `UX-WRK-013`: Inline task status change speed → click status dropdown on table row → select "Completed" → row updates instantly with optimistic UI response.
- `UX-WRK-014`: Task remarks editing flow → double-click remarks cell on table → inline editor opens → enter new remarks and press Enter → saves.
- `UX-WRK-015`: Keyboard shortcuts for task creation → on Work Management screen, press Ctrl+N → opens "New Work Task" modal.
- `UX-WRK-016`: Task table column sorting → click "Priority" column header → sorts rows: Urgent → Important → Normal.
- `UX-WRK-017`: Batch task status update → select multiple task checkboxes → click "Mark All Completed" → all selected tasks update to Completed.
- `UX-WRK-018`: Delete task undo snackbar → delete task → snackbar shows "Task deleted" with "Undo" button → tap "Undo" → task restored.
- `UX-WRK-019`: Task description character limit UX → type 500 characters into task description → counter indicates remaining budget without crashing.
- `UX-WRK-020`: High-density table responsiveness → view task table on small desktop screen (1024x768) → horizontal scrollbar enables smooth panning without column clipping.

#### `test/usability/performance_table_test.dart` (20 Cases)
- `UX-PRF-001`: Monthly KPI entry journey → select year 2026, month March → enter Box 1 metrics, Box 2 working days, Box 3 matrix values → values save automatically in background.
- `UX-PRF-002`: Topic table daily logging flow → click "+ Add Day Row" → today's date row created → enter values across 13 topic columns → press Tab to advance cell by cell.
- `UX-PRF-003`: Universal topic header rename cascade → rename "Topic 1" to "Endowment Policies" in March 2026 → switch to April 2026 → "Topic 1" displays "Endowment Policies".
- `UX-PRF-004`: Universal Box 3 column header rename cascade → rename "Column 6" to "Motor General" → persists across all months and years.
- `UX-PRF-005`: Universal Box 3 row header rename cascade → rename "Row 1" to "Weekly Target" → persists across all months and years.
- `UX-PRF-006`: Performance cell numeric-only input enforcement → try typing alphabetic letters into Box 1 "Earned" field → non-numeric characters blocked.
- `UX-PRF-007`: Arrow key navigation in 4x7 matrix → focus cell (1,1) in Box 3 → press Right Arrow → moves focus to (1,2) → press Down Arrow → moves to (2,2).
- `UX-PRF-008`: Auto-calculation of percentage column → enter Target "100" and Achieved "75" in Box 3 → Percentage column auto-populates "75%".
- `UX-PRF-009`: Auto-calculation of Box 4 balance → enter Target "500000" and Achieved "350000" → Balance auto-calculates "150000".
- `UX-PRF-010`: Month-to-month quick navigation → click "<" and ">" arrows next to month picker → steps seamlessly through consecutive months.
- `UX-PRF-011`: Year jump navigation → select 2024 from year dropdown → loads historical 2024 performance records.
- `UX-PRF-012`: Topic row date picker adjustment → click date cell in topic table → select past date → row date updates and re-sorts table chronologically.
- `UX-PRF-013`: Duplicate date in topic rows allowed → add two rows for same date (e.g. morning/evening sessions) → both rows persist independently.
- `UX-PRF-014`: Delete topic row confirmation → tap delete icon on topic row → confirmation toast confirms deletion.
- `UX-PRF-015`: Copy previous month headers button → start blank month → click "Copy Last Month Structure" → applies column layouts.
- `UX-PRF-016`: Large topic table vertical scrolling → add 31 rows (full month) → table header sticks to top while rows scroll smoothly.
- `UX-PRF-017`: Horizontal table scroll with frozen date column → scroll topic table horizontally → Date column remains pinned on left.
- `UX-PRF-018`: Performance export to PDF user flow → click Export PDF → PDF preview renders all 4 boxes and 14-column topic table cleanly on A4 landscape.
- `UX-PRF-019`: Rapid cell edits persistence under debounce → type values rapidly into 10 consecutive cells → all 10 values persist without write race condition.
- `UX-PRF-020`: Unsaved data loss prevention on unexpected screen pop → edit cell and immediately switch tab → auto-save flushes pending edits.

#### `test/usability/backup_restore_journey_test.dart` (20 Cases)
- `UX-BAK-001`: Full backup and restore round-trip journey → create 3 customers with photo attachments, 5 tasks, 2 marketing leads → export ZIP backup to `backup.zip` → clear all data (sandbox) → import `backup.zip` → verify all customers, photos, tasks, and leads restored bit-for-bit.
- `UX-BAK-002`: Backup export PIN protection journey → initiate export → prompt asks for PIN → enter wrong PIN → blocked → enter correct PIN → export proceeds.
- `UX-BAK-003`: Backup file save location picker → trigger export → file picker prompts user for save directory and default filename `insurance_crm_backup_<timestamp>.zip`.
- `UX-BAK-004`: Cancel file picker on export → open save dialog → click Cancel → export cancels cleanly without error snackbar.
- `UX-BAK-005`: Restore overwrite warning acceptance flow → click Import Data → read overwrite warning → click "Replace All Data" → select valid backup file → completes restoration and refreshes UI.
- `UX-BAK-006`: Restore overwrite warning cancellation → click Import Data → click "Cancel" in warning dialog → no data altered.
- `UX-BAK-007`: Legacy JSON backup import compatibility → select older version 1 `.json` backup file containing base64 images → imports and converts documents to relative file storage.
- `UX-BAK-008`: Large backup archive handling (50MB+ with 100+ documents) → import large ZIP archive → progress indicator reflects unpacking progress without UI freeze.
- `UX-BAK-009`: Corrupted ZIP archive recovery → select invalid/corrupt `.zip` file → error dialog explains "Archive corrupted" → existing database remains completely intact and unaltered.
- `UX-BAK-010`: Missing `backup_data.json` inside ZIP error → select ZIP containing only loose images → error message "Invalid backup archive: missing database JSON".
- `UX-BAK-011`: Backup includes custom settings and tab names → rename work tabs → export backup → reset database → import backup → custom tab names restored.
- `UX-BAK-012`: Backup includes universal performance headers → customize topic headers → export backup → restore on fresh database → customized topic headers restored.
- `UX-BAK-013`: Document physical file isolation on restore → restore backup with 5 documents → documents unpacked directly to application documents directory with relative paths.
- `UX-BAK-014`: Sandbox Seed Dummy Data journey → open Developer Tools → click "Seed Dummy Data" → confirm warning → database populates 5 dummy customers, tasks, leads, notes, and performance records.
- `UX-BAK-015`: Sandbox Clear All Data journey → open Developer Tools → click "Clear All Data" → confirm warning → database and local document files completely erased.
- `UX-BAK-016`: Provider reactivity after restore → complete restore while viewing Customer List → list immediately reloads to show imported customers without manual app restart.
- `UX-BAK-017`: Developer tools unlock 5-tap gesture UX → tap version footer 1, 2, 3, 4 times → toasts show "Tap N more times" → 5th tap unlocks tools.
- `UX-BAK-018`: Developer tools hide toggle → when unlocked, tap "Hide" on sandbox card → sandbox tools hide and tap counter resets.
- `UX-BAK-019`: Export filename sanitization → backup export generates timestamped filename without illegal filesystem characters.
- `UX-BAK-020`: Cross-platform backup portability → export backup on Windows → import identical `.zip` file on Linux/Android → seamless data restoration.

#### `test/usability/keyboard_cycling_test.dart` (22 Cases)
- `UX-KEY-001`: `KeyCycleDropdown` closed state letter cycling → focus dropdown with items ["Apple", "Avocado", "Banana", "Cherry"] → press 'a' → selects "Apple" → press 'a' again → cycles to "Avocado" → press 'a' again → cycles to "Apple".
- `UX-KEY-002`: `KeyCycleDropdown` open overlay letter cycling → tap dropdown to open overlay menu → press 'c' → cursor jumps to "Cherry" → press Enter → selects "Cherry" and closes overlay.
- `UX-KEY-003`: `KeyCycleDropdown` jump to differing initial letters → focus dropdown → press 'b' → jumps to "Banana" → press 'c' → jumps to "Cherry".
- `UX-KEY-004`: `KeyCycleDropdown` case-insensitive letter cycling → press 'A' (shift+a) or 'a' → cycles matching items identically.
- `UX-KEY-005`: `KeyCycleDropdown` letter with no matching item → press 'z' when no items start with 'z' → selection remains unchanged and no error thrown.
- `UX-KEY-006`: `KeyCycleDropdown` wrap-around cycling → 3 items starting with 'M' ("Max", "Met", "Mutual") → press 'm' 4 times → cycles: Max → Met → Mutual → Max.
- `UX-KEY-007`: `KeyCycleDropdown` numeric key cycling → dropdown with numbers ["10%", "15%", "20%"] → press '1' → cycles between "10%" and "15%".
- `UX-KEY-008`: `KeyCycleDropdown` Escape key behavior → open dropdown overlay → press Escape → closes overlay without altering previous selection.
- `UX-KEY-009`: `KeyCycleDropdown` Tab navigation out → focus dropdown → select value via letter cycling → press Tab → focus moves cleanly to next form field.
- `UX-KEY-010`: `KeyCycleDropdown` Arrow Up/Down navigation → open dropdown → press Down Arrow → moves selection to next consecutive item.
- `UX-KEY-011`: Segmented date input Tab advance → in DD segment, press Tab → advances to MM segment → press Tab → advances to YYYY segment.
- `UX-KEY-012`: Segmented date input Shift+Tab reverse → in YYYY segment, press Shift+Tab → returns focus to MM segment.
- `UX-KEY-013`: Segmented date numeric-only filter → press letter keys ('a', 'x') in date segment → keystrokes ignored.
- `UX-KEY-014`: Segmented date Arrow Left/Right segment hopping → press Right Arrow on last character of DD → jumps cursor to MM segment.
- `UX-KEY-015`: Form-wide keyboard submission shortcut → inside form, press Ctrl+S / Cmd+S → triggers save action.
- `UX-KEY-016`: Dialog keyboard submission shortcut → inside modal dialog, press Enter while focused on input → submits dialog.
- `UX-KEY-017`: Modal Escape key dismiss → inside any dialog/modal, press Escape key → dismisses dialog.
- `UX-KEY-018`: Table keyboard navigation → on Customer table, press Page Down / Page Up → scrolls table by page increment.
- `UX-KEY-019`: Search bar shortcut Ctrl+K → press Ctrl+K anywhere in application → focuses global search bar.
- `UX-KEY-020`: Accessibility focus traversal order → inspect focus node order on complex screens → follows strict left-to-right, top-to-bottom flow.
- `UX-KEY-021`: Screen reader announcements on dropdown change → cycle item via letter key → semantics announces "Selected <ItemName>".
- `UX-KEY-022`: Focus indicator visual styling → verify focused widgets → distinct blue focus outline (2px) rendered for accessibility.

---

### 5.3 Suite C: Backend & Integration Tests (~260 Cases)

#### `test/integration/database_service_test.dart` (40 Cases)
- `INT-DBS-001`: Database initialization → call `DatabaseService.init()` in temp dir → open Isar with all 7 schemas → succeeds without error.
- `INT-DBS-002`: Default company seeding on first launch → verify `Company` collection on clean DB → Tab 1 (index 0) has 15 companies, Tab 2 has 15, Tab 3 has 15 (45 total seeded).
- `INT-DBS-003`: Customer creation and auto-increment ID → save customer "Aarav Patel" → record receives valid auto-incremented integer ID and UUID.
- `INT-DBS-004`: Customer UUID generation → save customer → UUID is non-null, valid v4 format, and unique.
- `INT-DBS-005`: Customer update timestamp update → update customer field → `updatedAt` updates to current timestamp.
- `INT-DBS-006`: Customer soft delete → call `deleteCustomer(id)` → `isDeleted` becomes true; record remains in Isar.
- `INT-DBS-007`: Active customer query excludes soft-deleted → insert 3 customers, soft delete 1 → `getCustomers()` returns exactly 2 customers.
- `INT-DBS-008`: Customer hard delete → call hard delete → record permanently removed from Isar collection.
- `INT-DBS-009`: Insurance Company 15 limit enforcement → insert 15 insurance companies → attempt to insert 16th → throws `Exception('Maximum limit of 15 insurance companies reached.')`.
- `INT-DBS-010`: Insurance Company duplicate name check → insert "LIC of India" → attempt insert "lic of india" (case-insensitive) → does not create duplicate.
- `INT-DBS-011`: Insurance Company restore on re-add → soft delete "HDFC Life" → call `saveInsuranceCompany('HDFC Life')` → un-deletes existing record and updates timestamp.
- `INT-DBS-012`: Insurance Company cascade rename across customer policies → create customer with `selfCompany = 'Star Health'` and `fatherCompany = 'Star Health'` → call `renameInsuranceCompany('Star Health', 'Star Health Allied')` → customer record updates both fields to 'Star Health Allied'.
- `INT-DBS-013`: Insurance Company cascade rename all 5 policy relations → customer has self, father, mother, spouse, and children company set to 'Bajaj' → rename 'Bajaj' to 'Bajaj Allianz' → all 5 fields update in transaction.
- `INT-DBS-014`: Insurance Company rename collision prevention → attempt to rename "Company A" to "Company B" when "Company B" already exists → throws `Exception('An insurance company with this name already exists.')`.
- `INT-DBS-015`: Insurance Company soft delete → call `deleteInsuranceCompany(id)` → `isDeleted` set to true.
- `INT-DBS-016`: Work task creation → insert task for Company 1 on 2026-03-15 → task persists with valid UUID and company foreign key.
- `INT-DBS-017`: Work task carry-forward logic execution → insert pending task on March 10 → call `carryForwardIncompleteTasks(DateTime(2026, 3, 11))` → task `workDate` updates to March 11, `carryForwardRequired` is true, `carryForwardDate` recorded.
- `INT-DBS-018`: Completed work task ignored by carry-forward → task with status 'Completed' on March 10 → run carry forward to March 11 → task `workDate` remains March 10.
- `INT-DBS-019`: Work task query by company and date → insert tasks across multiple companies and dates → `getTasksForCompany(companyId, date)` filters accurately.
- `INT-DBS-020`: Work task query all history → call `getTasksForCompany(companyId, null)` → returns all historical tasks for company sorted by date descending.
- `INT-DBS-021`: Marketing lead CRUD → insert lead with 2 visits → lead and embedded visit objects persist accurately.
- `INT-DBS-022`: Marketing visit multi-photo persistence → add visit with 3 photo paths → `attachedPhotos` list stores all 3 paths.
- `INT-DBS-023`: Performance record creation and retrieval → save record for year 2026, month 3 → `getPerformanceRecord(2026, 3)` returns matching record.
- `INT-DBS-024`: Performance universal headers persistence → save headers in March 2026 → call `getLatestPerformanceHeaders()` in April 2026 → retrieves saved universal headers.
- `INT-DBS-025`: Update all performance headers across records → call `updateAllPerformanceHeaders(topicHeaders: newHeaders)` → all existing performance records update topic headers in single transaction.
- `INT-DBS-026`: Daily notes CRUD → insert note for target date with category 'Marketing' → retrieves note accurately.
- `INT-DBS-027`: Daily note completion toggle → call toggle completion → `isCompleted` flips and updates DB.
- `INT-DBS-028`: Daily note delete → call delete note → note removed from Isar.
- `INT-DBS-029`: Seed Dummy Data execution → call `seedDummyData()` → clears DB and seeds exactly 5 customers, 5 tasks, 5 leads, 5 notes, and 1 performance record.
- `INT-DBS-030`: Clear All Data execution → call `clearAllData()` → all 7 collections verified empty (`count() == 0`).
- `INT-DBS-031`: Customer search query engine: Name match → search "John" → matches "John Doe".
- `INT-DBS-032`: Customer search query engine: Customer ID match → search "CUST-005" → matches customer with customerId "CUST-005".
- `INT-DBS-033`: Customer search query engine: Mobile match → search "987654" → matches customer with mobile "9876543210".
- `INT-DBS-034`: Customer search query engine: Document name match → customer has document "Income Tax Return" → search "Income Tax" → customer returned in results.
- `INT-DBS-035`: Customer search query engine: Plan product name match → customer has plan "Jeevan Labh" → search "Jeevan" → customer returned.
- `INT-DBS-036`: Work company tab partition → query `getCompaniesForTab(0)` → returns 15 companies; `getCompaniesForTab(1)` returns 15 companies.
- `INT-DBS-037`: Work company rename → rename company in Tab 1 from "Company 1" to "LIC" → `getCompaniesForTab(0)` reflects "LIC".
- `INT-DBS-038`: Embedded plan items serialization → customer with 4 `CustomerPlanItem` records → all 4 plans retrieve with exact sum assured, premium, and rider values.
- `INT-DBS-039`: Embedded reminder items serialization → customer with 5 `CustomerReminderItem` records → all 5 retrieve with exact dates and notes.
- `INT-DBS-040`: Transaction atomicity on error → attempt batch write that fails midway → transaction aborts and database rolls back to previous state.

#### `test/integration/security_service_test.dart` (20 Cases)
- `INT-SEC-001`: SecurityService instance creation → create service with mock storage → succeeds.
- `INT-SEC-002`: `isPinSet` false on empty storage → storage has no PIN hash → `isPinSet()` returns false.
- `INT-SEC-003`: `setPin` hashes with SHA-256 → call `setPin('1234')` → storage receives SHA-256 hash string of '1234'.
- `INT-SEC-004`: `isPinSet` true after `setPin` → call `setPin('1234')` → `isPinSet()` returns true.
- `INT-SEC-005`: `verifyPin` valid PIN → call `verifyPin('1234')` → returns true.
- `INT-SEC-006`: `verifyPin` invalid PIN → call `verifyPin('9999')` → returns false.
- `INT-SEC-007`: `verifyPin` empty storage → call `verifyPin('1234')` when no PIN set → returns false.
- `INT-SEC-008`: `clearPin` removes hash → call `clearPin()` → storage key deleted and `isPinSet()` returns false.
- `INT-SEC-009`: PIN hash collision resistance → hash of '1234' does not match hash of '1235' or '4321'.
- `INT-SEC-010`: Empty PIN handling → verify behavior with empty string → hash stored appropriately.
- `INT-SEC-011`: Long PIN support → set 8-digit PIN "12345678" → verify with "12345678" returns true; "12345679" returns false.
- `INT-SEC-012`: `getAutoLockTimeoutMinutes` default value → no timeout in storage → returns default 5 minutes.
- `INT-SEC-013`: `setAutoLockTimeoutMinutes` persists value → set timeout to 15 → storage stores "15" and `getAutoLockTimeoutMinutes()` returns 15.
- `INT-SEC-014`: Auto-lock disabled value (0) → set timeout to 0 → returns 0.
- `INT-SEC-015`: Secure storage exception handling → simulate storage read exception → handles gracefully without unhandled crash.
- `INT-SEC-016`: SHA-256 determinism → multiple hashes of same input produce identical digest strings across runs.
- `INT-SEC-017`: AuthNotifier state machine uninitialized → notifier boots → checks PIN status → transitions to setupRequired.
- `INT-SEC-018`: AuthNotifier state machine locked → PIN set in storage → notifier boots → status is locked.
- `INT-SEC-019`: AuthNotifier unlock flow → call `unlock('1234')` with correct PIN → status transitions to unlocked and carry-forward triggers.
- `INT-SEC-020`: AuthNotifier lock flow → call `lock()` → status transitions to locked.

#### `test/integration/backup_roundtrip_test.dart` (30 Cases)
- `INT-BAK-001`: Export ZIP backup structure → create sample DB records → call `exportZipBackup()` → returns valid non-empty byte list starting with ZIP magic bytes `[0x50, 0x4B, 0x03, 0x04]`.
- `INT-BAK-002`: ZIP archive contents verification → decode exported ZIP bytes → archive contains `backup_data.json` at root.
- `INT-BAK-003`: `backup_data.json` schema validation → parse JSON from ZIP → JSON contains keys: `version: 2`, `exportedAt`, `customers`, `companies`, `tasks`, `marketingLeads`, `performanceRecords`.
- `INT-BAK-004`: Physical document files packaging in ZIP → create customer with attached document `photo.jpg` (10KB file) → export ZIP → archive contains file entry `customer_documents/photo.jpg` with matching byte content.
- `INT-BAK-005`: Multiple documents packaging → create 5 documents across 3 customers → export ZIP → archive contains all 5 file entries inside `customer_documents/`.
- `INT-BAK-006`: Import ZIP backup restores all customer records → clear DB → call `importZipBackup(zipFile)` → all customers restored with exact UUIDs, customerIds, names, and embedded plans.
- `INT-BAK-007`: Import ZIP backup restores physical document files → clear DB and delete docs dir → import ZIP → physical document files recreated on disk inside application documents directory.
- `INT-BAK-008`: Import ZIP backup restores all company records → verify `Company` collection after import → all 45 companies with custom names and tab indexes restored.
- `INT-BAK-009`: Import ZIP backup restores all work tasks → verify `WorkTask` collection after import → all tasks restored with exact priorities, statuses, and carry-forward history.
- `INT-BAK-010`: Import ZIP backup restores marketing leads and visits → verify `MarketingLead` collection → all leads and embedded visit arrays restored.
- `INT-BAK-011`: Import ZIP backup restores performance records and topic rows → verify `PerformanceRecord` collection → Box 1-4 metrics and 14-column topic rows restored.
- `INT-BAK-012`: Import ZIP backup atomic transaction rollback on failure → simulate corrupt JSON in ZIP → import fails → database does not partially clear; original records preserved.
- `INT-BAK-013`: Legacy JSON import support → import legacy JSON backup file with base64 `documentFiles` map → decodes base64 strings into physical disk files and restores DB records.
- `INT-BAK-014`: Special character serialization in JSON → customer with quotes, newlines, emojis, and non-ASCII characters in notes → export and import → characters preserved without corruption.
- `INT-BAK-015`: Date serialization ISO-8601 round-trip → DateTime objects serialized to ISO-8601 strings → restored DateTime objects equal original millisecond timestamps.
- `INT-BAK-016`: Nullable fields serialization → records with null optional fields → export and import → nulls preserved accurately without string conversion ("null").
- `INT-BAK-017`: Document cleanup on restore → disk has orphan files prior to import → import ZIP → orphan files wiped and only archive documents remain.
- `INT-BAK-018`: Large document backup (>20MB image files) → export and import archive with high-resolution images → compression and extraction complete successfully.
- `INT-BAK-019`: Empty database backup → export ZIP on empty DB → produces valid ZIP with empty JSON arrays; imports cleanly on fresh DB.
- `INT-BAK-020`: Backup versioning tag → verify exported JSON has `version: 2` tag for forward compatibility.
- `INT-BAK-021`: Customer embedded reminders serialization → verify `CustomerReminderItem` list in JSON → reminder titles, dates, and notes preserved.
- `INT-BAK-022`: Customer embedded references serialization → verify `CustomerReferenceItem` list in JSON → friend names, mobiles, and ages preserved.
- `INT-BAK-023`: Performance universal headers preservation across backup → customize universal headers → export and import → headers retained.
- `INT-BAK-024`: Work task carry-forward dates serialization → verify `carryForwardDate` field in task JSON → preserves historical dates.
- `INT-BAK-025`: Marketing lead multi-photo serialization → verify `attachedPhotos` list in lead JSON → all photo paths preserved.
- `INT-BAK-026`: ZIP encoder memory footprint → export backup with 100 records → memory usage remains within bounds.
- `INT-BAK-027`: Corrupted ZIP header detection → pass random non-ZIP bytes to `importZipBackup` → throws `Exception('Invalid or corrupted backup archive')`.
- `INT-BAK-028`: Nested directory traversal security check → archive containing `../../malicious.sh` filename → sanitized safely within customer documents directory.
- `INT-BAK-029`: Restore overwrites existing duplicate UUIDs cleanly → import backup containing existing UUIDs → overwrites without primary key collision.
- `INT-BAK-030`: Fast import execution benchmark → import backup with 500 records → completes within 2000ms budget.

#### `test/integration/pdf_export_bytes_test.dart` (20 Cases)
- `INT-PDF-001`: Dashboard PDF generation → call `DashboardExportService.shareDashboardPdf(items)` → generates valid PDF byte payload starting with `%PDF-`.
- `INT-PDF-002`: Dashboard PDF header content → inspect generated PDF elements → contains title "JJ CRM", subtitle "Tomorrow's Work & Event Summary Report", and formatted report date.
- `INT-PDF-003`: Dashboard PDF metrics table → pass 3 reminders, 2 tasks, 1 marketing lead → PDF summary table reflects Total: 6, Reminders: 3, Tasks: 2, Marketing: 1.
- `INT-PDF-004`: Dashboard PDF schedule table content → pass scheduled events → PDF table renders rows with Category, Title, Details, and Status.
- `INT-PDF-005`: Dashboard PDF empty schedule state → pass empty item list → PDF renders italicized "No events or follow-ups scheduled for today.".
- `INT-PDF-006`: Dashboard PDF Day Task Notes section → pass 3 daily notes → PDF renders Notes table with Status (`[X]` / `[ ]`), Category, and Details.
- `INT-PDF-007`: Customer Profile PDF generation → call `DashboardExportService.shareCustomerProfilePdf(customer)` → generates valid PDF bytes.
- `INT-PDF-008`: Customer Profile PDF header box → inspect profile PDF → contains "JJ CRM - CUSTOMER PROFILE", customer name uppercase, customer ID, and date.
- `INT-PDF-009`: Customer Profile PDF personal details grid → customer with full personal info → PDF grid renders DOB, Mobile, Email, Marital Status, PAN, Aadhaar, Income.
- `INT-PDF-010`: Customer Profile PDF insurance policies table → customer with 3 policies → PDF renders 3-row table with Product Name, Mode, Sum Assured, Premium, and Rider.
- `INT-PDF-011`: Customer Profile PDF nominee information → customer with nominee → PDF renders Nominee Name, Relationship, Mobile, PAN, and Appointee.
- `INT-PDF-012`: Customer Profile PDF health & accident cover → customer with PA cover → PDF renders Personal Accident cover status and incident date.
- `INT-PDF-013`: Customer Profile PDF reminders section → customer with reminders → PDF renders scheduled reminder dates and notes.
- `INT-PDF-014`: PDF multi-page pagination → customer with extensive policies and 5 reminders → PDF generates clean 2-page document with footer page counters ("Page 1 of 2").
- `INT-PDF-015`: PDF asset logo embedding → verify PDF image elements → application logo embedded in header without resolution degradation.
- `INT-PDF-016`: PDF filename sanitization → customer name "Dr. John O'Connor / MD" → generated PDF filename sanitized to `Customer_Profile_Dr_John_OConnor__MD_<ID>.pdf`.
- `INT-PDF-017`: Save PDF to desktop downloads directory → mock file system → `saveAndDownloadPdf` saves bytes to downloads directory and triggers process open.
- `INT-PDF-018`: Special character rendering in PDF → customer name with Indian rupee symbol (₹) and regional scripts → PDF renders without glyph error.
- `INT-PDF-019`: PDF table border styling → verify table borders → styled with clean grey borders and header background tints.
- `INT-PDF-020`: Headless PDF generation performance → generate 50-page customer report → completes within 1500ms budget.

#### `test/integration/events_engine_test.dart` (30 Cases)
- `INT-EVT-001`: Birthday calculation within 30-day window → customer DOB on March 20, injected clock March 15 → `upcomingEventsProvider` includes birthday "In 5 days".
- `INT-EVT-002`: Birthday today calculation → customer DOB month/day matches current date → dateText is "Today" and diff is 0.
- `INT-EVT-003`: Birthday tomorrow calculation → customer DOB on March 16, injected clock March 15 → dateText is "Tomorrow" and diff is 1.
- `INT-EVT-004`: Birthday outside 30-day window excluded → customer DOB on May 25, clock March 15 (diff = 71 days) → event excluded from list.
- `INT-EVT-005`: Birthday past this year calculates for next year → customer DOB on January 10, clock March 15 → diff is calculated to next January (~299 days, excluded from 30-day window).
- `INT-EVT-006`: Child birthday calculation → customer has `childrenDOBs = [March 22]` → includes event "Child #1 turning 6 years old".
- `INT-EVT-007`: Multiple children birthdays calculation → customer has 3 children with differing DOBs → each within 30 days generates distinct upcoming event.
- `INT-EVT-008`: Wedding anniversary within 30-day window → customer anniversary on March 25, clock March 15 → includes anniversary "In 10 days" with years milestone.
- `INT-EVT-009`: Personal accident anniversary calculation → customer PA date March 18 → includes "Personal Accident Incident: <Name> (2 Yr Anniversary)".
- `INT-EVT-010`: Scheduled reminder 1 calculation → `reminderDate1` on March 28 with note "Review term plan" → includes reminder event with note text.
- `INT-EVT-011`: Scheduled reminders 1–5 calculation → customer with 5 reminder slots populated → all active reminders within 30 days included.
- `INT-EVT-012`: Embedded reminders list calculation → customer uses `reminders` array → calculates upcoming events for all array entries.
- `INT-EVT-013`: Marketing visit within 30-day window → lead visit scheduled on March 19 → includes marketing event with visit time and status.
- `INT-EVT-014`: Events chronological sort order → generate mix of 10 birthdays, anniversaries, and reminders → `upcomingEventsProvider` sorts strictly ascending by date.
- `INT-EVT-015`: Leap year birthday on non-leap year → customer born on Feb 29 → calculated on March 1 in non-leap years without crash.
- `INT-EVT-016`: Year boundary transition (December to January) → clock December 28, customer birthday January 5 → correctly calculates diff of 8 days into next year.
- `INT-EVT-017`: Tomorrow summary calculation: Reminders → reminder set for tomorrow's exact date → `todaySummaryEventsProvider` includes item with category 'Reminder'.
- `INT-EVT-018`: Tomorrow summary calculation: Work Tasks → task scheduled for tomorrow → `todaySummaryEventsProvider` includes item with category 'Work Task'.
- `INT-EVT-019`: Tomorrow summary calculation: Marketing Visits → visit scheduled for tomorrow → `todaySummaryEventsProvider` includes item with category 'Marketing'.
- `INT-EVT-020`: Tomorrow summary carry-forward trigger → reading `todaySummaryEventsProvider` automatically triggers carry forward of pending tasks to tomorrow's date.
- `INT-EVT-021`: Completed tasks in tomorrow summary → completed task for tomorrow → item marked `isCompleted = true`.
- `INT-EVT-022`: Customer soft-delete exclusion from events → soft-delete customer → customer birthdays and reminders immediately disappear from upcoming events.
- `INT-EVT-023`: Marketing lead soft-delete exclusion → soft-delete lead → lead visits disappear from upcoming events.
- `INT-EVT-024`: Empty database events result → zero records in DB → `upcomingEventsProvider` and `todaySummaryEventsProvider` return empty lists (`[]`).
- `INT-EVT-025`: Age milestone calculation accuracy → customer born 1990-03-20, clock 2026-03-15 → details string says "Turning 36 years old".
- `INT-EVT-026`: Wedding anniversary years milestone accuracy → married 2016-03-25, clock 2026-03-15 → details string says "10 Wedding Anniversary".
- `INT-EVT-027`: Provider reactivity on customer update → modify customer DOB in DB → `upcomingEventsProvider` emits updated event list automatically.
- `INT-EVT-028`: Provider reactivity on task addition → add task for tomorrow → `todaySummaryEventsProvider` emits updated summary list.
- `INT-EVT-029`: Provider reactivity on marketing visit update → update visit date → events provider updates.
- `INT-EVT-030`: Performance under 1000 customers → calculate upcoming events for 1000 customer records → computation completes under 50ms.

#### `test/integration/settings_and_providers_test.dart` (30 Cases)
- `INT-SET-001`: `dateFormatPatternProvider` default pattern → initial state is `'dd/MM/yyyy'`.
- `INT-SET-002`: `dateFormatPatternProvider` set pattern → call `setPattern('yyyy-MM-dd')` → state updates to `'yyyy-MM-dd'` and persists in secure storage.
- `INT-SET-003`: `appDateFormatterProvider` reactivity → update date pattern → `appDateFormatterProvider` emits new `DateFormat` instance with updated pattern.
- `INT-SET-004`: `parseDateString` DD/MM/YYYY parser → parse "15/05/1990" with pattern 'dd/MM/yyyy' → returns `DateTime(1990, 5, 15)`.
- `INT-SET-005`: `parseDateString` MM/DD/YYYY parser → parse "05/15/1990" with pattern 'MM/dd/yyyy' → returns `DateTime(1990, 5, 15)`.
- `INT-SET-006`: `parseDateString` YYYY-MM-DD parser → parse "1990-05-15" with pattern 'yyyy-MM-dd' → returns `DateTime(1990, 5, 15)`.
- `INT-SET-007`: `parseDateString` invalid day rejection → parse "32/01/1990" → returns null.
- `INT-SET-008`: `parseDateString` invalid month rejection → parse "15/13/1990" → returns null.
- `INT-SET-009`: `parseDateString` out-of-range year rejection → parse "15/05/1850" (year < 1900) → returns null.
- `INT-SET-010`: `parseDateString` non-numeric characters stripping → parse "15-05-1990" or "15.05.1990" → parses digits and returns valid DateTime.
- `INT-SET-011`: `workTabNamesProvider` default tab titles → initial state is `['Tab 1', 'Tab 2', 'Tab 3']`.
- `INT-SET-012`: `workTabNamesProvider` rename tab → call `renameTab(0, 'Life Insurance')` → state updates and persists key `work_tab_title_0`.
- `INT-SET-013`: `workTabNamesProvider` empty name ignored → call `renameTab(1, '   ')` → rename ignored and previous title retained.
- `INT-SET-014`: `workTabNamesProvider` invalid index ignored → call `renameTab(5, 'Test')` → no exception thrown; state unaffected.
- `INT-SET-015`: `searchQueryProvider` state updates → update search query → emits new string to listeners.
- `INT-SET-016`: `customerSearchTabProvider` state switching → update tab between 'All', 'Profiles', 'Documents' → emits new active tab.
- `INT-SET-017`: `navigationTabIndexProvider` state switching → update index 0..5 → shell switches active screen.
- `INT-SET-018`: `customerPageProvider` pagination state → change page number → customer query updates page slice.
- `INT-SET-019`: `customerListProvider` stream reactivity → insert customer into Isar → `customerListProvider` automatically yields updated list via `watchLazy()`.
- `INT-SET-020`: `customerListProvider` search filtering reactivity → update `searchQueryProvider` to "Amit" → stream immediately yields filtered results.
- `INT-SET-021`: `taskListProvider` stream reactivity → insert work task for company → `taskListProvider` emits updated task list.
- `INT-SET-022`: `taskListProvider` date change reactivity → change `selectedDateProvider` → `taskListProvider` emits tasks for new date.
- `INT-SET-023`: `todayTasksProvider` stream reactivity → insert task for today → `todayTasksProvider` yields updated list.
- `INT-SET-024`: `marketingListProvider` stream reactivity → insert marketing lead → `marketingListProvider` emits updated list.
- `INT-SET-025`: `performanceRecordProvider` family caching → read provider for key "2026_3" → returns notifier for 2026 month 3; read "2026_4" returns separate notifier.
- `INT-SET-026`: `performanceRecordProvider` updateBox1 → call `updateBox1(earned: "45000")` → state updates and saves to Isar.
- `INT-SET-027`: `performanceRecordProvider` updateBox3Field → call `updateBox3Field('box3TargetCol1', '50')` → field updates and saves.
- `INT-SET-028`: `todayNotesProvider` and `tomorrowNotesProvider` separation → insert note for today and note for tomorrow → providers return respective records without leakage.
- `INT-SET-029`: `companiesForTabProvider` family query → read provider with family arg 0 → returns Tab 1 companies; family arg 1 returns Tab 2 companies.
- `INT-SET-030`: `selectedCompanyIdProvider` null fallback → when company ID is null, `taskListProvider` defaults to first company in active tab.

#### `test/integration/sync_service_test.dart` (30 Cases)
- `INT-SYN-001`: SyncService instantiation → create service with mock database → initialized in stopped state.
- `INT-SYN-002`: Server port configuration → inspect default server port → configured to 8080 (or ephemeral fallback).
- `INT-SYN-003`: Server start state → start server → `isServerRunning` becomes true and `serverPort` is assigned.
- `INT-SYN-004`: Server stop state → stop server → `isServerRunning` becomes false.
- `INT-SYN-005`: Local IP address resolution → call `getLocalIpAddresses()` → returns list of non-loopback IPv4 addresses.
- `INT-SYN-006`: Bonsoir mDNS service registration config → start advertising → registers service type `_shinecraft-crm._tcp`.
- `INT-SYN-007`: Discovery state toggle → call `startDiscovery()` → `isDiscovering` becomes true; call `stopDiscovery()` → `isDiscovering` becomes false.
- `INT-SYN-008`: Discovered device list management → mock discovery event of peer "JJ-CRM-Node2" at "192.168.1.20:8080" → device added to `discoveredDevices`.
- `INT-SYN-009`: Discovered device duplicate prevention → receive multiple discovery events from same host/port → device listed exactly once.
- `INT-SYN-010`: Discovered device loss handling → peer goes offline → device removed from `discoveredDevices`.
- `INT-SYN-011`: Data sync payload compilation → compile sync payload → JSON includes all modified customers, companies, tasks, leads with timestamps.
- `INT-SYN-012`: Conflict resolution "Last Write Wins" (Newer remote record) → local customer `updatedAt = 10:00`, remote customer `updatedAt = 10:30` (same UUID) → remote record overwrites local.
- `INT-SYN-013`: Conflict resolution "Last Write Wins" (Newer local record) → local customer `updatedAt = 11:00`, remote customer `updatedAt = 10:30` → local record preserved; remote discarded.
- `INT-SYN-014`: Conflict resolution for non-existing remote record → remote has customer UUID not in local DB → customer inserted into local DB.
- `INT-SYN-015`: Conflict resolution for soft-deleted record → remote customer has `isDeleted = true` with newer timestamp → local customer marked `isDeleted = true`.
- `INT-SYN-016`: Work task conflict resolution → tasks with same UUID compared by `updatedAt` → latest write wins.
- `INT-SYN-017`: Marketing lead conflict resolution → leads compared by `updatedAt` → latest write wins.
- `INT-SYN-018`: Performance record conflict resolution → performance records compared by `updatedAt` → latest write wins.
- `INT-SYN-019`: Binary document missing file detection → remote customer references `doc1.jpg`, local disk does not have `doc1.jpg` → queues `doc1.jpg` for download.
- `INT-SYN-020`: Binary document sync request → request binary file from peer `/api/document/doc1.jpg` → receives bytes and saves to local documents directory.
- `INT-SYN-021`: Sync state status text updates → start sync → status text transitions: "Idle" → "Connecting..." → "Exchanging database records..." → "Downloading document attachments..." → "Sync Complete".
- `INT-SYN-022`: Sync error handling (Connection refused) → target peer IP unreachable → status text updates to "Sync failed: Connection refused" without crashing app.
- `INT-SYN-023`: Direct connect via IP trigger → call `triggerSyncWithIp('192.168.1.50', 8080)` → attempts HTTP handshake with specified host and port.
- `INT-SYN-024`: REST server `/api/status` endpoint → HTTP GET `/api/status` → returns JSON `{status: "ok", app: "JJ CRM", version: "2.0.1"}`.
- `INT-SYN-025`: REST server `/api/sync/pull` endpoint → HTTP GET `/api/sync/pull` → returns full database sync JSON payload.
- `INT-SYN-026`: REST server `/api/sync/push` endpoint → HTTP POST `/api/sync/push` with JSON payload → processes merge in transaction and returns merge summary.
- `INT-SYN-027`: REST server `/api/document/:name` endpoint → HTTP GET for existing document file → streams file bytes with `image/*` or `application/octet-stream` MIME type.
- `INT-SYN-028`: REST server `/api/document/:name` 404 for missing file → HTTP GET for non-existent document → returns 404 Not Found.
- `INT-SYN-029`: Concurrent sync lock → trigger sync while another sync is in progress → second sync rejected with "Sync already in progress".
- `INT-SYN-030`: Sync completed notification trigger → sync finishes → invalidates Riverpod customer and task providers to refresh open screens.

---

## 6. Flakiness Controls & Determinism Rules

To ensure 100% reliable execution across developer workstations and CI runners, the test suites adhere to strict determinism rules:

### 6.1 Database Isolation
- **Rule:** Every integration test executes in a fresh, isolated temporary directory (`Directory.systemTemp.createTempSync('crm_test_')`).
- **Rule:** All Isar database instances are explicitly closed and their temporary directories recursively deleted in `tearDown()`.

### 6.2 Clock & Time Injection
- **Rule:** Tests never rely on non-deterministic system `DateTime.now()` for assertions.
- **Rule:** Time-dependent providers (`upcomingEventsProvider`, `todaySummaryEventsProvider`, carry-forward algorithms) are tested using fixed, injected base dates (e.g. `DateTime(2026, 3, 15, 10, 0)`).

### 6.3 Hardware & Socket Mocking
- **Rule:** No test binds to real network hardware or broadcasts UDP packets over physical interfaces.
- **Rule:** Platform channels for `flutter_secure_storage`, `file_picker`, `printing`, and `share_plus` are stubbed via `Mocktail` / custom fake handlers.

### 6.4 Zero Golden File Dependencies
- **Rule:** No visual pixel/golden image tests are used. All UI verification is performed structurally via widget trees, semantics, text matchers, and probe dumps.

### 6.5 Deterministic Ordering & Timeouts
- **Rule:** All database query streams and provider emissions enforce explicit ascending/descending sort keys.
- **Rule:** Every test runs within a strict timeout budget (maximum 5 seconds per test).

---

## 7. CI/CD Integration Plan

### 7.1 GitHub Actions Workflow Configuration
The automated testing suite gates the multi-platform build pipeline (`.github/workflows/build.yml`). Tests are executed on a dedicated Linux runner before Android, Linux, and Windows binary compilation jobs.

```yaml
jobs:
  test:
    name: Headless Automated Verification (Suites A, B, C)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Linux build dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y libgtk-3-dev ninja-build libsecret-1-dev

      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Resolve dependencies
        run: flutter pub get

      - name: Verify static analysis
        run: flutter analyze

      - name: Run test suites (Exclude probes)
        run: flutter test --exclude-tags probe --concurrency=4

      - name: Upload test failure artifacts
        if: failure()
        uses: actions/upload-artifact@v4
        with:
          name: test-reports
          path: build/test_results/
```

### 7.2 Running Tests Locally

```bash
# Run all three suites (Suite A, B, C ~660 tests)
flutter test --exclude-tags probe

# Run only UI Suite A
flutter test test/ui/

# Run only Usability Suite B
flutter test test/usability/

# Run only Backend Integration Suite C
flutter test test/integration/

# Run discovery probes on-demand to inspect UI layouts
flutter test test/probes/ --tags probe
```