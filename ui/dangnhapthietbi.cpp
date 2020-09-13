#include "dangnhapthietbi.hpp"

void DangNhapThietBi::loginDevice(QString code)
{
    if (settings->defautConfig.getToken().isEmpty()){
        getDevice(code);
    } else {
        network->deviceLogin('"' + code + '"');
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                if (obj.value("code").toInt() == 0){
                    this->saveDevice(obj.value("data").toObject().value("code").toString());
                } else {
                    emit loginFailed();
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError || network->reply->error() == QNetworkReply::HostNotFoundError){
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

void DangNhapThietBi::saveDevice(QString code)
{
    QVariantMap mapDevice;
    mapDevice["deviceModelName"] = settings->defautConfig.getDeviceModelName();
    mapDevice["code"] = code;
    if (localDatabase->insertRecord("devices",mapDevice)){
        settings->defautConfig.setDeviceCode(code);
        emit loginSuccess();
    } else {
        emit loginFailed();
    }
}

void DangNhapThietBi::getDevice(QString code){
    QStringList fields;
    fields.append("iParameter");

    QVariantMap conditions;
    conditions["code"] = code;
    QVariantMap result = localDatabase->queryRecord("devices", fields, conditions);

    if (result.value("iParameter").isValid()){
        settings->defautConfig.setDeviceCode(code);
        emit loginSuccess();
    } else {
        emit loginFailed();
    }
}

void DangNhapThietBi::setDeviceModelName(QString deviceModelName)
{
    QStringList fields;
    fields.append("iParameter");

    QVariantMap conditions;
    conditions["name"] = deviceModelName;
    QVariantMap result = localDatabase->queryRecord("deviceModels", fields, conditions);

    if (result.value("name").isValid()){
        settings->defautConfig.setDeviceModelName(deviceModelName);
        emit getDeviceModelSuccess();
    } else {
        emit getDeviceModelFailed();
    }
}

DangNhapThietBi::DangNhapThietBi()
{
    network = new Network();
    localDatabase = new LocalDatabase();

}

bool DangNhapThietBi::logged()
{
    return !settings->defautConfig.getDeviceCode().isEmpty();
}

void DangNhapThietBi::logout()
{
    settings->defautConfig.setDeviceCode("");
}

QString DangNhapThietBi::deviceModelName() {
    return settings->defautConfig.getDeviceModelName().toUpper();
}
