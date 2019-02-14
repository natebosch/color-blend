class Color {
  final num red;
  final num green;
  final num blue;
  final num alpha;
  factory Color(String input) {
    if (input.startsWith('0x')) {
      return new Color.fromHex(input);
    } else if (input.startsWith('rgba(')) {
      return new Color.fromRgba(input);
    }
    return null;
  }

  factory Color.fromRgba(String input) {
    var rgba = input.substring(5, input.length - 1);
    var parts = rgba.split(',');
    var r = int.parse(parts[0]);
    var g = int.parse(parts[1]);
    var b = int.parse(parts[2]);
    num a = 1;
    if (parts.length >= 4) {
      a = double.parse(parts[3]);
    }
    return new Color._(r, g, b, a);
  }

  factory Color.fromHex(String input) {
    var hex = _canonicalHex(input.substring(2));
    var r = int.parse(hex.substring(0, 2), radix: 16);
    var g = int.parse(hex.substring(2, 4), radix: 16);
    var b = int.parse(hex.substring(4, 6), radix: 16);
    num a = 1;
    if (hex.length == 8) {
      var alphaHex = int.parse(hex.substring(6, 8), radix: 16);
      a = 255 / alphaHex;
    }
    return new Color._(r, g, b, a);
  }

  Color._(this.red, this.green, this.blue, this.alpha);

  Color onBackground(Color background) {
    var a = alpha + background.alpha * (1 - alpha);
    blend(c, bg) => ((1 - alpha) * background.alpha * bg + alpha * c) / a;
    var r = blend(red, background.red);
    var g = blend(green, background.green);
    var b = blend(blue, background.blue);
    return new Color._(r, g, b, a);
  }

  @override
  String toString() {
    var args =
        [red, blue, green, alpha].map((value) => value.round()).join(',');
    return 'rgba($args)';
  }

  String toHexString() =>
      '0x${_toHex(red)}${_toHex(green)}${_toHex(blue)}${_toHex(alpha*255)}';
}

String _toHex(num value) => value.round().toRadixString(16);

/// Transforms a string with 1 or 2 digits per channel into a string with 2
/// digits per channel.
String _canonicalHex(String original) {
  if (original.length > 4) {
    return original;
  }
  return original.splitMapJoin('', onNonMatch: (part) => part * 2);
}
