install:
	forge install OpenZeppelin/openzeppelin-contracts.git@v4.8.3 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@1.2.0 --no-commit && forge install foundry-rs/forge-std@v1.9.1 --no-commit

.PHONY: install