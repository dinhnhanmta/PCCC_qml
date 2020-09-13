#ifndef DANGNHAPTHIETBI_H
#define DANGNHAPTHIETBI_H
#include <QString>
#include <QtSql>
#include <QObject>
#include "network.h"
#include "localdatabase.h"

class DangNhapThietBi: public QObject, BaseObject {
    Q_OBJECT
public:

    Q_INVOKABLE void loginDevice(QString code);
    Q_INVOKABLE void saveDevice(QString code);
    DangNhapThietBi();
    Q_INVOKABLE bool logged();
    Q_INVOKABLE void logout();
    Q_INVOKABLE QString deviceModelName();
    Q_INVOKABLE void setDeviceModelName(QString deviceModelName);
signals:
    void loginSuccess();
    void loginFailed();
    void getDeviceModelSuccess();
    void getDeviceModelFailed();
    void unauthorized();
private:
    Network *network;
    LocalDatabase *localDatabase;
    void getDevice(QString code);
};

#endif // DANGNHAPTHIETBI_H
