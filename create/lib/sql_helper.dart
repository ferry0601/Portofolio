import 'package:sqflite/sqflite.dart' as sql;


class SQLHelper {
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""
    CREATE TABLE alamat(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama_jalan TEXT,
      kelurahan TEXT,
      kecamatan TEXT,
      provinsi TEXT,
      
    )
    """);
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase('alamat.db', version: 1,
        onCreate: (sql.Database database, int version)async{
      await createTables(database);
      });
  }


  //tambah data
  static Future<int> tambahAlamat(String nama_jalan, String kelurahan, String kecamatan,
  String provinsi) async{
    final db = await SQLHelper.db();
    final data = {'jalan' : nama_jalan,'kelurahan': kelurahan, 'kecamatan': kecamatan, 
                  'provinsi': provinsi};
  return await db.insert('alamat', data);
  }

  //ambil data
  static Future<List<Map<String, dynamic>>> getAlamat() async{
  final db = await SQLHelper.db();
    return db.query('alamat');
  }
}