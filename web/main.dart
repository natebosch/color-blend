import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';

@Component(
    selector: 'color-blend',
    template: '''
    <h1> Color Blend</h1>
    ''')
class ColorBlendApp {}

main() {
  bootstrap(ColorBlendApp);
}
