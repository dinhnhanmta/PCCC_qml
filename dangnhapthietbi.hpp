#ifndef DANGNHAPTHIETBI_H
#define DANGNHAPTHIETBI_H
#include <QString>
#include <QObject>
class DangNhapThietBi: public QObject {
    Q_OBJECT
public:

    Q_INVOKABLE bool checkLogin(QString code);
};

#endif // DANGNHAPTHIETBI_H
