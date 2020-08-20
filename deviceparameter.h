#ifndef DEVICEPARAMETER_H
#define DEVICEPARAMETER_H
#include "baseobject.h"
#include <QTime>
#include <QJsonObject>

class DeviceParameter : BaseObject
{
public:
    DeviceParameter(QString code, QString jsonData);
    void localSave();
    bool uploadDeviceParameter();

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

private:
    QString code;
    QString jsonData;
    QString createdAt;
    bool sync;
    QString syncAt;
};

#endif // DEVICEPARAMETER_H
