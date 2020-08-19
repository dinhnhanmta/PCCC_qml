#ifndef LOGIN_H
#define LOGIN_H
#include <QString>
#include <QObject>
class Login: public QObject {
  Q_OBJECT
public:
    Q_INVOKABLE bool checkLogin(QString user,QString pass);
};

#endif // LOGIN_H
