import 'package:test/test.dart';
import 'package:{{projectName}}/math/math.dart';

main() {
  // test that doesn't require a browser
  group('vm test', () {
    test('math', () {
      expect(Math.doubleIt(2), equals(4));
    });
  });
}