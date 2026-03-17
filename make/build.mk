codegen:
	melos run codegen --no-select

codegen-assets:
	cd packages/features/app/assets && fluttergen -c pubspec.yaml

compile-icons:
	sh ./scripts/compile_icons.sh

intl-with-format:
	fvm flutter gen-l10n

	melos run format