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
    fields.append("iParameter");
    QVariantMap conditions;
    conditions["name"] = settings->defautConfig.getDeviceModelName();
    QVariantMap result = database->queryRecord("deviceModels", fields, conditions);
    QJsonDocument json = QJsonDocument::fromJson(result.value("iParameter").toString().toUtf8());

    QStringList list;
    if (parameterList.isEmpty()&&json.isArray())
    {
        foreach (const QVariant &it, json.array().toVariantList()){

            parameterList.append(it.toString());
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
    qDebug()<<"paraData"<<paraData;
    object.insert("piCode",network->getMacAddress().remove(":"));
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
                if (obj.value("code").toInt() == 0 && this->saveInspectData(paraData, true)){
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


void HieuChinhThongSo::getDeviceData()
{

    if (settings->defautConfig.getToken().isEmpty()){
        qDebug()<<"EMPTY";
    } else {
        network->getDeviceDetail();
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                QJsonArray objArray = obj.value("data").toArray();
                for (int i=0;i<objArray.size();i++)
                {
                saveDetailDataToLocal(objArray[i].toObject().value("iParameter").toString(),objArray[i].toObject().value("code").toString());
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError || network->reply->error() == QNetworkReply::HostNotFoundError){
                qDebug()<<"getDeviceData TIMEOUT   ";
            } else if (network->reply->error() == QNetworkReply::AuthenticationRequiredError){
                qDebug()<<"getDeviceData unauthorized   ";
                settings->defautConfig.setToken("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit unauthorized();
            } else {
                settings->defautConfig.setDeviceCode("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
            }
        });
    }
    emit paraChanged();
}
void HieuChinhThongSo::getIParameterFromLocal()
{
    parameterValueList.clear();
    database = new LocalDatabase();
    QStringList fields;
    fields.append("iParameter");
    QVariantMap conditions;
    conditions["code"] = settings->defautConfig.getDeviceCode();
    QVariantMap result = database->queryRecord("devices", fields, conditions);
    QJsonDocument json = QJsonDocument::fromJson(result.value("iParameter").toString().toUtf8());
    QString data = result.value("iParameter").toString();
    QJsonObject objValue =  json.object();
    data = data.mid(1,data.size()-2);
    for (int i=0;i<objValue.size();i++)
    {
        parameterValueList.append(data.split(",")[i].split(":")[1].remove("\""));
    }
    emit paraChanged();
}
bool HieuChinhThongSo::saveDetailDataToLocal(QString jsonData,QString code){
    QVariantMap mapConditions;
    mapConditions["code"] = code;
    QVariantMap mapUpdatedData;
    mapUpdatedData["iParameter"] = jsonData;
    return localDatabase->updateRecord("devices",mapUpdatedData,mapConditions);
}

bool HieuChinhThongSo::saveInspectData(QString jsonData, bool sync){
    QVariantMap mapConditions;
    mapConditions["code"] = settings->defautConfig.getDeviceCode();
    QVariantMap mapUpdatedData;
    mapUpdatedData["iParameter"] = jsonData;
    if (sync) mapUpdatedData["syncAt"] = QDateTime::currentDateTime().toString();
    return localDatabase->updateRecord("devices",mapUpdatedData,mapConditions);
}
