#ifndef NETWORK_H
#define NETWORK_H

#include "baseobject.h"
#include "deviceparameter.h"
#include <QNetworkRequest>
#include <QNetworkReply>

class Network: public BaseObject, public QObject
{
public:
    Network();
    void login(QString username, QString password);
    void uploadDeviceParameter(DeviceParameter deviceParameter);
    void syncData();
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
    const QString dataPath = "/api/Vehicles/test-result";
};

#endif // NETWORK_H
