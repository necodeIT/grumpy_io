// IoPath also supports equality with String, so we need to ignore unrelated type equality checks in some tests
// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

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
          expect(combined.value, 'testfile');
        });

        test('IoPath / operator', () {
          final path1 = const IoPath('test');
          final path2 = const IoPath('file');
          final combined = path1 / path2;
          expect(combined.value, 'test/file');
        });

        test('IoPath == operator (IoPath)', () {
          final path1 = const IoPath('test');
          final path2 = const IoPath('test');
          final path3 = const IoPath('other');
          expect(path1 == path2, true);
          expect(path1 == path3, false);
        });

        test('IoPath == operator (String)', () {
          final path1 = const IoPath('test');
          expect(path1 == 'test', true);
          expect(path1 == 'other', false);
        });

        test('IoPath == operator (other types)', () {
          final path1 = const IoPath('test');
          expect(path1 == 123, false);
        });
      });

      group('FsMetadata', () {});
    });

    group('Services', () {
      group(
        'DefaultFileSystemService',
        () {
          final fs = DefaultFileSystemService();

          final file0 = File('build/test/files/file0.txt');
          final file1 = File('build/test/files/file1.txt');
          final file2 = File('build/test/files/file2.txt');

          final testPath = const IoPath('build/test/files');
          final filePath0 = testPath / const IoPath('file0.txt');
          final filePath1 = testPath / const IoPath('file1.txt');
          final filePath2 = testPath / const IoPath('file2.txt');

          final Map<File, String?> requiredFiles = {
            file0: 'Hello, World!',
            file1: null,
            file2: null,
          };

          setUp(() async {
            Directory('build/test/files').createSync(recursive: true);
            for (final entry in requiredFiles.entries) {
              if (entry.value != null) {
                await entry.key.writeAsString(entry.value!);
              } else {
                entry.key.createSync();
              }
            }
          });

          tearDown(() async {
            final directory = Directory('build/test/files');

            if (!directory.existsSync()) {
              return;
            }
            directory.deleteSync(recursive: true);
          });

          test('writeBytes() creates a file', () async {
            final path = testPath / const IoPath('file3.txt');
            final content = 'Hello, World!';
            final result = await fs.writeBytes(
              path,
              content.convert.toUtf8Bytes(),
            );
            expect(result.isOk, true);

            final file = File(path.value);

            expect(file.existsSync(), true);
            expect(file.readAsStringSync(), 'Hello, World!');
          });

          test('exists() checks if a file exists', () async {
            final exists = await fs.exists(filePath0);
            expect(exists.isOk, true);
            expect(exists.valueOrNull, true);
          });

          test('readBytes() reads a file', () async {
            final bytes = await fs.readBytes(filePath0);

            expect(bytes.isOk, true);
            final content = bytes.valueOrNull!.convert.toUtf8String();
            expect(content, requiredFiles[file0]);
          });

          test('move() moves a file', () async {
            final source = filePath0;
            final destination = testPath / const IoPath('moved_file0.txt');

            final result = await fs.move(source, destination);
            expect(result.isOk, true);

            final sourceFile = file0;
            final destinationFile = File(destination.value);

            expect(sourceFile.existsSync(), false);
            expect(destinationFile.existsSync(), true);
            expect(destinationFile.readAsStringSync(), requiredFiles[file0]);
          });

          test('copy() copies a file', () async {
            final source = filePath0;
            final destination = testPath / const IoPath('copied_file0.txt');

            final result = await fs.copy(source, destination);
            expect(result.isOk, true);

            final sourceFile = file0;
            final destinationFile = File(destination.value);

            expect(sourceFile.existsSync(), true);
            expect(sourceFile.readAsStringSync(), requiredFiles[file0]);
            expect(destinationFile.existsSync(), true);
            expect(destinationFile.readAsStringSync(), requiredFiles[file0]);
          });

          test('createDirectory() creates a directory', () async {
            final path = testPath / const IoPath('test_directory');

            final result = await fs.createDirectory(path);
            expect(result.isOk, true);

            final directory = Directory(path.value);
            expect(directory.existsSync(), true);
          });

          test('list() lists contents of a directory', () async {
            final contents = await fs.list(testPath);
            expect(contents.isOk, true);
            expect(contents.valueOrNull, contains(filePath0));
            expect(contents.valueOrNull, contains(filePath1));
            expect(contents.valueOrNull, contains(filePath2));
          });

          test('delete() deletes a file', () async {
            final deleteResult = await fs.delete(filePath0);
            expect(deleteResult.isOk, true);

            expect(file0.existsSync(), false);
          });

          test('delete() recursively deletes a directory', () async {
            final result = await fs.delete(testPath, recursive: true);
            expect(result.isOk, true);

            final directory = Directory(testPath.value);
            expect(directory.existsSync(), false);
          });
        },
        onPlatform: {
          'windows': const Timeout.factor(2),
          'linux': const Timeout.factor(2),
          'mac-os': const Timeout.factor(2),
          'browser': const Skip(
            'File system operations are not supported on the web',
          ),
        },
      );
    });
  });
}
