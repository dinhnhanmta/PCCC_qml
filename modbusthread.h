#ifndef MODBUSTHREAD_H
#define MODBUSTHREAD_H
#include <QMutex>
#include <QThread>
#include <QWaitCondition>
#include <bientan.hpp>
#include <modbus.hpp>
#include <relay.hpp>


class ModbusThread : public QThread
{
//    Q_OBJECT
public:
    ModbusThread(Bientan *bientan, Modbus *modbus, Relay *relay);

    void run();
    void updateRelay();
    void updateButton();

//signals:

//public slots:

private:
    Bientan *m_bienTan;
    Modbus *m_modbus;
    Relay *m_relay;

};

#endif // MODBUSTHREAD_H
