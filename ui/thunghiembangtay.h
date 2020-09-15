#ifndef THUNGHIEMBANGTAY_H
#define THUNGHIEMBANGTAY_H

#include <QObject>
#include <cambienapsuat.hpp>
#include <devices/bientan.hpp>
#include <modbus.hpp>
#include <devices/relay.hpp>
#include <devices/lcd.h>
#include "dongholuuluong.h"
//#include <QThread>

class ThuNghiemBangTay : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool q_led_start READ getLedStart WRITE setLedStart NOTIFY stateChanged)
    Q_PROPERTY(bool q_led_vavle_up READ getValveUp WRITE setLedValveUp NOTIFY stateChanged)
    Q_PROPERTY(bool q_led_vavle_down READ getValveDown  WRITE setLedValveDown NOTIFY stateChanged)
public:
    explicit ThuNghiemBangTay(QObject *parent = nullptr);
    ThuNghiemBangTay(CamBienApSuat *cbap, Modbus *modbus);
    ~ThuNghiemBangTay();
    Q_INVOKABLE void updateLogic();


    bool getLedStart();
    bool getValveUp();
    bool getValveDown();
    Q_INVOKABLE bool setLedStart(bool val);
    Q_INVOKABLE void setLedValveUp(bool val);
    Q_INVOKABLE void setLedValveDown(bool val);

     Q_INVOKABLE void setLcdID(int id);
     Q_INVOKABLE void setBienTanID(int id);
     Q_INVOKABLE void setRelayID(int id);
     Q_INVOKABLE void swapTuLuuLuong(bool value);

    void readRelayDone();
    void readButtonDone();

signals:

    void stateChanged();

public slots:

private:
    CamBienApSuat * m_camBienApSuat;
    Bientan *m_bienTan;
    Modbus *m_modbus;
    Relay * m_relay;
    lcd *m_lcd;
    DongHoLuuLuong * m_dong_ho_ll;

    bool is_test_luu_luong = false;

    bool last_start_state;
    int8_t bien_tan_start  = 5;
};

#endif // THUNGHIEMBANGTAY_H
