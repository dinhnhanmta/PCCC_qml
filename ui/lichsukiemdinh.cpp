#include "lichsukiemdinh.hpp"
#include "constant.h"
LichSuKiemDinh::LichSuKiemDinh(QObject *parent) : QObject(parent)
{

}
void LichSuKiemDinh::readRecords()
{
    historyListData.clear();
    historyListTime.clear();
    historyListID.clear();
    QSqlDatabase db;
    if (db.isOpen()) db.close();
    db = QSqlDatabase::addDatabase(DB_NAME);
    db.setDatabaseName(SQL_PATH);
    db.open();
    QSqlQuery query(db);
    query.exec("select * from records where code=\""+settings->defautConfig.getDeviceCode()+"\"");
    QList<QVariant> listResult;
    while( query.next() ) {
        historyListData.append(query.value(3).toString());
        historyListTime.append(query.value(5).toString());
        historyListID.append(query.value(0).toString());
    }

    emit historyChanged();
}
