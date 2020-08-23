#include "modbusthread.h"
#include <QDebug>

ModbusThread::ModbusThread(Bientan *bientan, Modbus *modbus, Relay *relay)
{
    m_bienTan = bientan;
    m_modbus = modbus;
    m_relay = relay;
}

void ModbusThread::run()
{
    while(true)
    {
//        qDebug()<<"update modbus";
        updateRelay();
        msleep(500);
    }
}

void ModbusThread::updateRelay()
{
    m_relay->readAllState();
}

void ModbusThread::updateButton()
{

}
