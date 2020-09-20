#ifndef KIEMDINHTUDONG_HPP
#define KIEMDINHTUDONG_HPP

#include <QObject>
#include "constant.h"
#include <QtSql>
#include <bientan.hpp>
#include <cambienapsuat.hpp>
#include <lcd.h>
#include <localdatabase.h>
#include <relay.hpp>
#include "dataobject.h"
#include <QThread>

class KiemDinhTuDong : public QObject, BaseObject
{
    Q_OBJECT
    Q_PROPERTY(bool q_led_start READ getLedStart WRITE setLedStart NOTIFY stateChanged)
    Q_PROPERTY(bool q_led_vavle_up READ getValveUp WRITE setLedValveUp NOTIFY stateChanged)
    Q_PROPERTY(bool q_led_vavle_down READ getValveDown  WRITE setLedValveDown NOTIFY stateChanged)
    Q_PROPERTY(int q_state_machine READ getStateMachine NOTIFY stateMachineChanged)


public:
     explicit KiemDinhTuDong(QObject *parent = nullptr);
    KiemDinhTuDong (CamBienApSuat *cbap, Modbus *modbus, Relay * _relay, lcd *_lcd, Bientan* _bientan);

    Q_PROPERTY(double q_pReference READ getRefer NOTIFY varChanged)
    Q_PROPERTY(int q_counter_test READ getCounter NOTIFY varChanged)
//    Q_PROPERTY(float q_val_pot READ getValPot NOTIFY pressureChanged)

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

//    Q_INVOKABLE void setPWorking(QString value);
//    Q_INVOKABLE void setPTried(QString value);
    Q_INVOKABLE void updateLogic();
    Q_INVOKABLE void updateState();
    Q_INVOKABLE void checkState();
    Q_INVOKABLE bool isRunning();

//
    double getRefer(){return _pReferCurrent;}
    int getCounter(){return counter; }
    int getStateMachine() {return  state;}

    void readRelayDone();
    void readButtonDone();

signals:
    void varChanged ();
    void stateChanged();
    void stateMachineChanged();

private:

    QSqlDatabase db;
    QSqlQuery *query;

    CamBienApSuat * m_camBienApSuat;
    Modbus *m_modbus;
    Relay * m_relay;
    lcd *m_lcd;

    bool last_start_state;
    bool running = false;
    int counter = -1;

    QList<double> saveData;
    QDateTime startTime;

    bool mode_do_ben = false;
    bool is_test_luu_luong = false;

    double p_at_first = 30;
    double p_at_second = 0.5;
    double p_at_third = 10;
    double p_at_fourth = 48;
    double _pReferCurrent;

    double coef_inc_first = 1;
    double coef_inc_sencond = 0.1;
    double coef_inc_third = 1;
    double coef_inc_fourth_db = 0.33;

    enum States
       {
            ST_IDLE = 0,
            ST_PREPARATION,
            ST_START,
            ST_WORKING_P_TEST,
            ST_WAIT_TO_ZERO,
            ST_PUMP_UP_TO_05,
            ST_HOLD_05_15S,
            ST_PUMP_UP_TO_10,
            ST_HOLD_10_15,
            ST_PUMP_DOWN,
            ST_FINISH,
            ST_PREPERATION_DB,
            ST_START_DB,
            ST_HOLD_48_1P,
            ST_PUMP_DOWN_DB
       };

    States state = ST_IDLE;
    double updatePRefer(double _currentPRefer);
    void stop();
    void saveRecordData();
    LocalDatabase *localDatabase;
};


#endif // KIEMDINHTUDONG_HPP
