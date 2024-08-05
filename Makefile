# deploy the helm chart
# first step is to make the charts run helm to install dependecies first, so rename all charts containing ondc to template_back
# run helm dep up on all charts

helm-dep-up:
	@read -p "Enter namespace: " namespace; \
	echo "Installing crds first"; \
	cd crds && helm install ondc-buyer-app-release . -f values.yaml --namespace $$namespace
	echo "Installing databases"; \
	cd ../databases && helm install ondc-buyer-app-dbs-release . -f values.yaml --namespace $$namespace
	echo "Installing logging"; \
	cd ../services && helm install ondc-buyer-app-services-release . -f values.yaml --namespace $$namespace


helm-upgrade-service:
	cd services && helm upgrade --install ondc-buyer-app-services-release . -f values.yaml --namespace $$namespace

helm-uninstall:
	@read -p "Enter namespace: " namespace; \
	echo "Uninstalling services first"; \
	cd services && helm uninstall ondc-buyer-app-services-release --namespace $$namespace
	echo "Uninstalling databases"; \
	cd ../databases && helm uninstall ondc-buyer-app-dbs-release --namespace $$namespace
	echo "Uninstalling crds"; \
	cd ../crds && helm uninstall ondc-buyer-app-release --namespace $$namespace