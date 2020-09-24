#ifndef LICHSUKIEMDINH_H
#define LICHSUKIEMDINH_H

#include <QObject>
#include "localdatabase.h"
#include "baseobject.h"
class LichSuKiemDinh : public QObject,BaseObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList q_historyTime READ getHistoryTime NOTIFY historyChanged)
    Q_PROPERTY(QStringList q_historyData READ getHistoryData NOTIFY historyChanged)
    Q_PROPERTY(QStringList q_historyID READ getHistoryID NOTIFY historyChanged)
public:
    explicit LichSuKiemDinh(QObject *parent = nullptr);
    Q_INVOKABLE void readRecords();

    QStringList getHistoryTime(){return historyListTime;}
    QStringList getHistoryData(){return historyListData;}
    QStringList getHistoryID(){return historyListID;}

private:
    QStringList historyListData;
    LocalDatabase * database;
    QStringList historyListTime;
    QStringList historyListID;
signals:
    void historyChanged();

};

#endif // LICHSUKIEMDINH_H
