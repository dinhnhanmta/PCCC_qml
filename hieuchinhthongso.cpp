#include "hieuchinhthongso.hpp"
#include <QDateTime>
HieuChinhThongSo::HieuChinhThongSo()
{

    network = new Network();
    localDatabase = new LocalDatabase();
}

void HieuChinhThongSo::readJson()
{
    database = new LocalDatabase();
    QStringList fields;
    fields.append("vehicleId");
    QVariantMap conditions;
    conditions["code"] = settings->defautConfig.getDeviceCode();
    QVariantMap result = database->queryRecord("devices", fields, conditions);
    fields.clear();
    fields.append("iParameter");
    conditions.clear();
    conditions["id"] = result.value("vehicleId").toString();
    result = database->queryRecord("vehicles", fields, conditions);
    QJsonDocument json = QJsonDocument::fromJson(result.value("iParameter").toString().toUtf8());
    QStringList list;
    if (parameterList.isEmpty()&&json.isArray())
    {
        foreach (const QVariant &it, json.array().toVariantList()){
            parameterList.append(it.toString());
            qDebug()<< it.toString();
        }
    } else {
     //TODO: Handle exceptions   exceptions
        qDebug()<< "READ DATABASE ERROR";
    }
    emit paraChanged();
}

void HieuChinhThongSo::submitData(QString paraData)
{
    QJsonObject  object;
    object.insert("code",settings->defautConfig.getDeviceCode());
    object.insert("iParameter",paraData);
    QJsonDocument doc(object);
    QByteArray jsonData = doc.toJson();
    if (settings->defautConfig.getToken().isEmpty()){
        if (saveInspectData(paraData, false)) emit submitSuccess();
        else emit submitFailed();
    } else {
        network->inspect(jsonData);
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                qDebug()<<obj;
                if (obj.value("code").toInt() == 0 && this->saveInspectData(paraData, true)){
                    settings->defautConfig.setDeviceCode(obj.value("data").toObject().value("code").toString());
                    qDebug()<<"thanh cong";
                    emit submitSuccess();
                } else {
                    emit submitFailed();
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError || network->reply->error() == QNetworkReply::HostNotFoundError){
                if (saveInspectData(paraData, false)) emit submitSuccess();
                else emit submitFailed();
            } else if (network->reply->error() == QNetworkReply::AuthenticationRequiredError){
                if (saveInspectData(paraData, false)) emit submitSuccess();
                else emit submitFailed();
                settings->defautConfig.setToken("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit unauthorized();
            } else {
                settings->defautConfig.setDeviceCode("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit submitFailed();
            }
        });
    }
}

bool HieuChinhThongSo::saveInspectData(QString jsonData, bool sync){
    QVariantMap mapConditions;
    mapConditions["code"] = settings->defautConfig.getDeviceCode();
    QVariantMap mapUpdatedData;
    mapUpdatedData["iParameter"] = jsonData;
    if (sync) mapUpdatedData["syncAt"] = QDateTime::currentDateTime().toString();
    return localDatabase->updateRecord("devices",mapUpdatedData,mapConditions);
}
