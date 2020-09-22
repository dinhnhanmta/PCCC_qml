#ifndef DANGNHAPTHIETBI_H
#define DANGNHAPTHIETBI_H
#include <QString>
#include <QtSql>
#include <QObject>
#include <deviceModel.h>
#include "network.h"
#include "localdatabase.h"

class DangNhapThietBi: public QObject, BaseObject {
    Q_OBJECT
public:
    Q_PROPERTY(QAbstractItemModel* deviceModels READ listDeviceModels NOTIFY listDeviceModelsChanged)
    Q_PROPERTY(QAbstractItemModel* deviceCodes READ listDevicesCodes NOTIFY listDevicesChanged)

    Q_INVOKABLE void loginDevice(QString code);
    Q_INVOKABLE void saveDevice(QString code);
    DangNhapThietBi();
    Q_INVOKABLE bool logged();
    Q_INVOKABLE void logout();
    Q_INVOKABLE QString deviceModelName();
    Q_INVOKABLE QString deviceModelCode();
    Q_INVOKABLE void setDeviceModelName(QString deviceModelName);
    Q_INVOKABLE void getListDeviceModels();
    Q_INVOKABLE int currentDeviceModelIndex();
    Q_INVOKABLE int currentDeviceIndex();
    Q_INVOKABLE void getListDevicesCode();
signals:
    void loginSuccess();
    void loginFailed();
    void getDeviceModelDetailSuccess();
    void getDeviceModelDetailFailed();
    void getDeviceModelsFailed();
    void getDevicesFailed();
    void listDeviceModelsChanged();
    void listDevicesChanged();
    void unauthorized();
private:
    Network *network;
    LocalDatabase *localDatabase;
    void getDeviceLocal(QString code);
    bool getListDeviceModelsLocal();
    bool getListDevicesLocal();
    bool saveListDeviceModels(QJsonArray deviceModels);
    bool saveListDevices(QJsonArray devices);
    QStringList listDeviceModel;
    QStringList listDevicesCode;
    ListDeviceModels *listDeviceModels();
    ListDeviceModels *listDevicesCodes();
};

#endif // DANGNHAPTHIETBI_H
