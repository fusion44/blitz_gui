const projectName = 'regtest';
const projectNetwork = '${projectName}_network';
const dockerDataDir = '/tmp/regtest-data';

const defaultRedisName = '${projectName}_redis';
const defaultBitcoinCoreName = '${projectName}_bitcoind';
const defaultCashMintName = '${projectName}_cashu_mint';
const defaultLNbitsName = '${projectName}_lnbits';

const currentNumContainers = 12;

const defaultChannelSize = 24000000; // 0.024 btc
const defaultBalanceSize = 12000000; // # 0.12 btc

enum Implementation { empty, lnd, cln }

enum Denomination { btc, sats, msats }

enum ContainerType { bitcoinCore, lnd, cln, lnbits, cashuMint }
