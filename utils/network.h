#ifndef NETWORK_H
#define NETWORK_H

#include "baseobject.h"
#include <QNetworkRequest>
#include <QNetworkReply>

class Network: QObject, BaseObject
{
    Q_OBJECT
public:
    Network();
    void login(QString username, QString password);
    void deviceLogin(QString code);
    void inspect(QByteArray jsonData);
    void syncData();
    void getDeviceModels();
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
    const QString deviceLoginPath = "/api/Devices/DeviceLogin";
    const QString deviceModels = "/api/DeviceModels/All";
    const QString dataPath = "/api/Devices/Inspect";
};

#endif // NETWORK_H
