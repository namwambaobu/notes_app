import 'package:isar/isar.dart';
import 'package:noteapp/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static late Isar isar;
  //INITIALIZE - db
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //list of notes
  final List<Note> currentNotes = [];
  //CREATE - a note and save to db
  Future<void> addNote(String textFromUser) async {
    //craete a new note object
    final newNote = Note()..text = textFromUser;
    //save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
    //re-read from db
    fetchNotes();
  }

  //READ - notes from db
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  //UPDATE - notes on db
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
    }
  }
  //DELETE - notes form db
}
