# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "---------------HELP-----------------"
	@echo "To clean the workspace type 'make clean'"
	@echo "To run the app on Linux type 'run-linux'"
	@echo "To run the app on web type 'run-chrome'"
	@echo "To push the app to an Raspiblitz type 'install-to-pi'. Make sure to adjust all values in the script accordingly."
	@echo "------------------------------------"

clean:
	flutter clean

run-linux:
	flutter run -d linux

run-chrome:
# Clean the workspace, if the app was run in desktop 
# mode before, web won't work without a cleanup
	flutter clean
	flutter run -d chrome

install-to-pi:
	bash scripts/build_and_push.sh