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

    Q_INVOKABLE void loginDevice(QString code);
    Q_INVOKABLE void saveDevice(QString code);
    DangNhapThietBi();
    Q_INVOKABLE bool logged();
    Q_INVOKABLE void logout();
    Q_INVOKABLE QString deviceModelName();
    Q_INVOKABLE void setDeviceModelName(QString deviceModelName);
    Q_INVOKABLE void getListDeviceModels();
signals:
    void loginSuccess();
    void loginFailed();
    void getDeviceModelDetailSuccess();
    void getDeviceModelDetailFailed();
    void getDeviceModelsSuccess();
    void getDeviceModelsFailed();
    void listDeviceModelsChanged();
    void unauthorized();
private:
    Network *network;
    LocalDatabase *localDatabase;
    void getDeviceLocal(QString code);
    bool getListDeviceModelsLocal();
    bool saveListDeviceModels(QJsonArray deviceModels);
    QStringList listDeviceModel;
    ListDeviceModels *listDeviceModels();
};

#endif // DANGNHAPTHIETBI_H
