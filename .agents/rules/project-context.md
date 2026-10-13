---
trigger: always_on
description: Context & conventions for luna_web_extension (POS print bridge)
---

# luna_web_extension
Flutter app (Windows, macOS, Android) acting as a **bridge** for the web-based POS:
the web app sends print jobs over a local WebSocket (shelf, shelf_web_socket,
web_socket_channel) and this app prints receipts to **network thermal printers**
(esc_pos_utils_plus, flutter_thermal_printer).

## Stack
- State: flutter_bloc, provider; DI: get_it + injectable (`lib/core/dep_injections`)
- Routing: go_router (`lib/core/navigation`); storage: shared_preferences (`lib/core/local_storage`)
- Logging: logger (`lib/shared/utilities/log_util.dart`)
- Services: `lib/shared/services/{socket,printer,language}_service.dart`
- Assets codegen: flutter_gen (`lib/generated/`, AppFonts, AppColors, flutter_svg); font Inter
- Codegen: `dart run build_runner build` (injectable, flutter_gen). Never hand-edit generated files.

## Localization (multi-language: id, en)
- Files in `lib/l10n/`: `intl_id.arb` (**template**), `intl_en.arb`. Config: `l10n.yaml`.
- Every new user-facing string MUST be added to BOTH arb files; no hardcoded UI text.
- Key prefixes: `btn_`, `title_`, `txt_`, `lbl_`, `app_`. camelCase after prefix.
- Regenerate with `flutter gen-l10n`; don't edit `app_localizations*.dart`.
- Untranslated report: `report/untranslated.txt`.
