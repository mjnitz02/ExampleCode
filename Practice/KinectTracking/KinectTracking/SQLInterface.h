//windows header files
#include <string>
#include <sql.h>
#include <sqlext.h>

#include "TupleList.h"


#ifndef SQLINTERFACE
#define SQLINTERFACE

class SQLInterface{

private:
	string userName, password, serverUrl;
	string connectionInfo;
	string outstr;
	SQLSMALLINT outstrlen;
	SQLHENV env;
	SQLHDBC dbc;
	SQLHSTMT stmt;
	SQLRETURN ret; /* ODBC API return status */


public:
	//constructor
	SQLInterface(string _user, string _pass, string _url);

	//methods
	bool Test();
	
	bool InsertToTable(string _table, TupleList _data);

};

#endif // !VECTOR3