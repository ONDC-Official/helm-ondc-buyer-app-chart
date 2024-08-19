# deploy the helm chart
# first step is to make the charts run helm to install dependecies first, so rename all charts containing ondc to template_back
# run helm dep up on all charts

helm-dep-up:
	# this is to be run only once
	# move all templates files to temp_templates
	mv templates templates_back
	# take input of namespace
	@read -p "Enter namespace: " namespace; \
	helm install ondc-buyer-app-release . -f values.yaml --namespace $$namespace
	# move all templates files to temp_templates
	mv templates_back templates
	# run helm install on all charts
	helm upgrade --install ondc-logging-webserver-release . -f values.yaml --namespace $$namespace

helm-upgrade:
	helm upgrade --install ondc-logging-webserver-release . -f values.yaml --namespace $$namespace

helm-uninstall:
	@read -p "Enter namespace: " namespace; \
	helm uninstall ondc-logging-webserver-release --namespace $$namespace