# Storeth Contracts

### Frontend: https://github.com/pacelliv/storeth-frontend

### Quickstart

Create a keystore

```bash
# 1 encrypt private key:
cast wallet import test_wallet --interactive

# 2. insert private key
# 3. set password
```

Create a `.env` file with the following format:

```bash
SENDER=0x123456789abcdef... # address associated with the encrypted private key in keystore
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/your-api-key
ETHERSCAN_API_KEY=GWRGWGW121142...
```

### Build

```bash
make build
```

### Run tests

```bash
make test
```

### Format

```
make format
```

### Project commands

#### Deploy factory (StorageFactory)

```bash
make deploy ARGS="-d --network sepolia"
```

Grab the address of the deployed factory and store it in `script/StorageFactory.s.sol` line 7.

#### Create a database (SimpleStorage)

```bash
make create_db ARGS="-i --network sepolia"
```

#### Create an account

See `script/StorageFactory.s.sol:CreateAccount`, update functions inputs and run:

```bash
make create_acc ARGS="-i --network sepolia"
```

#### Update account balance

See `script/StorageFactory.s.sol:UpdateAccountBalance`, update functions inputs and run:

```bash
make update_bal ARGS="-i --network sepolia"
```

### For more commands check `Makefile`
