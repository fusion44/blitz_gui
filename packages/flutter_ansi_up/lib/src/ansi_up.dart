// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// ansi_up is an library that parses text containing ANSI color escape
/// codes.
///
/// Source: https://github.com/flutter/devtools/blob/master/third_party/packages/ansi_up/lib/ansi_up.dart

const _ansiColors = [
  [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 187, 0, 0),
    Color.fromARGB(255, 0, 187, 0),
    Color.fromARGB(255, 187, 187, 0),
    Color.fromARGB(255, 0, 0, 187),
    Color.fromARGB(255, 187, 0, 187),
    Color.fromARGB(255, 0, 187, 187),
    Color.fromARGB(255, 255, 255, 255),
  ],
  [
    Color.fromARGB(255, 85, 85, 85),
    Color.fromARGB(255, 255, 85, 85),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 255, 255, 85),
    Color.fromARGB(255, 85, 85, 255),
    Color.fromARGB(255, 255, 85, 255),
    Color.fromARGB(255, 85, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
  ]
];

class FlutterAnsiUp {
  FlutterAnsiUp(this._text)
      : _style = StyledText.NONE,
        _palette256 = [] {
    _setupPalettes();
  }

  String _text;
  int _style;
  final List<Color> _palette256;
  Color? _fg;
  Color? _bg;
  RegExp? _csiRegex;

  /// Main entrypoint to call to parse ansi color escaped text.
  Iterable<StyledText> decode() sync* {
    while (true) {
      final packet = _getNextPacket();

      if ((packet.kind == PacketKind.eos) ||
          (packet.kind == PacketKind.incomplete)) {
        break;
      }

      // Drop single ESC or Unknown CSI.
      if ((packet.kind == PacketKind.esc) ||
          (packet.kind == PacketKind.unknown)) {
        continue;
      }

      if (packet.kind == PacketKind.text) {
        yield StyledText.from(_withState(packet));
      } else if (packet.kind == PacketKind.sgr) {
        _processAnsi(packet);
      } else if (packet.kind == PacketKind.oscurl) {
        final url = packet.url;
        if (url.startsWith('http:') || url.startsWith('https:')) {
          yield StyledText(packet.text, url: url);
        } else {
          yield StyledText(packet.text); // Not a safe url to include.
        }
      }
    }
  }

  void _setupPalettes() {
    _ansiColors.forEach(_palette256.addAll);
    final levels = [0, 95, 135, 175, 215, 255];
    for (var r = 0; r < 6; ++r) {
      for (var g = 0; g < 6; ++g) {
        for (var b = 0; b < 6; ++b) {
          _palette256.add(Color.fromARGB(255, levels[r], levels[g], levels[b]));
        }
      }
    }
    var greyLevel = 8;
    for (var i = 0; i < 24; ++i, greyLevel += 10) {
      _palette256.add(Color.fromARGB(255, greyLevel, greyLevel, greyLevel));
    }
  }

