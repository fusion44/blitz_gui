# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "---------------HELP-----------------"
	@echo "To clean the workspace type 'make clean'"
	@echo "To regenerate all generated code type 'make generate'"
	@echo "To install dependencies in all packages"
	@echo "To upgrade dependencies to latest versions run make upgrade-deps"
	@echo "To push the app to an Raspiblitz type 'install-to-pi'. Make sure to adjust all values in the script accordingly."
	@echo "To run blitz_app in debug mode type 'make run-linux'"
	@echo "To run a specific app on Linux type 'run-linux-app-name-mode'"
	@echo "   Available apps: 'blitz-app'; 'setup-app';"
	@echo "   Available modes: 'debug'; 'profile'; 'release';"
	@echo "   Example: 'make run-blitz-app-linux-profile' will run the blitz app in profile mode on Linux"
	@echo "To run the app on web type 'run-chrome'"
	@echo "------------------------------------"

clean:
	flutter clean

generate:
	bash scripts/generate.sh

run-linux:
	bash scripts/run_app_linux.sh blitz_app debug

run-blitz-app-linux-debug:
	bash scripts/run_app_linux.sh blitz_app

run-blitz-app-linux-profile:
	bash scripts/run_app_linux.sh blitz_app profile

run-blitz-app-linux-release:
	bash scripts/run_app_linux.sh blitz_app release

run-setup-app-linux-debug:
	bash scripts/run_app_linux.sh setup_app

run-setup-app-linux-profile:
	bash scripts/run_app_linux.sh setup_app profile

run-setup-app-linux-release:
	bash scripts/run_app_linux.sh setup_app release

run-chrome:
# Clean the workspace, if the app was run in desktop 
# mode before, web won't work without a cleanup
	flutter clean
	flutter run -d chrome

install-deps:
	bash scripts/install_deps.sh

upgrade-deps:
	bash scripts/upgrade_deps.sh

install-to-pi:
	dart scripts/build_and_push.dart

sort-imports:
	flutter pub run import_sorter:main