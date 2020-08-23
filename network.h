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
    void uploadDeviceParameter(QByteArray jsonData);
    void syncData();
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
    const QString dataPath = "/api/Vehicles/test-result";
};

#endif // NETWORK_H
