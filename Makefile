# deploy the helm chart
# first step is to make the charts run helm to install dependecies first, so rename all charts containing ondc to template_back
# run helm dep up on all charts
SET_COMMAND_FOR_HELM=" --set JUSPAY_WEBHOOK_PASSWORD=$$JUSPAY_WEBHOOK_PASSWORD --set MMI_CLIENT_SECRET=$$MMI_CLIENT_SECRET --set AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID --set AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY --set RAZORPAY_KEY_SECRET=$$RAZORPAY_KEY_SECRET --set RAZORPAY_WEBHOOK_SECRET=$$RAZORPAY_WEBHOOK_SECRET --set BHASHINI_ULCA_API_KEY=$$BHASHINI_ULCA_API_KEY --set DLT_PASSWORD=$$DLT_PASSWORD --set DLT_CUSTOMER_ID=$$DLT_CUSTOMER_ID"
helm-dep-up:
	# this is to be run only once
	# move all templates files to temp_templates
	mv templates templates_back
	# take input of namespace
	@read -p "Enter namespace: " namespace; \
	helm install ondc-buyer-app-release . -f values.yaml --namespace $$namespace $(SET_COMMAND_FOR_HELM)
	# move all templates files to temp_templates
	mv templates_back templates
	# run helm install on all charts
	helm upgrade --install ondc-logging-webserver-release . -f values.yaml --namespace $$namespace $(SET_COMMAND_FOR_HELM)

helm-upgrade:
	helm upgrade --install ondc-logging-webserver-release . -f values.yaml --namespace $$namespace $(SET_COMMAND_FOR_HELM)

helm-uninstall:
	@read -p "Enter namespace: " namespace; \
	helm uninstall ondc-logging-webserver-release --namespace $$namespace