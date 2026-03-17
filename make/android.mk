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
