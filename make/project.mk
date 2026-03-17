init:
	fvm flutter pub get

	melos bootstrap

	make codegen

	make codegen-assets

	make format

	make format-packages

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

