include secrets.mk

.PHONY: clean

FUNCTION_TARGET = oncreateuser
REGION = asia-northeast1
FUNCTION_SIGNATURE_TYPE = cloudevent

bin/server.dart:
	dart run build_runner build --delete-conflicting-outputs

build: bin/server.dart

test: clean build
	dart test

clean:
	dart run build_runner clean
	rm -rf bin/server.dart

run: build
	dart run bin/server.dart --target=$(FUNCTION_TARGET) --signature-type=cloudevent


# See: https://cloud.google.com/sdk/gcloud/reference/run/deploy
deploy: build
	gcloud run deploy $(FUNCTION_TARGET) \
		--source=. \
		--no-allow-unauthenticated \
		--project=$(PROJECT_NAME) \
		--region=$(REGION) \
		--set-env-vars=ENVIRONMENT=production \
		--set-secrets=PROJECT_NAME=PROJECT_NAME:latest,CLIENT_ID=CLIENT_ID:latest,CLIENT_EMAIL=CLIENT_EMAIL:latest,PRIVATE_KEY=PRIVATE_KEY:latest

# See: https://cloud.google.com/sdk/gcloud/reference/eventarc/triggers/create
trigger:
	gcloud eventarc triggers create $(FUNCTION_TARGET) \
    --location=$(REGION) \
    --destination-run-service=$(FUNCTION_TARGET) \
    --event-filters="type=google.cloud.firestore.document.v1.created" \
    --event-filters="database=(default)" \
    --event-filters="namespace=(default)" \
    --event-filters-path-pattern="document=users/{userId}" \
    --event-data-content-type="application/protobuf" \
    --service-account="$(SERVICE_ACCOUNT_NAME)@$(PROJECT_NAME).iam.gserviceaccount.com" \
		--project=$(PROJECT_NAME)
