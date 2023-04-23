// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:regtest_core/core.dart';

enum TerminalColors { red, green, yellow, blue, magenta, cyan, white }

String colorize(String text, TerminalColors? color) {
  if (color == null) return text;

  String code;
  switch (color) {
    case TerminalColors.red:
      code = '\x1B[31m';
      break;
    case TerminalColors.green:
      code = '\x1B[32m';
      break;
    case TerminalColors.yellow:
      code = '\x1B[33m';
      break;
    case TerminalColors.blue:
      code = '\x1B[34m';
      break;
    case TerminalColors.magenta:
      code = '\x1B[35m';
      break;
    case TerminalColors.cyan:
      code = '\x1B[36m';
      break;
    case TerminalColors.white:
      code = '\x1B[37m';
      break;
    default:
      code = '';
  }

  return '$code$text\x1B[0m';
}

Map<String, String> envVars = Platform.environment;
dynamic printResults = envVars['REGTEST-PRINT-RESULTS'];

bool isValidRegtestTxHash(String? hash) {
  if (hash == null) return false;

  final RegExp regtestBech32Pattern = RegExp(r'^[a-fA-F0-9]{64}$');
  return regtestBech32Pattern.hasMatch(hash);
}

bool isValidRegtestBech32Address(String? address) {
  if (address == null) return false;

  final RegExp regtestBech32Pattern =
      RegExp(r'^bcrt1[qpzry9x8gf2tvdw0s3jn54khce6mua7l]{1,40}$');
  return regtestBech32Pattern.hasMatch(address);
}

class N {
  static LnNode? CLNgRPC;
  static LnNode? CLNjRPC;
  static LnNode? LNDgRPC;

  static void set(Map<NodeId, LnNode> nodeMap) {
    N.CLNgRPC = nodeMap[NodeId.cln1];
    N.CLNjRPC = nodeMap[NodeId.cln2];
    N.LNDgRPC = nodeMap[NodeId.lnd1];
  }
}

enum ResultType {
  ok,
  nok,
}

int numResults = 0;
int numOK = 0;
int numNOK = 0;

void printSummary() {
  print("SUMMARY: $numOK/$numResults OK");
}

void printInfo(String message) {
  print("ℹ️ $message");
}

void printResult(
  String message, {
  ResultType res = ResultType.ok,
  bool grouped = true,
  int line = 2,
  String? detail,
  TerminalColors? color,
}) {
  numResults++;
  final indentation = grouped ? "  " : "";

  if (res == ResultType.ok) {
    numOK++;
    return print("$indentation🧪✅ $message");
  }

  final source = getCurrentSourceFile(line);

  numNOK++;
  print("$indentation🧪❌ $message [$source]");

  if (printResults == "1" ||
      printResults == "true" ||
      printResults == true && (detail != null && detail.isNotEmpty)) {
    print(colorize("$indentation     ↪️  $detail", color));
  }
}

void printSectionHeader(String header, [int dividerWidth = 40]) {
  final spacedHeader = " ${header.toUpperCase()} ";
  int headerPadding = (dividerWidth - spacedHeader.length) ~/ 2;
  String headerLine = '=' * headerPadding + spacedHeader + '=' * headerPadding;

  if (header.length % 2 != 0) headerLine += '=';

  print(headerLine);
}

void printGroupHeader(
  String header, {
  int dividerWidth = 40,
  int sourceLine = 2,
}) {
  print("🔵 $header [${getCurrentSourceFile(sourceLine)}]");
}

void printSectionFooter([int dividerWidth = 40]) {
  String divider = '=' * dividerWidth;
  print(divider);
}

String getCurrentSourceFile([int line = 2]) {
  StackTrace currentStackTrace = StackTrace.current;
  List<String> lines = currentStackTrace.toString().split('\n');

  // The first line contains the current function (getCurrentSourceLine),
  // so we need to get the second line for the caller's source line
  if (lines.length > 1) {
    final filePathRegex = RegExp(r'([\w\s\.-/]+\.dart):(\d+):');
    final match = filePathRegex.firstMatch(lines[line]);

    if (match != null) {
      final relativePath = match.group(1);
      final lineNumber = match.group(2);
      final info = "$relativePath:$lineNumber";
      log(info, level: 900, name: 'SourceLocation');

      // Convert the relative path to an absolute path
      // String absolutePath = p.normalize(
      //   p.join(Directory.current.path, relativePath),
      // );

      // return ' $absolutePath, line $lineNumber ';
      return info;
    }
  }

  throw Exception('Could not determine the current source line');
}

void printWalletBalanceComparison(WalletBalances before, WalletBalances after) {
  for (var k in before.balances.keys) {
    final b = before.balances[k]!;
    final a = after.balances[k]!;

    print("Node: ${k.id}");
    print(
      "  total:  ${formatAmount(b.onchainTotalBalance, Denomination.btc)} -> ${formatAmount(a.onchainTotalBalance, Denomination.btc)}",
    );
    print(
      "  confi:   ${formatAmount(b.onchainConfirmedBalance, Denomination.btc)} -> ${formatAmount(a.onchainConfirmedBalance, Denomination.btc)}",
    );
    print(
      "  unconfi: ${formatAmount(b.onchainUnconfirmedBalance, Denomination.btc)} -> ${formatAmount(a.onchainUnconfirmedBalance, Denomination.btc)}",
    );
  }
}
