#include "localdatabase.h"

LocalDatabase::LocalDatabase()
{
    QSqlDatabase db = openDabase();
    QSqlQuery query(db);

    query.exec("create table IF NOT EXISTS deviceModels "
              "(name varchar(255) NOT NULL, "
              "iParameter varchar(2048) DEFAULT '[]', "
              "syncAt DATETIME, UNIQUE(name))");

    query.exec("create table IF NOT EXISTS devices "
              "(deviceModelName varchar(255) NOT NULL, "
              "code varchar(255) NOT NULL, "
              "iParameter varchar(2048) DEFAULT '{}', "
              "syncAt DATETIME NULL, UNIQUE(code))");

    query.exec("create table IF NOT EXISTS records "
              "(id INTEGER NOT NULL UNIQUE,"
              "deviceModelName varchar(255) NOT NULL, "
              "code varchar(255) NOT NULL, "
              "data TEXT DEFAULT '[]', "
              "sampleRate INT DEFAULT 1000, "
              "createdAt DATETIME DEFAULT (datetime('now','localtime')),"
              "PRIMARY KEY(\"id\" AUTOINCREMENT))");

}

QSqlDatabase LocalDatabase::openDabase(){
    QSqlDatabase db;
    if (db.isOpen()) db.close();
    db = QSqlDatabase::addDatabase(DB_NAME);
    db.setDatabaseName(SQL_PATH);
    db.open();
    return db;
}

QString LocalDatabase::getLastExecutedQuery(QSqlQuery query)
{
    QString str = query.lastQuery();
    QMapIterator<QString, QVariant> it(query.boundValues());
    while (it.hasNext()){
        it.next();
        str.replace(it.key(),it.value().toString());
    }
    return str;
}

bool LocalDatabase::insertRecord(QString table, QVariantMap data)
{
    QList<QString> listValues;
    for (QVariantMap::const_iterator it = data.begin(); it != data.end(); ++it) {
        switch (it.value().userType())
        {
            case QMetaType::Bool:
                listValues.append(it->toBool()?"1":"0");
                break;
            case QMetaType::Int:
            case QMetaType::UInt:
            case QMetaType::LongLong:
            case QMetaType::ULongLong:
                listValues.append(it->toString());
                break;
            case QMetaType::QString:
                listValues.append("'" + it->toString() + "'");
        }
    }
    QSqlDatabase db = openDabase();
    QSqlQuery query(db);

    return query.exec("INSERT OR REPLACE INTO " + table + " (" + data.keys().join(",") + ") "
                                                                                         "VALUES (" + listValues.join(",") + ")");
}

bool LocalDatabase::updateRecord(QString table, QVariantMap data, QVariantMap condition)
{
    QList<QString> setLists;
    for(QVariantMap::const_iterator iter = data.begin(); iter != data.end(); ++iter) {
        switch (iter.value().userType())
        {
            case QMetaType::Bool:
                setLists.append(iter.key() + "=" + (iter.value().toBool()?"1":"0"));
                break;
            case QMetaType::Int:
            case QMetaType::UInt:
            case QMetaType::LongLong:
            case QMetaType::ULongLong:
                setLists.append(iter.key() + "=" + iter.value().toString());
                break;
            case QMetaType::QString:
                setLists.append(iter.key() + "=" + "'" + iter.value().toString() + "'");
        }
    }

    QList<QString> listConditions;
    for (QVariantMap::const_iterator it = condition.begin(); it != condition.end(); ++it) {
        switch (it.value().userType())
        {
            case QMetaType::Bool:
                listConditions.append(it.key() + "=" + (it.value().toBool()?"1":"0"));
                break;
            case QMetaType::Int:
            case QMetaType::UInt:
            case QMetaType::LongLong:
            case QMetaType::ULongLong:
                listConditions.append(it.key() + "=" + it.value().toString());
                break;
            case QMetaType::QString:
                listConditions.append(it.key() + "=" + "'" + it.value().toString() + "'");
        }
    }
    QSqlDatabase db = openDabase();
    QSqlQuery query(db);
    return query.exec("UPDATE " + table + " SET " + setLists.join(", ") +
                      "WHERE " + listConditions.join(" AND "));
}

bool LocalDatabase::deleteRecord(QString table, QVariantMap condition)
{
    QList<QString> listConditions;
    for (QVariantMap::const_iterator it = condition.begin(); it != condition.end(); ++it) {
        switch (it.value().userType())
        {
            case QMetaType::Bool:
                listConditions.append(it.key() + "=" + (it.value().toBool()?"1":"0"));
                break;
            case QMetaType::Int:
            case QMetaType::UInt:
            case QMetaType::LongLong:
            case QMetaType::ULongLong:
                listConditions.append(it.key() + "=" + it.value().toString());
                break;
            case QMetaType::QString:
                listConditions.append(it.key() + "=" + "'" + it.value().toString() + "'");
        }
    }
    QSqlDatabase db = openDabase();
    QSqlQuery query(db);
    return query.exec("DELETE FROM " + table  +
                      " WHERE " + listConditions.join(" AND "));
}

QSqlQuery LocalDatabase::buildQueryCmd(
        QString table, QStringList fields,
        QVariantMap condition, QString order_by="",
        bool ascOrder = false, int limit = 0
        ){
    QString sqlCmd = "SELECT " + fields.join(", ") + " FROM " + table;
    QList<QString> listConditions;
    if (condition.size() > 0){
        for (QVariantMap::const_iterator it = condition.begin(); it != condition.end(); ++it) {
            switch (it.value().userType())
            {
                case QMetaType::Bool:
                    listConditions.append(it.key() + "=" + (it.value().toBool()?"1":"0"));
                    break;
                case QMetaType::Int:
                case QMetaType::UInt:
                case QMetaType::LongLong:
                case QMetaType::ULongLong:
                    listConditions.append(it.key() + "=" + it.value().toString());
                    break;
                case QMetaType::QString:
                    listConditions.append(it.key() + "=" + "'" + it.value().toString() + "'");
            }
        }
        sqlCmd += " WHERE " + listConditions.join(" AND ");
    }
    sqlCmd += order_by != "" ? " ORDER BY " + order_by + " " + (ascOrder? "ASC" : "DESC"): "";
    sqlCmd += limit > 0 ? ";" : " limit " + QString::number(limit) + ";";

    QSqlDatabase db = openDabase();
    QSqlQuery query(db);
    query.prepare(sqlCmd);
    return query;
}

QList<QVariantMap> LocalDatabase::queryRecords(
        QString table, QStringList fields,
        QVariantMap condition, QString order_by,
        bool ascOrder)
{
    QSqlQuery query = buildQueryCmd(table, fields, condition, order_by, ascOrder);
    query.exec();
    QList<QVariantMap> listResult;
    while( query.next() ) {
        QVariantMap result;
        qDebug()<<"ressss"<<query.value(0);
        for (int i = 0; i < fields.length(); i++) {
            result[fields[i]] = query.value(i);
        }
        listResult.append( result );
    }
    return listResult;
}

QVariantMap LocalDatabase::queryRecord(QString table, QStringList fields, QVariantMap condition, QString order_by,
                                       bool ascOrder)
{
    QSqlQuery query = buildQueryCmd(table, fields, condition, order_by, ascOrder, 1);
    query.exec();
    QVariantMap result;
    query.first();
    for (int i = 0; i < fields.length(); i++) {
        result[fields[i]] = query.value(i);
    }
    return result;
}
