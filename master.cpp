#include "master.h"
#include <QSerialPortInfo>
#include <QDebug>
master::master(Modbus *modbus_device)
{
        m_number_port = 0;
        getPortAvalable();
        this->master_modbusDevice = modbus_device;
}
master::master ()
{
}
void master::getPortAvalable()
{
    const auto serialPortInfos = QSerialPortInfo::availablePorts();
    const QString blankString = "N/A";
    QString description;
    QString manufacturer;
    QString serialNumber;
    QString port[10];
    int i=0,j=0;
    for (const QSerialPortInfo &serialPortInfo : serialPortInfos) {
        port[i] = serialPortInfo.portName();
        i++;
    }
    if (i==0) m_port.clear();
    else
    {
        m_port.clear();
        for (j=0;j<i;j++)
        {
            m_port << port[j];
         }
    }
    m_port.removeDuplicates();
    m_number_port = i;
    emit varChanged();
   // qDebug() <<m_port;
}

bool master::startConnection()
{
    return master_modbusDevice->startConnection();
}



