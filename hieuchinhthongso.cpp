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
    //fields.append("id");
    fields.append("iParameter");
    fields.append("oParameter");
    QVariantMap conditions;
    QVariantMap result = database->queryRecord("vehicles", fields, conditions);
    QJsonDocument json = QJsonDocument::fromJson(result.value("iParameter").toString().toUtf8());
    QStringList list;
    if (json.isArray()){
        foreach (const QVariant &it, json.array().toVariantList()){
            parameterList.append(it.toString());
        }
     } else {
     //TODO: Handle exceptions   exceptions
    }
    emit paraChanged();
}

void HieuChinhThongSo::submitData(QByteArray jsonData)
{
    if (settings->defautConfig.getToken().isEmpty()){
        if (saveInspectData(jsonData, false)) emit submitSuccess();
        else emit submitFailed();
    } else {
        network->inspect(jsonData);
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                if (obj.value("code").toInt() == 0 && this->saveInspectData(jsonData, true)){
                    settings->defautConfig.setDeviceCode(obj.value("data").toObject().value("code").toString());
                    emit submitSuccess();
                } else {
                    emit submitFailed();
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError || network->reply->error() == QNetworkReply::HostNotFoundError){
                if (saveInspectData(jsonData, false)) emit submitSuccess();
                else emit submitFailed();
            } else if (network->reply->error() == QNetworkReply::AuthenticationRequiredError){
                if (saveInspectData(jsonData, false)) emit submitSuccess();
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

bool HieuChinhThongSo::saveInspectData(QByteArray jsonData, bool sync){
    QVariantMap mapConditions;
    mapConditions["code"] = settings->defautConfig.getToken();
    QVariantMap mapUpdatedData;
    mapUpdatedData["iParameter"] = QString::fromUtf8(jsonData);
    if (sync) mapUpdatedData["syncAt"] = QDateTime::currentDateTime().toString();
    return localDatabase->updateRecord("devices",mapUpdatedData,mapConditions);
}
