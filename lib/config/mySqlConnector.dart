import 'package:mysql_client/mysql_client.dart';
import 'package:thisone/config/dbInfo.dart';

// MySQL 접속
Future<MySQLConnection> dbConnector() async {
  print("Connecting to mysql server...");

  // MySQL 접속 설정
  final conn = await MySQLConnection.createConnection(
    host: DbInfo.hostName,
    port: DbInfo.portNumber,
    userName: DbInfo.UserName,
    password: DbInfo.password,
    databaseName: DbInfo.dbName, // optional
  );

  await conn.connect();


  // final conn = await MySQLConnection.createConnection
  // (host: 'http://localhost/', port: 3306, userName: 'admin', password: '12',
//       databaseName: 'testdb'  //optional
//   );



  print("sql Connected");

  return conn;
}


// // 전체 조회
// Future<void> selectMember() async {
//   final conn = await dbConnector();
//   IResultSet? result;

//   try {
//     result = await conn.execute("SELECT * FROM users");

//     if (result.isNotEmpty) {
//       for (final row in result.rows) {
//         print(row.assoc());
//       }
//     }
//   } catch (e) {
//     print('Error : $e');
//   } finally {
//     await conn.close();
//   }
// }