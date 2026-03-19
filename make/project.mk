init:
	fvm flutter pub get

	make codegen

	make codegen-assets

	make format

get:
	fvm flutter pub get

format:
	melos run format

propagate-secrets:
	sh ./scripts/propagate_secrets.sh

force-clean:
	make clean

	fvm flutter pub cache repair

clean:
	rm -rf .dart_tool
	rm -rf .pubspec_lock

	fvm flutter clean

