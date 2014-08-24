
import 'cli_test.dart' as cli_test;
import 'generators_test.dart' as generators_test;

// TODO: integration tests. generate all the samples, run the analyzer over the
// dart code

void main() {
  cli_test.defineTests();
  generators_test.defineTests();
}
