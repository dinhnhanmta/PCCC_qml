#ifndef LOCALDATABASE_H
#define LOCALDATABASE_H

#include <QtSql>
#include "constant.h"
class LocalDatabase
{
public:
    LocalDatabase(const QString sqlPath = SQL_PATH);
    bool insertRecord(QString table, QVariantMap data);
    bool updateRecord(QString table, QVariantMap data, QVariantMap condition);
    bool deleteRecord(QString table, QVariantMap condition);
    QList<QVariantMap> queryRecords(QString table, QStringList fields,
                                    QVariantMap condition,
                                    QString order_by = "", bool ascOrder = false);
    QVariantMap queryRecord(QString table, QStringList fields,
                            QVariantMap condition,
                            QString order_by, bool ascOrder);

private:
    QSqlQuery buildQueryCmd(QString table, QStringList fields,
                            QVariantMap condition, QString order_by,
                            bool ascOrder, int limit);
    QSqlDatabase db;
};

#endif // LOCALDATABASE_H
