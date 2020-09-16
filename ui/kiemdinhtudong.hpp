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
class KiemDinhTuDong : public QObject, BaseObject
{
    Q_OBJECT

public:

    Q_PROPERTY(double q_pReference READ getRefer NOTIFY varChanged)
    Q_PROPERTY(int q_counter_test READ getCounter NOTIFY varChanged)
//    Q_PROPERTY(float q_val_pot READ getValPot NOTIFY pressureChanged)


    Q_INVOKABLE void setPWorking(QString value);
    Q_INVOKABLE void setPTried(QString value);
    Q_INVOKABLE void updateLogic();
    Q_INVOKABLE void updateState();
    Q_INVOKABLE void checkState();
    Q_INVOKABLE bool isRunning();
    KiemDinhTuDong (CamBienApSuat *cbap, Bientan *bientan, Modbus *modbus, Relay *relay);

    double getRefer(){return _pReferCurrent;}
    int getCounter(){return counter; }


signals:
    void varChanged ();

private:
    QSqlDatabase db;
    QSqlQuery *query;

    float _pWorking = 16;
    float _pTried = 20;
    double _pReferCurrent;

    CamBienApSuat * m_camBienApSuat;
    Bientan *m_bienTan;
    Modbus *m_modbus;
    Relay * m_relay;
    lcd *m_lcd;

    bool last_start_state;
    bool running = false;
    int counter = -1;

    QList<double> saveData;
    QDateTime startTime;

    QThread *threadUpdateState;

    enum States
       {
           ST_IDLE = 0,
           ST_PREPARATION,
           ST_START,
           ST_WORKING_P_TEST,
           ST_PUMP_UP_TO_TEST,
           ST_TEST_PRESSURE,
           ST_PUMPDOWN,
           ST_FINISH
       };
    States state = ST_IDLE;
    double updatePRefer(double _currentPRefer);
    void stop();
    void saveRecordData();
    LocalDatabase *localDatabase;
};


#endif // KIEMDINHTUDONG_HPP
