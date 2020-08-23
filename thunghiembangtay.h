#ifndef THUNGHIEMBANGTAY_H
#define THUNGHIEMBANGTAY_H

#include <QObject>
#include <icpthread.h>
#include <modbusthread.h>

class ThuNghiemBangTay : public QObject
{
    Q_OBJECT
public:
    explicit ThuNghiemBangTay(QObject *parent = nullptr);
    ThuNghiemBangTay(IcpThread *icpThread, ModbusThread *modbusThread);
//    ~ThuNghiemBangTay();
    Q_INVOKABLE void startICP();
    Q_INVOKABLE void startModbus();
    Q_INVOKABLE void stopICP();
    Q_INVOKABLE void stopModbus();

signals:

public slots:

private:
    IcpThread * m_icpThread;
    ModbusThread *m_modbusThread;
};

#endif // THUNGHIEMBANGTAY_H
