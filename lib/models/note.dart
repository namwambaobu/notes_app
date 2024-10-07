import 'package:isar/isar.dart';

//the line below is needed to generate a file
// run: dart run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
