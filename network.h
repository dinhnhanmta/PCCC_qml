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
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
    const QString deviceLoginPath = "/api/Devices/DeviceLogin";
    const QString dataPath = "/api/Vehicles/test-result";
};

#endif // NETWORK_H
