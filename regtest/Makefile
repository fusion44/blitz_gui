clean:
	flutter clean

down:
	docker compose -p regtest down --volumes

up:
	docker compose -p regtest up

del-data:
	sudo rm -rf /tmp/regtest-data

test-headless:
	env REGTEST-HEADLESS=1 dart ./headless/bin/test_api.dart

test-headless-verbose:
	env REGTEST-HEADLESS=1 env REGTEST-PRINT-RESULTS=1 dart ./headless/bin/test_api.dart