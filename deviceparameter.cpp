#include "deviceparameter.h"

DeviceParameter::DeviceParameter(QString code, QString jsonData) :
    code(code), jsonData(jsonData), sync(false)
{
    this->createdAt = QDateTime::currentDateTime().toString();
}

void DeviceParameter::localSave()
{

}

QString DeviceParameter::getCode() const
{
    return code;
}

void DeviceParameter::setCode(const QString &value)
{
    code = value;
}

QString DeviceParameter::getJsonData() const
{
    return jsonData;
}

void DeviceParameter::setJsonData(const QString &value)
{
    jsonData = value;
}

bool DeviceParameter::getSync() const
{
    return sync;
}

void DeviceParameter::setSync(bool value)
{
    sync = value;
}

QString DeviceParameter::getCreatedAt() const
{
    return createdAt;
}

void DeviceParameter::setCreatedAt(const QString &value)
{
    createdAt = value;
}

QString DeviceParameter::getSyncAt() const
{
    return syncAt;
}

void DeviceParameter::setSyncAt(const QString &value)
{
    syncAt = value;
}

QJsonObject DeviceParameter::toJsonObject()
{
    QVariantMap mapData;
    mapData["code"] = code;
    mapData["jsonData"] = jsonData;
    return QJsonObject::fromVariantMap(mapData);
}
