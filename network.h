#ifndef NETWORK_H
#define NETWORK_H

#include "baseobject.h"
#include <QNetworkRequest>
#include <QNetworkReply>

class Network: public BaseObject, public QObject
{
public:
    Network();
    void login(QString username, QString password);
    bool uploadDeviceParameter();
    bool syncData();
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
};

#endif // NETWORK_H
