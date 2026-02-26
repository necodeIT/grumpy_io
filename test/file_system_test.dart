import 'package:test/test.dart';
import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

void main() {
  group('File System', () {
    group('Models', () {
      group('IoPath', () {
        test('saves value and returns it', () {
          final path = const IoPath('test');
          expect(path.value, 'test');
        });

        test('toString returns value', () {
          final path = const IoPath('test');
          expect(path.toString(), 'test');
        });

        test('IoPath to Uri', () {
          final path = const IoPath('test');
          final uri = path.toUri();
          expect(uri, Uri.parse('test'));
        });

        test('Uri to IoPath', () {
          final uri = Uri.parse('test');
          final path = IoPath.fromUri(uri);
          expect(path.value, 'test');
        });

        test('IoPath + operator', () {
          final path1 = const IoPath('test');
          final path2 = const IoPath('file');
          final combined = path1 + path2;
          expect(combined.value, 'tesfile');
        });

        test('IoPath / operator', () {
          final path1 = const IoPath('test');
          final path2 = const IoPath('file');
          final combined = path1 / path2;
          expect(combined.value, 'test/file');
        });
      });

      group('FsMetadata', () {});
    });

    group('Services', () {
      group('FileSystemService', () {
        final fs = FileSystemService();

        test('writeBytes() creates a file', () async {
          final path = const IoPath('test_file.txt');
          final content = 'Hello, World!';
          final result = await fs.writeBytes(
            path,
            content.convert.toUtf8Bytes(),
          );
          expect(result.isOk, true);
          final exists = await fs.exists(path);
          expect(exists.isOk, true);
          expect(exists.valueOrNull, true);
        });

        test('exists() checks if a file exists', () async {
          final path = const IoPath('test_file.txt');
          final exists = await fs.exists(path);
          expect(exists.isOk, true);
          expect(exists.valueOrNull, true);
        });

        test('readBytes() reads a file', () async {
          final path = const IoPath('test_file.txt');
          final bytes = await fs.readBytes(path);

          expect(bytes.isOk, true);
          final content = bytes.valueOrNull!.convert.toUtf8String();
          expect(content, 'Hello, World!');
        });

        test('move() moves a file', () async {
          final source = const IoPath('test_file.txt');
          final destination = const IoPath('moved_test_file.txt');

          final result = await fs.move(source, destination);
          expect(result.isOk, true);

          final existsSource = await fs.exists(source);
          final existsDestination = await fs.exists(destination);
          expect(existsSource.isOk, true);
          expect(existsSource.valueOrNull, false);
          expect(existsDestination.isOk, true);
          expect(existsDestination.valueOrNull, true);
        });

        test('copy() copies a file', () async {
          final source = const IoPath('moved_test_file.txt');
          final destination = const IoPath('copied_test_file.txt');

          final result = await fs.copy(source, destination);
          expect(result.isOk, true);

          final existsSource = await fs.exists(source);
          final existsDestination = await fs.exists(destination);
          expect(existsSource.isOk, true);
          expect(existsSource.valueOrNull, true);
          expect(existsDestination.isOk, true);
          expect(existsDestination.valueOrNull, true);
        });

        test('createDirectory() creates a directory', () async {
          final path = const IoPath('test_directory');

          final result = await fs.createDirectory(path);
          expect(result.isOk, true);

          final exists = await fs.exists(path);
          expect(exists.isOk, true);
          expect(exists.valueOrNull, true);
        });

        test('list() lists contents of a directory', () async {
          final path = const IoPath('test_directory');
          final copy = const IoPath('copied_test_file.txt');
          final moved = const IoPath('moved_test_file.txt');

          final result1 = await fs.move(copy, path / copy);
          final result2 = await fs.move(moved, path / moved);
          expect(result1.isOk, true);
          expect(result2.isOk, true);

          final contents = await fs.list(path);
          expect(contents.isOk, true);
          expect(contents.valueOrNull, contains(copy));
          expect(contents.valueOrNull, contains(moved));
        });

        test('delete() deletes a file', () async {
          final path = const IoPath('test_file.txt');
          final content = 'Hello, World!';

          final writeResult = await fs.writeBytes(
            path,
            content.convert.toUtf8Bytes(),
          );
          expect(writeResult.isOk, true);

          final deleteResult = await fs.delete(path);
          expect(deleteResult.isOk, true);

          final exists = await fs.exists(path);
          expect(exists.isOk, true);
          expect(exists.valueOrNull, false);
        });

        test('delete() recursively deletes a directory', () async {
          final path = const IoPath('test_directory');
          final copy = path / const IoPath('copied_test_file.txt');
          final moved = path / const IoPath('moved_test_file.txt');

          final result = await fs.delete(path, recursive: true);
          expect(result.isOk, true);

          final exists = await fs.exists(path);
          final copyExits = await fs.exists(copy);
          final movedExists = await fs.exists(moved);
          expect(exists.isOk, true);
          expect(exists.valueOrNull, false);
          expect(copyExits.isOk, true);
          expect(copyExits.valueOrNull, false);
          expect(movedExists.isOk, true);
          expect(movedExists.valueOrNull, false);
        });
      });
    });
  });
}
