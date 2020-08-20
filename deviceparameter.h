#ifndef DEVICEPARAMETER_H
#define DEVICEPARAMETER_H
#include "baseobject.h"
#include "localdatabase.h"
#include "network.h"
#include <QTime>
#include <QJsonObject>

class DeviceParameter : QObject, BaseObject
{
    Q_OBJECT
public:
    DeviceParameter(QString code, QString jsonData);
    DeviceParameter(int id, QString code, QString jsonData);


    QString getCode() const;
    void setCode(const QString &value);

    QString getJsonData() const;
    void setJsonData(const QString &value);

    bool getSync() const;
    void setSync(bool value);

    QString getCreatedAt() const;
    void setCreatedAt(const QString &value);

    QString getSyncAt() const;
    void setSyncAt(const QString &value);

    QJsonObject toJsonObject();
    static void syncToServer();

    void uploadToServer();
    void localSave();

private:
    int id;
    QString code;
    QString jsonData;
    QString createdAt;
    LocalDatabase *db;
    Network *network;
    bool sync;
    QString syncAt;
    void onSyncSuccess();
};

#endif // DEVICEPARAMETER_H
