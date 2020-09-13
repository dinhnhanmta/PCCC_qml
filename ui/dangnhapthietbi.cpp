#include "dangnhapthietbi.hpp"

void DangNhapThietBi::loginDevice(QString code)
{
    if (settings->defautConfig.getToken().isEmpty()){
        getDeviceLocal(code);
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
                getDeviceLocal(code);
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

void DangNhapThietBi::getDeviceLocal(QString code){
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

bool DangNhapThietBi::getListDeviceModelsLocal()
{
    QStringList fields;
    fields.append("name");
    QVariantMap conditions;

    QList<QVariantMap> results = localDatabase->queryRecords("deviceModels", fields, conditions);
    listDeviceModel = QList<QString>() << QString("");

    foreach (const QVariantMap & result, results) {
        if (result.value("name").isValid()){
            listDeviceModel << QString(result.value("name").toString());
        } else {
            emit getDeviceModelsFailed();
            return false;
        }
    }
    emit getDeviceModelsSuccess();
    return true;
}

bool DangNhapThietBi::saveListDeviceModels(QJsonArray deviceModels)
{
    listDeviceModel = QList<QString>() << QString("");
    foreach (const QJsonValue & deviceModel, deviceModels) {
        QJsonObject obj = deviceModel.toObject();
        QVariantMap mapDeviceModel;
        mapDeviceModel["name"] = obj["vehicleName"].toString();
        mapDeviceModel["iParameter"] = obj["iParameter"].toString();
        if (!localDatabase->insertRecord("deviceModels",mapDeviceModel)){
            return false;
        } else {
            listDeviceModel << QString(obj["vehicleName"].toString());
        }
    }
    emit getDeviceModelsSuccess();
    return true;
}

void DangNhapThietBi::setDeviceModelName(QString deviceModelName)
{
    QStringList fields;
    fields.append("iParameter");

    QVariantMap conditions;
    conditions["name"] = deviceModelName;
    QVariantMap result = localDatabase->queryRecord("deviceModels", fields, conditions);

    if (result.value("iParameter").isValid()){
        settings->defautConfig.setDeviceModelName(deviceModelName);
        emit getDeviceModelDetailSuccess();
    } else {
        emit getDeviceModelDetailFailed();
    }
}

void DangNhapThietBi::getListDeviceModels()
{
    if (settings->defautConfig.getToken().isEmpty()){
        getListDeviceModelsLocal();
        emit listDeviceModelsChanged();
    } else {
        network->getDeviceModels();
        connect(network->reply, &QNetworkReply::finished, [=]() {
            if(network->reply->error() == QNetworkReply::NoError){
                QJsonObject obj = QJsonDocument::fromJson(network->reply->readAll()).object();
                if (obj.value("code").toInt() != 0
                        || !saveListDeviceModels(obj.value("data").toArray())
                        ){
                    emit getDeviceModelsFailed();
                }
            } else if (network->reply->error() == QNetworkReply::TimeoutError || network->reply->error() == QNetworkReply::HostNotFoundError){
                getListDeviceModelsLocal();
            } else if (network->reply->error() == QNetworkReply::AuthenticationRequiredError){
                settings->defautConfig.setToken("");
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit unauthorized();
            } else {
                logger->printLog(LoggerLevel::FATAL, network->reply->errorString());
                emit getDeviceModelsFailed();
            }
            emit listDeviceModelsChanged();
        });
    }
}

ListDeviceModels* DangNhapThietBi::listDeviceModels()
{
    return new ListDeviceModels(listDeviceModel);
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
