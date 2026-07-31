# Mobile — Makefile
#
# App principal (mobile_app). O design_system agora vive no monorepo
# mobile_core_platform (consumido via git dependency) — a showcase roda por lá.
#
# Exemplos:
#   make run                # app principal (flutter escolhe o device)
#   make run-ios            # app principal no simulador iOS
#   make run-android        # app principal no emulador Android
#   make run DEVICE=<id>    # força um device específico (veja `make devices`)

FLUTTER          ?= flutter
APP_DIR          := .
ANDROID_EMULATOR ?= Pixel_9a
ADB              ?= $(HOME)/Library/Android/sdk/platform-tools/adb

# Device explícito opcional: `make run-ios DEVICE=...` sobrepõe a auto-seleção.
DEVICE ?=

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
	 cd $(1) && $(FLUTTER) run -d $$UDID
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
	 cd $(1) && $(FLUTTER) run -d $$DEV
endef

# ===========================================================================
# App principal (mobile_app)
# ===========================================================================

.PHONY: run run-ios run-android
run: ## App principal (flutter escolhe/pergunta o device)
	cd $(APP_DIR) && $(FLUTTER) run $(if $(DEVICE),-d $(DEVICE),)

run-ios: ## App principal no simulador iOS
	$(call run_ios,$(APP_DIR))

run-android: ## App principal no emulador Android
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

.PHONY: build-apk build-ios
build-apk: ## Build Android (APK release) do app principal
	cd $(APP_DIR) && $(FLUTTER) build apk --release

build-ios: ## Build iOS (release, sem code sign) do app principal
	cd $(APP_DIR) && $(FLUTTER) build ios --release --no-codesign

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