  _TextPacket _getNextPacket() {
    final pkt = _TextPacket(kind: PacketKind.eos);
    final len = _text.length;
    if (len == 0) {
      return pkt;
    }
    final pos = _text.indexOf('\x1B');
    if (pos == -1) {
      pkt.kind = PacketKind.text;
      pkt.text = _text;
      _text = '';
      return pkt;
    }
    if (pos > 0) {
      pkt.kind = PacketKind.text;
      pkt.text = _text.substring(0, pos);
      _text = _text.substring(pos);
      return pkt;
    }
    if (pos == 0) {
      if (len == 1) {
        pkt.kind = PacketKind.incomplete;
        return pkt;
      }
      final String nextChar = _text[1];
      if ((nextChar != '[') && (nextChar != ']')) {
        pkt.kind = PacketKind.esc;
        pkt.text = _text.substring(0, 1);
        _text = _text.substring(1);
        return pkt;
      }
      if (nextChar == '[') {
        _csiRegex ??= _cleanAndConvertToRegex(
          '\n                        '
          '^                           # beginning of line'
          '\n                                                    #'
          '\n                                                    '
          '# First attempt'
          '\n                        '
          '(?:                         # legal sequence'
          '\n                          '
          '\\x1b\\[                      # CSI'
          '\n                          '
          '([\\x3c-\\x3f]?)              # private-mode char'
          '\n                          '
          '([\\d;]*)                    # any digits or semicolons'
          '\n                          '
          '([\\x20-\\x2f]?               # an intermediate modifier'
          '\n                          '
          '[\\x40-\\x7e])                # the command'
          '\n                        )\n                        '
          '|                           # alternate (second attempt)'
          '\n                        '
          '(?:                         # illegal sequence'
          '\n                          '
          '\\x1b\\[                      # CSI'
          '\n                          '
          '[\\x20-\\x7e]*                # anything legal'
          '\n                          '
          '([\\x00-\\x1f:])              # anything illegal'
          '\n                        )\n                    ',
        );
        final match = _csiRegex!.firstMatch(_text);
        if (match == null) {
          pkt.kind = PacketKind.incomplete;
          return pkt;
        }
        if (match.groupCount > 4) {
          pkt.kind = PacketKind.esc;
          pkt.text = _text.substring(0, 1);
          _text = _text.substring(1);
          return pkt;
        }
        final match1 = match.groupCount > 1 ? match.group(1) : null;
        final match3 = match.groupCount > 3 ? match.group(3) : null;
        if (match1 != '' || match3 != 'm') {
          pkt.kind = PacketKind.unknown;
        } else {
          pkt.kind = PacketKind.sgr;
        }
        final text = match.groupCount > 2 ? match.group(2) : null;
        if (text != null) {
          pkt.text = text;
        }
        final rpos = match.group(0)!.length;
        _text = _text.substring(rpos);
        return pkt;
      }
    }

    return pkt;
  }

  void _processAnsi(_TextPacket textPacket) {
    final sgrCmds = textPacket.text.split(';');
    int index = 0;
    while (index < sgrCmds.length) {
      final sgrCmdStr = sgrCmds[index++];
      final num = int.tryParse(sgrCmdStr, radix: 10);
      if (num == null || num == 0) {
        _fg = _bg = null;
        _style = StyledText.NONE;
      } else if (num == 1) {
        _style = _style | StyledText.BOLD;
      } else if (num == 2) {
        _style = _style | StyledText.DIM;
      } else if (num == 3) {
        _style = _style | StyledText.ITALIC;
      } else if (num == 4) {
        _style = _style | StyledText.UNDERLINE;
      } else if (num == 5) {
        _style = _style | StyledText.BLINK;
      } else if (num == 7) {
        _style = _style | StyledText.REVERSE;
      } else if (num == 8) {
        _style = _style | StyledText.INVISIBLE;
      } else if (num == 9) {
        _style = _style | StyledText.STRIKETHROUGH;
      } else if (num == 22) {
        _style = _style & ~(StyledText.BOLD | StyledText.DIM);
      } else if (num == 23) {
        _style = _style & ~StyledText.ITALIC;
      } else if (num == 24) {
        _style = _style & ~StyledText.UNDERLINE;
      } else if (num == 25) {
        _style = _style & ~StyledText.BLINK;
      } else if (num == 27) {
        _style = _style & ~StyledText.REVERSE;
      } else if (num == 28) {
        _style = _style & ~StyledText.INVISIBLE;
      } else if (num == 29) {
        _style = _style & ~StyledText.STRIKETHROUGH;
      } else if (num == 39) {
        _fg = null;
      } else if (num == 49) {
        _bg = null;
      } else if ((num >= 30) && (num < 38)) {
        _fg = _ansiColors[0][(num - 30)];
      } else if ((num >= 40) && (num < 48)) {
        _bg = _ansiColors[0][(num - 40)];
      } else if ((num >= 90) && (num < 98)) {
        _fg = _ansiColors[1][(num - 90)];
      } else if ((num >= 100) && (num < 108)) {
        _bg = _ansiColors[1][(num - 100)];
      } else if (num == 38 || num == 48) {
        if (index < sgrCmds.length) {
          final isForeground = num == 38;
          final modeCmd = sgrCmds[index++];
          if (modeCmd == '5' && index < sgrCmds.length) {
            final paletteIndex = int.tryParse(sgrCmds[index++], radix: 10)!;
            if (paletteIndex >= 0 && paletteIndex <= 255) {
              if (isForeground) {
                _fg = _palette256[paletteIndex];
              } else {
                _bg = _palette256[paletteIndex];
              }
            }
          }
          if (modeCmd == '2' && index + 2 < sgrCmds.length) {
            final r = int.tryParse(sgrCmds[index++], radix: 10);
            final g = int.tryParse(sgrCmds[index++], radix: 10);
            final b = int.tryParse(sgrCmds[index++], radix: 10);
            if (r != null &&
                g != null &&
                b != null &&
                (r >= 0 && r <= 255) &&
                (g >= 0 && g <= 255) &&
                (b >= 0 && b <= 255)) {
              final c = Color.fromARGB(255, r, g, b);
              if (isForeground) {
                _fg = c;
              } else {
                _bg = c;
              }
            }
          }
        }
      }
    }
  }

