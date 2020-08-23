#include "deviceparameter.h"

DeviceParameter::DeviceParameter(QString code, QString jsonData) :
    code(code), jsonData(jsonData), sync(false)
{
    this->createdAt = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    db = new LocalDatabase();
    network = new Network();
}

DeviceParameter::DeviceParameter(int id, QString code, QString jsonData) :
    id(id), code(code), jsonData(jsonData), sync(false)
{
    this->createdAt = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    db = new LocalDatabase();
    network = new Network();
}

void DeviceParameter::localSave()
{
    QVariantMap map;
    map["code"] = code;
    map["jsonData"] = jsonData;
    map["sync"] = sync;
    map["createdAt"] = createdAt;
    db->insertRecord("devices", map);
}

void DeviceParameter::uploadToServer()
{
    QByteArray jsonData = QJsonDocument(
                this->toJsonObject()
        ).toJson();
    network->uploadDeviceParameter(jsonData);
    connect(network->reply, &QNetworkReply::finished, [=]() {
        if(network->reply->error() == QNetworkReply::NoError){
            QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
            if (obj.value("code").toInt() == 0){
                onSyncSuccess();
            }
        } else {
            logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
        }
    });
}

void DeviceParameter::onSyncSuccess()
{
    QVariantMap setList;
    setList["sync"] = true;

    QVariantMap condition;
    condition["id"] = this->id;
    db->updateRecord("devices", setList, condition);
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

void DeviceParameter::syncToServer()
{
    LocalDatabase *db = new LocalDatabase();
    QStringList fields;
    fields.append("code");
    fields.append("jsonData");
    fields.append("createdAt");

    QVariantMap conditions;
    conditions["sync"] = false;

    QList<QVariantMap> results = db->queryRecords("devices", fields, conditions);
    for (QList<QVariantMap>::iterator it = results.begin(); it != results.end(); ++it) {
        DeviceParameter *deviceParameter = new DeviceParameter(
                    it->value("id").toInt(),
                    it->value("code").toString(),
                    it->value("jsonData").toString()
                    );
        deviceParameter->uploadToServer();
        free(deviceParameter);
    }
}
