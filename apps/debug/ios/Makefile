
build_ipa_prod:
	cd .. && fvm flutter build ipa --flavor prodGms --dart-define=STORE_TYPE=legacy --release --tree-shake-icons --obfuscate --split-debug-info=build/ios/archive/sym --export-options-plist ios/prodExportOptions.plist

build_ipa_qa:
	cd .. && fvm flutter build ipa --flavor devGms --dart-define=STORE_TYPE=legacy --release --tree-shake-icons --obfuscate --split-debug-info=build/ios/archive/sym --export-options-plist ios/devExportOptions.plist

deploy_prod_testflight:
	@echo "🔌 Started deploying to TestFlight"

	bundle exec fastlane testflight --env prod

deploy_qa_testflight:
	@echo "🔌 Started deploying to TestFlight"

	bundle exec fastlane testflight --env dev

# Деплой последней сборки в Google Play. Берёт необходимые значения из env файла.
deploy_appstore:
	@echo "🔌 Started deploying to App Store"

	bundle exec fastlane appstore --env prod

	# bundle exec fastlane upload_symbols --env prod