#ifndef NETWORK_H
#define NETWORK_H

#include "baseobject.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkInterface>
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
    void getDeviceDetail();
    void getDevicesByName(QString modelName);
    QString getMacAddress();
    QNetworkReply *reply;
private:
    QNetworkRequest request;
    QNetworkAccessManager *manager;
    const QString loginPath = "/api/Auth/Login";
    const QString deviceLoginPath = "/api/Devices/DeviceLogin";
    const QString devicesByModelName = "/api/Devices/DeviceList/ByName/";
    const QString deviceModels = "/api/DeviceModels/All";
    const QString dataPath = "/api/Devices/Inspect";
    const QString devices = "/api/Devices/UpdatedList/";
};

#endif // NETWORK_H
