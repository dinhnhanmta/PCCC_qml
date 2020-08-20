#include "localdatabase.h"

LocalDatabase::LocalDatabase(const QString dbPath)
{
    db = QSqlDatabase::database(DB_NAME);
    db.setDatabaseName(dbPath);
    db.open();
    if (db.tables().length() == 0){
        QSqlQuery query;
        query.exec("create table devices "
                  "(id integer primary key AUTOINCREMENT, "
                  "code varchar(20), "
                  "jsonData varchar(1024), "
                   "sync TINYINT, "
                   "createdAt DATETIME, "
                  "syncAt DATETIME)");
    }
}

bool LocalDatabase::insertRecord(QString table, QVariantMap data)
{
    QSqlQuery query;
    query.prepare("INSERT INTO :table (:list_column) "
                  "VALUES (:list_value)");
    query.bindValue(":table", table);
    query.bindValue(":list_column", data.keys().join(","));
    QList<QString> listValues;
    for (QList<QVariant>::iterator it = data.values().begin(); it != data.values().end(); ++it) {
        switch (it->userType())
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
                listValues.append('"' + it->toString() + '"');
        }
    }
    query.bindValue(":list_value", listValues.join(","));
    return query.exec();
}

bool LocalDatabase::updateRecord(QString table, QVariantMap data, QVariantMap condition)
{
    QSqlQuery query;
    query.prepare("UPDATE :table SET (:set_list) "
                  "WHERE :condition");
    query.bindValue(":table", table);

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
                setLists.append(iter.key() + "=" + '"' + iter.value().toString() + '"');
        }
    }
    query.bindValue(":set_list", setLists.join(", "));

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
                listConditions.append(it.key() + "=" + '"' + it.value().toString() + '"');
        }
    }
    query.bindValue(":condition", listConditions.join(" AND "));

    return query.exec();
}

bool LocalDatabase::deleteRecord(QString table, QVariantMap condition)
{
    QSqlQuery query;
    query.prepare("DELETE FROM :table  "
                  "WHERE :list_condition");
    query.bindValue(":table", table);
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
                listConditions.append(it.key() + "=" + '"' + it.value().toString() + '"');
        }
    }
    query.bindValue(":list_condition", listConditions.join(" AND "));
    return query.exec();
}

QSqlQuery LocalDatabase::buildQueryCmd(
        QString table, QStringList fields,
        QVariantMap condition, QString order_by="",
        bool ascOrder = false, int limit = 0
        ){
    QString sqlCmd = "SELECT :fields FROM :table";
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
                    listConditions.append(it.key() + "=" + '"' + it.value().toString() + '"');
            }
        }
        sqlCmd += " WHERE :list_condition";
    }
    sqlCmd += order_by != "" ? " ORDER BY " + order_by + " " + (ascOrder? "ASC" : "DESC"): "";
    sqlCmd += limit > 0 ? ";" : " limit " + QString::number(limit) + ";";

    QSqlQuery query;
    query.prepare(sqlCmd);
    query.bindValue(":table", table);
    query.bindValue(":fields", fields.join(", "));
    if (condition.size() > 0){
        query.bindValue(":list_condition", listConditions.join(" AND "));
    }
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
        for (int i = 0; i < fields.length(); i++) {
            result[fields[i]] = query.value(i);
        }
        listResult.append( result );
    }
    return listResult;
}

QVariantMap LocalDatabase::queryRecord(QString table, QStringList fields, QVariantMap condition, QString order_by="",
                                       bool ascOrder = false)
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
