# Mobile — Makefile
#
# App principal (invest_app). O design_system agora vive no monorepo
# mobile_core_platform (consumido via git dependency) — a showcase roda por lá.
#
# O projeto exige um flavor de ambiente (hml/prd); os alvos base assumem hml.
#
# Exemplos:
#   make run                # app principal em hml (flutter escolhe o device)
#   make run-prd            # app principal em prd
#   make run-ios            # app principal no simulador iOS (hml)
#   make run-android        # app principal no emulador Android (hml)
#   make run DEVICE=<id>    # força um device específico (veja `make devices`)

FLUTTER          ?= flutter
APP_DIR          := .
ANDROID_EMULATOR ?= Pixel_9a
ADB              ?= $(HOME)/Library/Android/sdk/platform-tools/adb

# Device explícito opcional: `make run-ios DEVICE=...` sobrepõe a auto-seleção.
DEVICE ?=

# Ambiente (Galena API): FLAVOR seleciona o flavor Android / scheme iOS e
# GALENA_ENV é passado ao Dart via --dart-define. O projeto EXIGE um flavor
# (Android define flavorDimensions "env" com hml/prd e sem default), então os
# alvos base assumem hml. Os alvos run-prd/build-*-prd sobrepõem para prd.
# Use `make run FLAVOR=<f> GALENA_ENV=<e>` para combinar manualmente.
FLAVOR     ?= hml
GALENA_ENV ?= hml
FLAVOR_ARGS := $(if $(FLAVOR),--flavor $(FLAVOR),) $(if $(GALENA_ENV),--dart-define=GALENA_ENV=$(GALENA_ENV),)

.DEFAULT_GOAL := help

# ---------------------------------------------------------------------------
# Recipes reutilizáveis (parametrizadas pelo diretório do app: $(1))
# ---------------------------------------------------------------------------

# Boota (se preciso) um simulador iOS e roda o app nele.
define run_ios
	@echo "==> Garantindo um simulador iOS aberto..."
	@open -a Simulator
	@printf "==> Aguardando o simulador bootar"
	@until xcrun simctl list devices booted | grep -q Booted; do printf "."; sleep 2; done; echo ""
	@UDID="$(DEVICE)"; \
	 if [ -z "$$UDID" ]; then \
	   UDID=`xcrun simctl list devices booted | grep -Eo '[0-9A-Fa-f-]{36}' | head -1`; \
	 fi; \
	 echo "==> Rodando em $$UDID"; \
	 cd $(1) && $(FLUTTER) run -d $$UDID $(FLAVOR_ARGS)
endef

# Boota (se preciso) o emulador Android, espera o boot e roda o app nele.
define run_android
	@echo "==> Iniciando emulador Android ($(ANDROID_EMULATOR))..."
	@$(FLUTTER) emulators --launch $(ANDROID_EMULATOR) >/dev/null 2>&1 || true
	@echo "==> Aguardando o emulador ficar pronto..."
	@$(ADB) wait-for-device
	@until [ "`$(ADB) shell getprop sys.boot_completed 2>/dev/null | tr -d '\r'`" = "1" ]; do sleep 2; done
	@DEV="$(if $(DEVICE),$(DEVICE),emulator)"; \
	 echo "==> Rodando em $$DEV"; \
	 cd $(1) && $(FLUTTER) run -d $$DEV $(FLAVOR_ARGS)
endef

# ===========================================================================
# App principal (invest_app)
# ===========================================================================

.PHONY: run run-ios run-android
run: ## App principal em hml (flutter escolhe/pergunta o device)
	cd $(APP_DIR) && $(FLUTTER) run $(if $(DEVICE),-d $(DEVICE),) $(FLAVOR_ARGS)

run-ios: ## App principal no simulador iOS (hml)
	$(call run_ios,$(APP_DIR))

run-android: ## App principal no emulador Android (hml)
	$(call run_android,$(APP_DIR))

# --- Ambientes: HML e PRD (flavor Android / scheme iOS + --dart-define) -------
.PHONY: run-hml run-hml-ios run-hml-android run-prd run-prd-ios run-prd-android
run-hml: ## App em HML (device automático)
	$(MAKE) run FLAVOR=hml GALENA_ENV=hml
run-hml-ios: ## App em HML no simulador iOS
	$(MAKE) run-ios FLAVOR=hml GALENA_ENV=hml
run-hml-android: ## App em HML no emulador Android
	$(MAKE) run-android FLAVOR=hml GALENA_ENV=hml

run-prd: ## App em PRD (device automático)
	$(MAKE) run FLAVOR=prd GALENA_ENV=prd
run-prd-ios: ## App em PRD no simulador iOS
	$(MAKE) run-ios FLAVOR=prd GALENA_ENV=prd
run-prd-android: ## App em PRD no emulador Android
	$(MAKE) run-android FLAVOR=prd GALENA_ENV=prd

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
