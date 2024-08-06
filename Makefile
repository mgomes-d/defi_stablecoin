DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

install:
	forge install OpenZeppelin/openzeppelin-contracts@v4.8.3 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@1.2.0 --no-commit && forge install foundry-rs/forge-std@v1.9.1 --no-commit

remove:
	rm -rf lib && rm .gitmodules && rm -rf .git/modules/* && rm -rf out && touch .gitmodules

deploy:
	@forge script script/DeployDSC.s.sol:DeployDSC --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

.PHONY: install remove deploy