#include "dangnhapthietbi.hpp"

void DangNhapThietBi::login(QString code)
{
    if (settings->defautConfig.getToken().isEmpty()){
        getDevice(code);
    } else {
        network->deviceLogin('"' + code + '"');
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                if (obj.value("code").toInt() == 0 && this->saveDevice(obj.value("data").toObject())){
                    settings->defautConfig.setDeviceCode(obj.value("data").toObject().value("code").toString());
                    emit loginSuccess();
                } else {
                    emit loginFailed();
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError){
                getDevice(code);
            } else if (network->reply->error() == QNetworkReply::AuthenticationRequiredError){
                settings->defautConfig.setToken("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit unauthorized();
            } else {
                settings->defautConfig.setDeviceCode("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit loginFailed();
            }
        });
    }
}

bool DangNhapThietBi::saveDevice(QJsonObject obj){
    QVariantMap map;
    map["vehicleId"] = obj.value("vehicleId").toInt();
    map["code"] = obj.value("code").toString();
    return localDatabase->insertRecord("devices",map);
}

void DangNhapThietBi::getDevice(QString code){
    QStringList fields;
    fields.append("iParameter");
    fields.append("oParameter");

    QVariantMap conditions;
    conditions["code"] = code;
    QVariantMap result = localDatabase->queryRecord("devices", fields, conditions);
    if (!result.isEmpty()){
        emit loginSuccess();
    } else {
        emit loginFailed();
    }
}

DangNhapThietBi::DangNhapThietBi()
{
    network = new Network();
    localDatabase = new LocalDatabase();
}

bool DangNhapThietBi::logged()
{
    return settings->defautConfig.getDeviceCode() != "";
}

void DangNhapThietBi::logout()
{
    settings->defautConfig.setDeviceCode("");
}
