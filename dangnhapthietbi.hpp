#ifndef DANGNHAPTHIETBI_H
#define DANGNHAPTHIETBI_H
#include <QString>
#include <QtSql>
#include <QObject>
#include "login.hpp"
class DangNhapThietBi: public QObject {
    Q_OBJECT
public:

    Q_INVOKABLE bool checkLogin(int maTB);
    DangNhapThietBi();
    DangNhapThietBi(login *log);
private:
    login *m_login;
};

#endif // DANGNHAPTHIETBI_H
