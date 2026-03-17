build_aab:
	@echo "🔌 Android Release build started"

	cd .. && fvm flutter build aab --flavor prod --release --tree-shake-icons --obfuscate --split-debug-info=build/app/outputs/sym

build_qa_apk:
	@echo "🔌 Android Development build started"

	cd .. && fvm flutter build apk --flavor dev --release --tree-shake-icons

build_prod_apk:
	@echo "🔌 Android Development build started"

	cd .. && fvm flutter build apk --flavor prod --release --tree-shake-icons

# Деплой последней сборки в Firebase. Берёт необходимые значения из env файла.
deploy_qa_firebase:
	@echo "🔌 Started deploying to Firebase"

	bundle exec fastlane firebase --env dev

deploy_prod_firebase:
	@echo "🔌 Started deploying to Firebase"

	bundle exec fastlane firebase --env prod

# Деплой последней сборки в Google Play. Берёт необходимые значения из env файла.
deploy_gp:
	@echo "🔌 Started deploying to Google Play"

	bundle exec fastlane google_play --env prod

	bundle exec fastlane upload_symbols --env prod
