const projectName = 'regtest';
const projectNetwork = '${projectName}_network';
const dockerDataDir = '/tmp/regtest-data';

const defaultRedisName = '${projectName}_redis';
const defaultBitcoinCoreName = '${projectName}_bitcoind';

const currentNumContainers = 12;

const defaultChannelSize = 24000000; // 0.024 btc
const defaultBalanceSize = 12000000; // # 0.12 btc

enum NodeId {
  empty,
  lnd1,
  lnd2,
  lnd3,
  cln1,
  cln2,
}

enum Implementation {
  empty,
  lndGRPC,
  clnJRPC,
  clnGRPC,
}

enum Denomination { btc, sats, msats }

final dataDirs = [
  "data/cashu-1",
  "data/cashu-2",
  "data/clightning-1/",
  "data/clightning-2/",
  "data/lnd-1/",
  "data/lnd-2/",
  "data/lnd-3/",
];
