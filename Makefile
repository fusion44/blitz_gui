# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "---------------HELP-----------------"
	@echo "To clean the workspace type 'make clean'"
	@echo "To regenerate all generated code type 'make generate'"
	@echo "To run the app on Linux type 'run-linux'"
	@echo "To run the app on web type 'run-chrome'"
	@echo "To install dependencies in all packages"
	@echo "To upgrade dependencies to latest versions run make upgrade-deps"
	@echo "To push the app to an Raspiblitz type 'install-to-pi'. Make sure to adjust all values in the script accordingly."
	@echo "------------------------------------"

clean:
	flutter clean

generate:
	bash scripts/generate.sh

run-linux:
	flutter run -d linux

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