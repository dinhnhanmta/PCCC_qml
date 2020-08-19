#include "modbus.hpp"
#include <QObject>
#include <QModbusRtuSerialMaster>
#include <QThread>
Modbus::Modbus() {
    modbusDevice = new QModbusRtuSerialMaster();
    m_baudrate =19200;
    m_dataBits = 8;
    m_portName = "ttyUSB0";
    m_parity = "None";
    m_stopBits =1;
    nBytes= 0;
}

bool Modbus::startConnection() {
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
        //      connect the finished signal of the request to your read slot
        connect(reply, &QModbusReply::finished, this, &Modbus::readSingleHoldingRegisterRecieved);
      //    else
      //      delete reply; // broadcast replies return immediately
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
   // startConnection();
    nBytes = number_register;
    start_address = start_add;
    ID = server;

    QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, start_address,
                             static_cast<unsigned short>(nBytes));

    if (auto *reply = modbusDevice->sendReadRequest(readUnit, ID)) {
      if (!reply->isFinished())
        //      connect the finished signal of the request to your read slot
        connect(reply, &QModbusReply::finished, this, &Modbus::readHoldingRegisterCompleted);
      //    else
      //      delete reply; // broadcast replies return immediately
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

