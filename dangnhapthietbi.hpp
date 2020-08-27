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

    Q_INVOKABLE void login(QString code);
    DangNhapThietBi();
    Q_INVOKABLE bool logged();
signals:
    void loginSuccess();
    void loginFailed();
private:
    bool saveDevice(QJsonObject obj);
    Network *network;
    LocalDatabase *localDatabase;
    void getDevice(QString code);
};

#endif // DANGNHAPTHIETBI_H
