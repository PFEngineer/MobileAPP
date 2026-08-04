# Mobile — Makefile
#
# App principal (invest_app). O design_system agora vive no monorepo
# mobile_core_platform (consumido via git dependency) — a showcase roda por lá.
#
# O projeto exige um flavor de ambiente (hml/prd). Os alvos de run são sempre
# por ambiente; os build-* base assumem hml.
#
# Rodar é sempre por ambiente + plataforma (hml/prd × ios/android).
#
# Exemplos:
#   make run-hml-ios              # HML no simulador iOS (sobe o simulador)
#   make run-hml-android          # HML no emulador Android (sobe o emulador)
#   make run-prd-ios              # PRD no simulador iOS
#   make run-prd-android          # PRD no emulador Android
#   make run-hml-ios DEVICE=<id>  # força um device específico (veja `make devices`)

FLUTTER          ?= flutter
APP_DIR          := .
ANDROID_EMULATOR ?= Pixel_9a
ADB              ?= $(HOME)/Library/Android/sdk/platform-tools/adb

# Device explícito opcional: `make run-hml-ios DEVICE=...` sobrepõe a auto-seleção.
DEVICE ?=

# Ambiente (Galena API): FLAVOR seleciona o flavor Android / scheme iOS e
# GALENA_ENV é passado ao Dart via --dart-define. O projeto EXIGE um flavor
# (Android define flavorDimensions "env" com hml/prd e sem default). Os alvos
# run-{hml,prd}-* já fixam os dois por alvo; os build-* base assumem hml e os
# build-*-prd sobrepõem para prd.
FLAVOR     ?= hml
GALENA_ENV ?= hml
# Recursivo (=) de propósito: os alvos de ambiente sobrepõem FLAVOR/GALENA_ENV
# por alvo (target-specific), então FLAVOR_ARGS é reavaliado no momento do uso.
FLAVOR_ARGS = $(if $(FLAVOR),--flavor $(FLAVOR),) $(if $(GALENA_ENV),--dart-define=GALENA_ENV=$(GALENA_ENV),)

.DEFAULT_GOAL := help

# ---------------------------------------------------------------------------
# Recipes reutilizáveis (parametrizadas pelo diretório do app: $(1))
# ---------------------------------------------------------------------------

# Boota (se preciso) um simulador iOS e roda o app nele.
# Com DEVICE explícito (device já conectado) pula o boot do simulador.
define run_ios
	@if [ -z "$(DEVICE)" ]; then \
	   echo "==> Garantindo um simulador iOS aberto..."; \
	   open -a Simulator; \
	   printf "==> Aguardando o simulador bootar"; \
	   until xcrun simctl list devices booted | grep -q Booted; do printf "."; sleep 2; done; echo ""; \
	 fi
	@UDID="$(DEVICE)"; \
	 if [ -z "$$UDID" ]; then \
	   UDID=`xcrun simctl list devices booted | grep -Eo '[0-9A-Fa-f-]{36}' | head -1`; \
	 fi; \
	 echo "==> Rodando em $$UDID"; \
	 cd $(1) && $(FLUTTER) run -d $$UDID $(FLAVOR_ARGS)
endef

# Boota (se preciso) o emulador Android, espera o boot e roda o app nele.
# Com DEVICE explícito (device já conectado) pula o boot do emulador.
define run_android
	@if [ -z "$(DEVICE)" ]; then \
	   echo "==> Iniciando emulador Android ($(ANDROID_EMULATOR))..."; \
	   $(FLUTTER) emulators --launch $(ANDROID_EMULATOR) >/dev/null 2>&1 || true; \
	   echo "==> Aguardando o emulador ficar pronto..."; \
	   $(ADB) wait-for-device; \
	   until [ "`$(ADB) shell getprop sys.boot_completed 2>/dev/null | tr -d '\r'`" = "1" ]; do sleep 2; done; \
	 fi
	@DEV="$(if $(DEVICE),$(DEVICE),emulator)"; \
	 echo "==> Rodando em $$DEV"; \
	 cd $(1) && $(FLUTTER) run -d $$DEV $(FLAVOR_ARGS)
