#include "hieuchinhthongso.hpp"
#include <QDateTime>
HieuChinhThongSo::HieuChinhThongSo()
{
    network = new Network();
    localDatabase = new LocalDatabase();
}
void HieuChinhThongSo::readJson(QString name)
{
    QString val;
    QFile file;
    file.setFileName(name);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();
    QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject sett2 = d.object();
    QJsonValue value = sett2.value(QString("iParameter"));

    for (int i=0;i<value.toArray().size();i++)
    {
         qDebug() << value[i].toString();
         parameterList.append(value[i].toString());
    }
    emit paraChanged();

}

void HieuChinhThongSo::submitData()
{
    QByteArray jsonData;
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
