#include "network.h"

#include <QJsonDocument>
#include <QJsonObject>


Network::Network()
{
    manager = new QNetworkAccessManager(this);
}

void Network::login(QString username, QString password)
{
    QVariantMap mapData;
    mapData["email"] = username;
    mapData["password"] = password;
    QByteArray jsonData = QJsonDocument(
                QJsonObject::fromVariantMap(
                        mapData
                )
        ).toJson();

    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + loginPath));
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    request.setHeader(QNetworkRequest::ContentLengthHeader,QByteArray::number(jsonData.size()));

    reply = manager->post(request, jsonData);
}

void Network::deviceLogin(QString code)
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + deviceLoginPath));
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    request.setHeader(QNetworkRequest::ContentLengthHeader,QByteArray::number(code.toUtf8().size()));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }

    reply = manager->post(request, code.toUpper().toUtf8());
}

void Network::inspect(QByteArray jsonData)
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + dataPath));
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    request.setHeader(QNetworkRequest::ContentLengthHeader,QByteArray::number(jsonData.size()));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }

    reply = manager->post(request, jsonData);
}

QString Network::getMacAddress()
{
    foreach(QNetworkInterface netInterface, QNetworkInterface::allInterfaces())
    {
        // Return only the first non-loopback MAC Address
        if (!(netInterface.flags() & QNetworkInterface::IsLoopBack))
            return netInterface.hardwareAddress();
    }
    return QString();
}
void Network::getDeviceDetail()
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + devices + getMacAddress().remove(":")));//"FFAABBCCDDEE"));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }
    qDebug()<<"link "<<settings->defautConfig.getServerUrl() + devices + getMacAddress().remove(":");
    reply = manager->get(request);
}

void Network::syncData()
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + dataPath));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }
    reply = manager->get(request);
}

void Network::getDeviceModels()
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + deviceModels));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }
    reply = manager->get(request);
}

void Network::getDevicesByName(QString modelName)
{
    request.setUrl(QUrl::fromUserInput(settings->defautConfig.getServerUrl() + devicesByModelName + modelName));
    if (!settings->defautConfig.getToken().isEmpty()){
        request.setRawHeader("Authorization", "Bearer " + settings->defautConfig.getToken().toUtf8());
    }
    reply = manager->get(request);
}