endef

# ===========================================================================
# App principal (invest_app) — rodar por ambiente + plataforma
# ===========================================================================
# iOS/Android sobem o simulador/emulador via macros run_ios/run_android. O flavor
# vem de variáveis target-specific (FLAVOR/GALENA_ENV) reavaliadas em FLAVOR_ARGS.
# DEVICE=<id> é opcional em todos: se omitido, auto-seleciona; se passado,
# sobrepõe (veja `make devices`). Ex.: make run-hml-ios DEVICE=<id>
.PHONY: run-hml-ios run-hml-android run-prd-ios run-prd-android
run-hml-ios: FLAVOR = hml
run-hml-ios: GALENA_ENV = hml
run-hml-ios: ## App em HML no simulador iOS (DEVICE=<id> opcional)
	$(call run_ios,$(APP_DIR))
run-hml-android: FLAVOR = hml
run-hml-android: GALENA_ENV = hml
run-hml-android: ## App em HML no emulador Android (DEVICE=<id> opcional)
	$(call run_android,$(APP_DIR))

run-prd-ios: FLAVOR = prd
run-prd-ios: GALENA_ENV = prd
run-prd-ios: ## App em PRD no simulador iOS (DEVICE=<id> opcional)
	$(call run_ios,$(APP_DIR))
run-prd-android: FLAVOR = prd
run-prd-android: GALENA_ENV = prd
run-prd-android: ## App em PRD no emulador Android (DEVICE=<id> opcional)
	$(call run_android,$(APP_DIR))

# ===========================================================================
# Dependências, qualidade e testes
# ===========================================================================

.PHONY: get clean analyze format test
get: ## flutter pub get
	cd $(APP_DIR) && $(FLUTTER) pub get

clean: ## flutter clean
	cd $(APP_DIR) && $(FLUTTER) clean

analyze: ## Análise estática
	cd $(APP_DIR) && $(FLUTTER) analyze

format: ## Formata o código Dart
	dart format lib test

test: ## Roda os testes do app
	cd $(APP_DIR) && $(FLUTTER) test

# ===========================================================================
# Builds de release
# ===========================================================================

.PHONY: build-apk build-ios build-apk-hml build-apk-prd build-ios-hml build-ios-prd
build-apk: ## Build Android (APK release, hml) do app principal
	cd $(APP_DIR) && $(FLUTTER) build apk --release $(FLAVOR_ARGS)

build-ios: ## Build iOS (release, sem code sign, hml) do app principal
	cd $(APP_DIR) && $(FLUTTER) build ios --release --no-codesign $(FLAVOR_ARGS)

build-apk-hml: ## APK release em HML
	$(MAKE) build-apk FLAVOR=hml GALENA_ENV=hml
build-apk-prd: ## APK release em PRD
	$(MAKE) build-apk FLAVOR=prd GALENA_ENV=prd
build-ios-hml: ## Build iOS release em HML
	$(MAKE) build-ios FLAVOR=hml GALENA_ENV=hml
build-ios-prd: ## Build iOS release em PRD
	$(MAKE) build-ios FLAVOR=prd GALENA_ENV=prd

# ===========================================================================
# Diagnóstico
# ===========================================================================

.PHONY: doctor devices emulators boot-ios boot-android
doctor: ## flutter doctor
	$(FLUTTER) doctor

devices: ## Lista devices conectados
	$(FLUTTER) devices

emulators: ## Lista emuladores disponíveis
	$(FLUTTER) emulators

boot-ios: ## Abre o simulador iOS
	open -a Simulator

boot-android: ## Sobe o emulador Android (ver ANDROID_EMULATOR)
	$(FLUTTER) emulators --launch $(ANDROID_EMULATOR)

.PHONY: help
help: ## Mostra esta ajuda
	@echo "Mobile — alvos disponíveis:"
	@echo ""
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "Variáveis: DEVICE=<id>  ANDROID_EMULATOR=$(ANDROID_EMULATOR)"
