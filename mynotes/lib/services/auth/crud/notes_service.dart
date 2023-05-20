import 'package:flutter/foundation.dart';
import 'package:mynotes/services/auth/crud/crud_exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class NotesService {
  Database? _db;

  // Updating existing notes: Future<DatabaseNote> updateNote({}) async {}
  Future<DatabaseNote> updateNote({
    required DatabaseNote note,
    required String text,
  }) async {
    final db = _getDatabaseOrThrow();

    await getNote(id: note.id);
    final updatesCount = await db.update(noteTable, {
      textColumn: text,
      isSyncedWithCloudColumn: 0,
    });

    if (updatesCount == 0) {
      throw CouldNotUpdateNote();
    } else {
      return await getNote(id: note.id)
    }
  }

  // Fetching all notes: Future<Iterable<DatabaseNote>> getAllNotes() async {}
  Future<Iterable<DatabaseNote>> getAllNotes() async {
    final db = _getDatabaseOrThrow();
    final notes = await db.query(noteTable);

    return notes.map((noteRow) => DatabaseNote.fromRow(noteRow));
  }

  // Fetching a specific note: Future<DatabaseNote> getNote({required int id}) async {}
  Future<DatabaseNote> getNote({required int id}) async {
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (notes.isEmpty) {
      throw CouldNotFindNote();
    } else {
      return DatabaseNote.fromRow(notes.first); // Which is 1 row
    }
  }

  // Ability to delete all notes: Future<int> deleteAllNotes() async {}
  Future<int> deleteAllNotes() async {
    final db = _getDatabaseOrThrow();
    return await db.delete(noteTable);
  }

  // Allow notes to be deleted: Future<void> deleteNote({required int id}) async {}
  Future<void> deleteNote({required int id}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteNote();
    }
  }

  // Allow creation of new notes: Future<DatabaseNote> createNote({required DatabaseUser owner}) async {}
  Future<DatabaseNote> createNote({required DatabaseUser owner}) async {
    final db = _getDatabaseOrThrow();
    // In here, when we are trying to create a note for that particular DB user
    // we need to make sure that that DB user is actually inside the DB
    final dbUser = await getUser(email: owner.email);
    // Now we need to make sure the ID you provided in DatabaseUser is actually
    // an ID of an existing user in our database
    if (dbUser != owner) {
      throw CouldNotFindUser();
    }

    const text = '';
    // Create the note
    final noteId = await db.insert(noteTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1,
    });

    // Now we are going to return a new note instance where its ID is the ID
    // of the inserted note
    final note = DatabaseNote(
      id: noteId,
      userId: owner.id,
      text: text,
      isSyncedWithCloud: true,
    );

    return note;
  }

  // Ability to fetch users: Future<DatabaseUser> getUser({required String email}) async {}
  Future<DatabaseUser> getUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    // We need to make sure before getting the user that this email
    // already exist
    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DatabaseUser.fromRow(results.first); // Which is 1 row
    }
  }

  // Allowing users to be created: Future<DatabaseUser> createUser({required String email}) async {}
  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    // We need to make sure before creating the user that this email
    // does not already exist
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  // Allowing users to be deleted: Future<void> deleteUser({required String email}) async {}
  Future<void> deleteUser({required String email}) async {
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUser();
    }
  }

  // Generic function to throw an error if the database is not open or
  // return the database.
  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      return db;
    }
  }

  // Let us close our DB: Future<void> close() async
  Future<void> close() async {
    // We shouln't allow any person to close the database it is not open
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpen();
    } else {
      await db.close();
      _db = null;
    }
  }

  // Let us open our DB: Future<void> open() async
  Future<void> open() async {
    // Let us do a test and see If this database is already opened.
    // If we have an instance of this database, then we can assume that
    // this database file is opened and we don't have to reopen it again,
    // and throw an exception
    if (_db != null) {
      throw DatabseAlreadyOpenException();
    }
    // Let us go ahead and get the document directory
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      // Let us create the tables
      // Using triple quotation marks allows you to add any string inside
      // without having to escape any character.
      await db.execute(createUserTable);
      await db.execute(createNoteTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectory();
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });

  // When talking with database, we are going to read like hash tables for
  // every row that we read from a table. Every user inside that database table
  // called user is going to be represented by this object: Map<String, Object?>
  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  // To be able to print out these things in our console, we need to
  // implement toString method
  @override
  String toString() => 'Person, ID = $id, email = $email';

  // Also what we need ti implement is equality functionality
  // If for example, person X is equal to person Y, then read person Y's notes
  @override
  // covariant is a keyword in dart that allow you to change the behavior of
  // input parameter so that they do not necessarily conform to the signature
  // of that parameter in the super class
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  // This makes the id is our primary key os this class
  int get hashCode => id.hashCode;
}

class DatabaseNote {
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  DatabaseNote({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });

  DatabaseNote.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        isSyncedWithCloud =
            (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;

  @override
  String toString() =>
      'Note, ID = $id, userId = $userId, isSyncedWithCloud = $isSyncedWithCloud, text = $text';

  @override
  bool operator ==(covariant DatabaseNote other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const dbName = 'notes.db'; // DB file name
const noteTable = 'note';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
	      "id"	INTEGER NOT NULL,
	      "email"	TEXT NOT NULL UNIQUE,
	      PRIMARY KEY("id" AUTOINCREMENT)
      );''';
const createNoteTable = '''CREATE TABLE IF NOT EXISTS "notes" (
	      "id"	INTEGER NOT NULL UNIQUE,
	      "user_id"	INTEGER NOT NULL,
	      "text"	TEXT,
	      "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
	      FOREIGN KEY("user_id") REFERENCES "user"("id"),
	      PRIMARY KEY("id" AUTOINCREMENT)
      );''';
