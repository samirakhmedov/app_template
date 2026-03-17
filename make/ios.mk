clean-ios:
	sh ./scripts/clean_ios.sh

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
