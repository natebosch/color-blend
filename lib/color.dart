class Color {
  final num r;
  final num g;
  final num b;
  final num a;
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
    var red = int.parse(parts[0]);
    var green = int.parse(parts[1]);
    var blue = int.parse(parts[2]);
    var alpha = 1;
    if (parts.length >= 4) {
      alpha = double.parse(parts[3]);
    }
    return new Color._(red, green, blue, alpha);
  }

  factory Color.fromHex(String input) {
    var hex = input.substring(2);
    if (hex.length > 4) {
      var red = int.parse(hex.substring(0, 2), radix: 16);
      var green = int.parse(hex.substring(2, 4), radix: 16);
      var blue = int.parse(hex.substring(4, 6), radix: 16);
      var alpha = 1;
      if (hex.length == 8) {
        var alphaHex = int.parse(hex.substring(6, 8), radix: 16);
        alpha = 255 / alphaHex;
      }
      return new Color._(red, green, blue, alpha);
    } else {
      var red = int.parse('${hex[0]}${hex[0]}', radix: 16);
      var green = int.parse('${hex[1]}${hex[1]}', radix: 16);
      var blue = int.parse('${hex[2]}${hex[2]}', radix: 16);
      var alpha = 1;
      if (hex.length == 4) {
        var alphaHex = int.parse('${hex[3]}${hex[3]}', radix: 16);
        alpha = 255 / alphaHex;
      }
      return new Color._(red, green, blue, alpha);
    }
  }

  Color._(this.r, this.g, this.b, this.a);

  Color onBackground(Color background) {
    var alpha = a + background.a * (1 - a);
    var red = ((1 - a) * background.r * background.a + a * r) / alpha;
    var green = ((1 - a) * background.g * background.a + a * g) / alpha;
    var blue = ((1 - a) * background.b * background.a + a * b) / alpha;
    return new Color._(red, green, blue, alpha);
  }

  @override
  String toString() =>
      '0x${r.round().toRadixString(16)}${g.round().toRadixString(16)}'
      '${b.round().toRadixString(16)}${(a*255).round().toRadixString(16)}';
}