  _TextWithAttr _withState(_TextPacket packet) {
    return _TextWithAttr(style: _style, fg: _fg, bg: _bg, text: packet.text);
  }
}

class _TextWithAttr {
  _TextWithAttr({
    this.fg,
    this.bg,
    this.style = StyledText.NONE,
    this.text = '',
  });

  final Color? fg;
  final Color? bg;
  final int style;
  final String text;
}

enum PacketKind {
  eos,
  text,
  incomplete,
  esc,
  unknown,
  sgr,
  oscurl,
}

class _TextPacket {
  _TextPacket({required this.kind});

  PacketKind kind;
  String text = '';
  String url = '';
}

// Removes comments and spaces/newlines from a regex string that were present
// for readability.
RegExp _cleanAndConvertToRegex(String regexText) {
  final RegExp spacesAndComments =
      RegExp(r'^\s+|\s+\n|\s*#[\s\S]*?\n|\n', multiLine: true);
  return RegExp(regexText.replaceAll(spacesAndComments, ''));
}

/// Chunk of styled text stored in a Dart friendly format.
class StyledText {
  const StyledText(
    this.text, {
    this.fgColor,
    this.bgColor,
    this.textStyle = NONE,
    this.url = '',
  });

  factory StyledText.from(_TextWithAttr fragment) {
    return StyledText(
      fragment.text,
      fgColor: fragment.fg,
      bgColor: fragment.bg,
      textStyle: fragment.style,
    );
  }

  static const int NONE = 0;
  static const int BOLD = 1;
  static const int DIM = 2;
  static const int ITALIC = 4;
  static const int UNDERLINE = 8;
  static const int STRIKETHROUGH = 16;
  static const int BLINK = 32;
  static const int REVERSE = 64;
  static const int INVISIBLE = 128;

  final String text;
  final Color? fgColor;
  final Color? bgColor;
  final int textStyle;
  final String url;

  bool get bold => (textStyle & BOLD) == BOLD;
  bool get dim => (textStyle & DIM) == DIM;
  bool get italic => (textStyle & ITALIC) == ITALIC;
  bool get underline => (textStyle & UNDERLINE) == UNDERLINE;
  bool get strikethrough => (textStyle & STRIKETHROUGH) == STRIKETHROUGH;
  bool get blink => (textStyle & BLINK) == BLINK;
  bool get reverse => (textStyle & REVERSE) == REVERSE;
  bool get invisible => (textStyle & INVISIBLE) == INVISIBLE;

  String get style {
    if (fgColor == null && bgColor == null && textStyle == NONE) {
      return '';
    }

    String? decoration;
    if (underline) {
      decoration = 'underline';
    }

    if (strikethrough) {
      decoration =
          (decoration == null) ? 'line-through' : '$decoration line-through';
    }

    return '';
  }
}
