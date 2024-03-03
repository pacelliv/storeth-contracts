-include .env

.PHONY: all help clean remove build install update format coverage snapshot test anvil deploy create_db create_acc update_bal

help:
	@echo ""
	@echo "Usage:"
	@echo "	make deploy [ARGS=...]		example: make deploy ARGS=\"-d --network sepolia"\"
	@echo ""
	@echo "	make create_db [ARGS=...]	example: make create_db ARGS=\"-i --network sepolia"\"
	@echo ""
	@echo "	make create_acc [ARGS=...]	example: make create_acc ARGS=\"-i --network sepolia"\"
	@echo ""
	@echo "	make update_bal [ARGS=...]	example: make update_bal ARGS=\"-i --network sepolia"\"

all :; clean remove install build update

clean :; forge clean

remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install foundry-rs/forge-std --no-commit

build :; forge build

update :; forge update

format :; forge fmt

coverage :; forge coverage --report debug > coverage-report.txt

snapshot :; forge snapshot

test :; forge test

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 12

RPC_URL := http://127.0.0.1:8545
DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
NETWORK_ARGS := --rpc-url $(RPC_URL) --private-key $(DEFAULT_ANVIL_KEY) --broadcast -vvvv

ifeq ($(findstring -d --network sepolia,$(ARGS)), -d --network sepolia)
	NETWORK_ARGS := --account test_wallet --sender $(SENDER) --rpc-url $(SEPOLIA_RPC_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

ifeq ($(findstring -i --network sepolia,$(ARGS)), -i --network sepolia)
	NETWORK_ARGS := --account test_wallet --sender $(SENDER) --rpc-url $(SEPOLIA_RPC_URL) --broadcast -vvvv
endif

deploy:
	@forge script script/StorageFactory.s.sol:DeployFactory $(NETWORK_ARGS)

create_db:
	@forge script script/StorageFactory.s.sol:CreateDatabase $(NETWORK_ARGS)

create_acc:
	@forge script script/StorageFactory.s.sol:CreateAccount $(NETWORK_ARGS)

update_bal:
	@forge script script/StorageFactory.s.sol:UpdateAccountBalance $(NETWORK_ARGS)