#ifndef KIEMDINHTUDONG_HPP
#define KIEMDINHTUDONG_HPP

#include <QObject>
#include "constant.h"
#include <QtSql>
#include <bientan.hpp>
#include <cambienapsuat.hpp>
#include <lcd.h>
#include <relay.hpp>
#include "dataobject.h"
class KiemDinhTuDong : public QObject
{
    Q_OBJECT


public:
    Q_PROPERTY(QList<double> pCurrent READ getPCurrent)
    Q_PROPERTY(QList<double> pRefer READ getPRefer)
    Q_PROPERTY(QList<QString> xValue READ getXValue NOTIFY xValueChange)

    Q_INVOKABLE void setPWorking(QString value);
    Q_INVOKABLE void setPTried(QString value);
    Q_INVOKABLE void updateLogic();
    Q_INVOKABLE void updateState();
    Q_INVOKABLE void checkState();
    Q_INVOKABLE bool isRunning();
    KiemDinhTuDong (CamBienApSuat *cbap, Bientan *bientan, Modbus *modbus, Relay *relay);

    Q_INVOKABLE void start();
signals:
    void pCurrentChange();
    void pReferChange();
    void xValueChange();

private:
    QSqlDatabase db;
    QSqlQuery *query;

    QList<double> getPCurrent();
    QList<double> getPRefer();
    QList<QString> getXValue();

    float _pWorking;
    float _pTried;
    QList<double> _pCurrent;
    QList<double> _pRefer;
    QList<QDateTime> _xValue;

    CamBienApSuat * m_camBienApSuat;
    Bientan *m_bienTan;
    Modbus *m_modbus;
    Relay * m_relay;
    lcd *m_lcd;

    bool last_start_state;
    bool running = false;
    int counter = -1;

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
};


#endif // KIEMDINHTUDONG_HPP
