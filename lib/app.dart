import 'package:angular2/angular2.dart';

import 'color.dart';

@Component(
    selector: 'color-blend',
    template: '''
    If you put {{color}} on {{background}} you'd get {{result}}.<br/>
    <color-preview [color]="result">
    </color-preview>
    ''',
    directives: const [ColorPreview,])
class ColorBlendApp {
  final String background = '0xFFF';
  final String color = 'rgba(34,34,34,0.54)';

  Color get result => new Color(color).onBackground(new Color(background));
}

@Component(
    selector: 'color-preview',
    template: '''
    Color: {{color}}
    ''',
    styleUrls: const ['color_preview.css'],
    directives: const [])
class ColorPreview {
  @Input()
  @HostBinding('style.background-color')
  Color color;
}
