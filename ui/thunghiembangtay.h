#ifndef THUNGHIEMBANGTAY_H
#define THUNGHIEMBANGTAY_H

#include <QObject>
#include <cambienapsuat.hpp>
#include <devices/bientan.hpp>
#include <modbus.hpp>
#include <devices/relay.hpp>
#include <devices/lcd.h>
//#include <QThread>

class ThuNghiemBangTay : public QObject
{
    Q_OBJECT
public:
    explicit ThuNghiemBangTay(QObject *parent = nullptr);
    ThuNghiemBangTay(CamBienApSuat *cbap, Bientan *bientan, Modbus *modbus, Relay *relay);
//    ~ThuNghiemBangTay();
//    Q_INVOKABLE void startICP();
//    Q_INVOKABLE void startModbus();
//    Q_INVOKABLE void updateCambien();
    Q_INVOKABLE void updateLogic();


    void run();
signals:

public slots:

private:
    CamBienApSuat * m_camBienApSuat;
    Bientan *m_bienTan;
    Modbus *m_modbus;
    Relay * m_relay;
    lcd *m_lcd;

    bool last_start_state;
    int8_t bien_tan_start  = 5;
};

#endif // THUNGHIEMBANGTAY_H
