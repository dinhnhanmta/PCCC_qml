#include "Modbus.hpp"
#include <QObject>
#include <QModbusRtuSerialMaster>

Modbus::Modbus() {
    modbusDevice = new QModbusRtuSerialMaster();
}

bool Modbus::startConnection() {
    /*
    QQmlApplicationEngine engine;
    QQmlComponent component(&engine, QUrl(QLatin1String("qrc:/Caidat.qml")));
    QObject *mainPage = component.create();
    QObject* item = mainPage->findChild<QObject *>("dropdownMasterBaudrate");
    */
    /*
    qDebug() << "Port:"<<m_portName<<endl;
    qDebug() << "Parity:"<<m_parity<<endl;
    qDebug() << "DataBits:"<<m_dataBits<<endl;
    qDebug() << "Stopbits:"<<m_stopBits<<endl;
    qDebug() << "Baudrate"<<m_baudrate<<endl;
    */

    // CAI DAT THONG SO CHO MODBUS
    if (modbusDevice->state()==QModbusDevice::ConnectedState)
    {
        modbusDevice->disconnectDevice();
    }
    // PORT NAME
    modbusDevice->setConnectionParameter(QModbusDevice::SerialPortNameParameter, "/dev/"+m_portName);
    // BAUDRATE
    modbusDevice->setConnectionParameter(QModbusDevice::SerialBaudRateParameter,m_baudrate);

    // PARITY
    if (m_parity == "None") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::NoParity);
    else if (m_parity == "Even") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::EvenParity);
    else if (m_parity == "Odd") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::OddParity);
    // DATA BITS
    modbusDevice->setConnectionParameter(QModbusDevice::SerialDataBitsParameter, m_dataBits);
    // STOP BITS
    modbusDevice->setConnectionParameter(QModbusDevice::SerialStopBitsParameter, m_stopBits);

    if (!modbusDevice->connectDevice())
      qDebug() << "cannot connect ";
    else
    qDebug() << "connect ";

    qDebug() << "error: " << modbusDevice->errorString();
    qDebug() << "state: " << modbusDevice->state();
    return true;
}

void Modbus::writeSingleHoldingResister(int add, int value,int server)
{
    startConnection();
    QModbusDataUnit reg(QModbusDataUnit::HoldingRegisters,add,1);
    reg.setValue(0,value);
    QModbusReply *reply;
    reply = modbusDevice->sendWriteRequest(reg,server);
    if (reply) {
        if (!reply->isFinished())
          connect(reply, &QModbusReply::finished, this, &Modbus::writeSingleHoldingResisterCompleted);
      } else
        qDebug() << "Write Single Holding Resister Error!";
}
void Modbus::writeSingleHoldingResisterCompleted()
{

    qDebug() << "Write Single Holding Resister Completed!";
}
Modbus::~Modbus() {
  modbusDevice->disconnectDevice();
  delete modbusDevice;
  modbusDevice = nullptr;
}

