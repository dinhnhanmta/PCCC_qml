#ifndef LOGIN_H
#define LOGIN_H
#include <QString>
#include <QtSql>
#include <QObject>
class login: public QObject {
  Q_OBJECT
public:
    login();
    Q_INVOKABLE bool checkLogin(QString user,QString pass);
    QSqlDatabase mydb=QSqlDatabase::addDatabase("QSQLITE");
private:
    QString user;
    QString pass;

};

#endif // LOGIN_H
