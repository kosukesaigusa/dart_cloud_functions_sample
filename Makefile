.PHONY: clean

FUNCTION_TARGET = function
PORT = 8080
PROJECT_NAME = flutter-account-book

# bin/server.dart is the generated target for lib/functions.dart
bin/server.dart:
	dart run build_runner build --delete-conflicting-outputs

build: bin/server.dart

test: clean build
	dart test

clean:
	dart run build_runner clean
	rm -rf bin/server.dart

run: build
	dart run bin/server.dart --port=$(PORT) --target=$(FUNCTION_TARGET)

deploy: build
	gcloud run deploy function \
		--source=. \
		--project=$(PROJECT_NAME) \
		--region=asia-northeast1  \
		--platform=managed \
		--allow-unauthenticated
