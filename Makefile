codegen:
	sh ./scripts/build_runner.sh

codegen-db:
	cd packages/database && sh ./scripts/build_runner.sh

codegen-uikit:
	cd packages/uikit && sh ./scripts/build_runner.sh

codegen-api:
	cd packages/api && sh ./scripts/build_runner.sh

codegen-assets:
	fluttergen -c pubspec.yaml

format:
	sh ./scripts/format.sh

propagate-secrets:
	sh ./scripts/propagate_secrets.sh

force-clean:
	make clean

	fvm flutter pub cache repair

clean:
	rm -rf .dart_tool
	rm -rf .pubspec_lock

	fvm flutter clean

clean-ios:
	sh ./scripts/clean_ios.sh

intl-with-format:
	sh ./scripts/intl_with_format.sh

reset-goldens:
	sh ./scripts/reset_goldens.sh

compile-icons:
	sh ./scripts/compile_icons.sh

ios-qa-dev-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд iOS"
	cd ios && make --ignore-errors build_ipa_qa

	@echo "Деплой iOS"
	cd ios && make deploy_qa_testflight

ios-qa-prod-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд iOS"
	cd ios && make --ignore-errors build_ipa_prod

	@echo "Деплой iOS"
	cd ios && make deploy_prod_testflight

ios-prod-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд iOS"
	cd ios && make --ignore-errors build_ipa_prod

	@echo "Деплой iOS"
	cd ios && make deploy_appstore

android-qa-dev-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд Android"
	cd android && make build_qa_apk

	@echo "Деплой Android"
	cd android && make deploy_qa_firebase

android-qa-prod-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд Android"
	cd android && make build_prod_apk

	@echo "Деплой Android"
	cd android && make deploy_prod_firebase

android-prod-deploy:
	# @echo "Обновление версии"
	# make bump-version

	@echo "Распространение секретов"
	make propagate_secrets

	@echo "Билд Android"
	cd android && make build_aab

	@echo "Деплой Android"
	cd android && make deploy_gp