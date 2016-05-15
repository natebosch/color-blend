import 'package:angular2/angular2.dart';

import 'color.dart';

@Component(
    selector: 'color-blend',
    template: '''
    If you put {{color}} on {{background}} you'd get {{result}}.
    ''')
class ColorBlendApp {
  final String background = '0xFFF';
  final String color = 'rgba(34,34,34,0.54)';

  String get result => new Color(color).onBackground(new Color(background));
}
