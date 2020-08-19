#ifndef LOGIN_H
#define LOGIN_H
#include "baseobject.h"
#include "network.h"
#include <QJsonDocument>
#include <QString>
#include <QObject>
#include <QJsonObject>
class Login: public QObject, BaseObject {
    Q_OBJECT
public:
    Login();
    Q_INVOKABLE void onClick(QString user,QString pass);
    Q_INVOKABLE QString loggedUsername();
    Q_INVOKABLE QString loggedPassword();
    Q_INVOKABLE bool logged();
signals:
    void loginSuccess();
    void loginFailed();
private:
    Network *network;
};

#endif // LOGIN_H
