#include "localdatabase.h"

LocalDatabase::LocalDatabase(const QString dbPath)
{
    db = QSqlDatabase::addDatabase(DB_NAME);
    db.setDatabaseName(dbPath);
    db.open();
    query = new QSqlQuery(db);

    query->exec("create table IF NOT EXISTS vehicles "
              "(id integer primary key AUTOINCREMENT, "
              "name varchar(255) NOT NULL, "
              "iParameter varchar(2048) DEFAULT '[]', "
              "oParameter varchar(2048) DEFAULT '[]', "
              "syncAt DATETIME, UNIQUE(name))");

    query->exec("create table IF NOT EXISTS devices "
              "(id integer primary key AUTOINCREMENT, "
              "vehicleId integer NOT NULL, "
              "code varchar(255) NOT NULL, "
              "iParameter varchar(2048) DEFAULT '{}', "
              "oParameter varchar(2048) DEFAULT '{}', "
              "syncAt DATETIME NULL, UNIQUE(code), "
              "FOREIGN KEY(vehicleId) REFERENCES vehicles(id))");
}

QString LocalDatabase::getLastExecutedQuery()
{
    QString str = query->lastQuery();
    QMapIterator<QString, QVariant> it(query->boundValues());
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
                listValues.append('"' + it->toString() + '"');
        }
    }

    query->prepare("INSERT OR REPLACE INTO " + table + " (" + data.keys().join(",") + ") "
                  "VALUES (" + listValues.join(",") + ")");
    return query->exec();
}



bool LocalDatabase::updateRecord(QString table, QVariantMap data, QVariantMap condition)
{
    query->prepare("UPDATE :table SET (:set_list) "
                  "WHERE :condition");
    query->bindValue(":table", table);

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
    query->bindValue(":set_list", setLists.join(", "));

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
    query->bindValue(":condition", listConditions.join(" AND "));

    return query->exec();
}

bool LocalDatabase::deleteRecord(QString table, QVariantMap condition)
{
    query->prepare("DELETE FROM :table  "
                  "WHERE :list_condition");
    query->bindValue(":table", table);
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
    query->bindValue(":list_condition", listConditions.join(" AND "));
    return query->exec();
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
                    listConditions.append(it.key() + "=" + '"' + it.value().toString() + '"');
            }
        }
        sqlCmd += " WHERE " + listConditions.join(" AND ");
    }
    sqlCmd += order_by != "" ? " ORDER BY " + order_by + " " + (ascOrder? "ASC" : "DESC"): "";
    sqlCmd += limit > 0 ? ";" : " limit " + QString::number(limit) + ";";

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
