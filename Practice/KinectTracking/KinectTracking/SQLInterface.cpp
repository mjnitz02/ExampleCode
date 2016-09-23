#include "stdafx.h"
#include "SQLInterface.h"

using namespace std;

SQLInterface::SQLInterface(string _user, string _pass, string _url){

	userName = _user;
	password = _pass;
	serverUrl = _url;

	connectionInfo = "user id=" + userName + ";"
		+ "password=" + password + ";"
		+ "server=" + serverUrl + ";"
		+ "Trusted_Connection=yes;connection timeout=30;";
}

//methods
bool SQLInterface::Test() {
	bool success = false;

	// Allocate an environment handle
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
	// We want ODBC 3 support
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
	// Allocate a connection handle
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);

	// Connect to the DSN mydsn
	ret = false;
	//SQLDriverConnect(dbc, NULL, connectionInfo.c_str, SQL_NTS,
	//	outstr.c_str, 1024, &outstrlen, SQL_DRIVER_COMPLETE);

	if (SQL_SUCCEEDED(ret)) { //begin inserting data!
		success = true;
		SQLDisconnect(dbc);		// disconnect from driver
	}
	else {
		success = false;
	}
	// free up allocated handles
	SQLFreeHandle(SQL_HANDLE_DBC, dbc);
	SQLFreeHandle(SQL_HANDLE_ENV, env);

	return success;
}

bool SQLInterface::InsertToTable(string _table, TupleList _data){
	bool success = false;

	// Allocate an environment handle
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
	// We want ODBC 3 support
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
	// Allocate a connection handle
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);

	// Connect to the DSN mydsn
	ret = false;
		//SQLDriverConnect(dbc, NULL, connectionInfo.c_str, SQL_NTS,
		//outstr.c_str, 1024, &outstrlen, SQL_DRIVER_COMPLETE);

	if (SQL_SUCCEEDED(ret)) { //begin inserting data!

		string command = "INSERT INTO " + _table + "(";

		_data.Reset();
		tuple<string, string> vals = _data.next();
		while (vals != tuple<string, string>(NULL, NULL)) {
			command += get<0>(vals) +",";
		}
		command += ") VALUES (";

		_data.Reset();
		vals = _data.next();
		while (vals != tuple<string, string>(NULL, NULL)) {
			command += "@" + get<1>(vals) +",";
		}
		command += ")";

		//execute the command
		//stmt = command.c_str;
		//SQLRETURN result = SQLExecute(stmt);

		success = true;
		SQLDisconnect(dbc);		// disconnect from driver
	}
	else {
		success = false;
	}
	// free up allocated handles
	SQLFreeHandle(SQL_HANDLE_DBC, dbc);
	SQLFreeHandle(SQL_HANDLE_ENV, env);

	return success;
}