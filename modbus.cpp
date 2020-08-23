#include "modbus.hpp"
#include <QObject>
#include <QModbusRtuSerialMaster>
#include <QThread>
Modbus::Modbus()  {
    modbusDevice = new QModbusRtuSerialMaster();
    nBytes= 0;
}

bool Modbus::startConnection() {
    // CAI DAT THONG SO CHO MODBUS
    if (modbusDevice->state()==QModbusDevice::ConnectedState)
    {
        modbusDevice->disconnectDevice();
    }
    // PORT NAME
    modbusDevice->setConnectionParameter(QModbusDevice::SerialPortNameParameter, "/dev/"+ settings->modbusParam.getPortName());
    // BAUDRATE
    modbusDevice->setConnectionParameter(QModbusDevice::SerialBaudRateParameter,settings->modbusParam.getBaudrate());

    // PARITY
    if (settings->modbusParam.getParity() == "None") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::NoParity);
    else if (settings->modbusParam.getParity() == "Even") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::EvenParity);
    else if (settings->modbusParam.getParity() == "Odd") modbusDevice->setConnectionParameter(QModbusDevice::SerialParityParameter,QSerialPort::OddParity);
    // DATA BITS
    modbusDevice->setConnectionParameter(QModbusDevice::SerialDataBitsParameter, settings->modbusParam.getDataBits());
    // STOP BITS
    modbusDevice->setConnectionParameter(QModbusDevice::SerialStopBitsParameter, settings->modbusParam.getStopBits());
    if (!modbusDevice->connectDevice())
    {
      qDebug() << "cannot connect ";
      connection_state = false;
      emit varChanged();
    }
    else
    {
      qDebug() << "connect ";
      connection_state = true;
      emit varChanged();
    }

    qDebug() << "error: " << modbusDevice->errorString();
    qDebug() << "state: " << modbusDevice->state();
    return true;
}

void Modbus::writeSingleHoldingRegister(int add, int value,int server)
{
    //startConnection();
    QModbusDataUnit reg(QModbusDataUnit::HoldingRegisters,add,1);
    reg.setValue(0,value);
    QModbusReply *reply;
    reply = modbusDevice->sendWriteRequest(reg,server);
    if (reply) {
        if (!reply->isFinished())
          connect(reply, &QModbusReply::finished, this, &Modbus::writeSingleHoldingRegisterCompleted);
      } else
        qDebug() << "Write Single Holding Resister Error!";
}
void Modbus::writeSingleHoldingRegisterCompleted()
{
    qDebug() << "Write Single Holding Resister Completed!";
}

void Modbus::readSingleHoldingRegister (int add, int ID)
{
    //startConnection();
    QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, add,1);
    if (auto *reply = modbusDevice->sendReadRequest(readUnit, ID)) {
       qDebug()<<"Reading single holding register ...";
      if (!reply->isFinished())
        connect(reply, &QModbusReply::finished, this, &Modbus::readSingleHoldingRegisterRecieved);
    } else
      qDebug() << "request error";
}
void Modbus::readSingleHoldingRegisterRecieved()
{
    QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
    const QModbusDataUnit result = reply->result();
    qDebug() << "read ";
    qDebug() << "";
    qDebug() << QString("The value is %1").arg(result.value(0));
    emit readSingleHoldingRegisterCompleted(result.value(0));
}

void Modbus::writeSingleCoil (int add, bool value, int server)
{
    //startConnection();
    QModbusDataUnit reg(QModbusDataUnit::Coils,add,1);
    reg.setValue(0,value);
    QModbusReply *reply;
    reply = modbusDevice->sendWriteRequest(reg,server);
    if (reply) {
        if (!reply->isFinished())
          connect(reply, &QModbusReply::finished, this, &Modbus::writeSingleCoilComleted);
      } else
        qDebug() << "Write Single Coil Error!";
}

void Modbus::writeSingleCoilComleted()
{
    qDebug() << "Write Single Coil Completed!";
}

void Modbus::readHoldingRegister(int server,int start_add, int number_register)
{
    nBytes = number_register;
    start_address = start_add;
    ID = server;

    QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, start_address,
                             static_cast<unsigned short>(nBytes));

    if (auto *reply = modbusDevice->sendReadRequest(readUnit, ID)) {
      if (!reply->isFinished())
        connect(reply, &QModbusReply::finished, this, &Modbus::readHoldingRegisterCompleted);
    } else
      qDebug() << "request error";

}

void Modbus::readHoldingRegisterCompleted() const {
  QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
  const QModbusDataUnit result = reply->result();
  qDebug() << "read ";
  qDebug() << "";

  for (int j = 0; j < nBytes; j++)
      qDebug() << QString("The value of %1 is %2").arg(j).arg(result.value(j));
}


void Modbus::stopConnection()
{
    modbusDevice->disconnectDevice();
    connection_state = false;
    qDebug() << "Ngat ket noi!";
    emit varChanged();
}
Modbus::~Modbus() {
  modbusDevice->disconnectDevice();
  delete modbusDevice;
  modbusDevice = nullptr;
}

