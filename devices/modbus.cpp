#include "modbus.hpp"
#include <QObject>
#include <QModbusRtuSerialMaster>
#include <QThread>
Modbus::Modbus()  {
    modbusDevice = new QModbusRtuSerialMaster();
    nBytes= 0;
    nBytesInputResgister = 0;
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
//    qDebug() << "Write Single Holding Resister Completed!";
}

void Modbus::readSingleHoldingRegister (int add, int ID,int *data)
{
    //startConnection();
    QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, add,1);
    if (auto *reply = modbusDevice->sendReadRequest(readUnit, ID)) {
       qDebug()<<"Reading single holding register ...";
      if (!reply->isFinished())
        connect(reply, &QModbusReply::finished, this, &Modbus::readSingleHoldingRegisterRecieved);
    } else
      qDebug() << "request error";
    holding_register_result= data;
}
void Modbus::readSingleHoldingRegisterRecieved()
{
    QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
    const QModbusDataUnit result = reply->result();
    qDebug() << "read ";
    qDebug() << "";
    qDebug() << QString("The value is %1").arg(result.value(0));
    *holding_register_result = result.value(0);
    emit readSingleHoldingRegisterCompleted();
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
//    qDebug() << "Write Single Coil Completed!";
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

void Modbus::readDiscreteRegister(int server,int start_add, int number_register, int *data)
{
    nBytesInputResgister = number_register;
    start_address = start_add;
    ID = server;

    QModbusDataUnit readUnit(QModbusDataUnit::InputRegisters, start_address,
                             static_cast<unsigned short>(nBytesInputResgister));

    if (auto *reply = modbusDevice->sendReadRequest(readUnit, ID)) {
      if (!reply->isFinished())
        connect(reply, &QModbusReply::finished, this, &Modbus::readDiscreteRegisterCompleted);
    } else
      qDebug() << "request error";
    input_register_result = data;
}

void Modbus::readDiscreteRegisterCompleted() const {
  QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
  const QModbusDataUnit result = reply->result();
  qDebug() << "complete reading discrete register ";
//  qDebug() << "";

  for (int j = 0; j < nBytesInputResgister; j++)
  {
      input_register_result[j] =result.value(j);
//      qDebug() << QString("The value of %1 is %2").arg(j).arg(result.value(j));
  }

}


void Modbus::readHoldingRegisterCompleted() const {
  QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
  const QModbusDataUnit result = reply->result();
//  qDebug() << "read ";
//  qDebug() << "";

  for (int j = 0; j < nBytes; j++)
      qDebug() << QString("The value of %1 is %2").arg(j).arg(result.value(j));
}

void Modbus::readMultiCoils(int server,int start_add, int number_coils, bool *data)
{
    nBytes = number_coils;
    start_address = start_add;


    QModbusDataUnit readUnit(QModbusDataUnit::Coils, start_address,
                             static_cast<unsigned short>(nBytes));

    if (auto *reply = modbusDevice->sendReadRequest(readUnit, server)) {
      if (!reply->isFinished())
        //      connect the finished signal of the request to your read slot
        connect(reply, &QModbusReply::finished, this, &Modbus::readCoilsCompleted);
      //    else
      //      delete reply; // broadcast replies return immediately
    } else
      qDebug() << "request error";

    coil_result = data;
}

void Modbus::readCoilsCompleted()  {
  QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
  const QModbusDataUnit result = reply->result();
//  qDebug() << "read ";
//  qDebug() << "";

  for (int j = 0; j < nBytes; j++)
  {
    coil_result[j] = result.value(j);
//    qDebug() << QString("The coil value of %1 is %2").arg(j).arg(result.value(j));
  }
  emit readCoilsCompletedSignal ();
}

void Modbus::readMultiDiscrete(int server,int start_add, int number_coils, bool *data)
{

    nDiscrete = number_coils;
    QModbusDataUnit readUnit(QModbusDataUnit::DiscreteInputs, start_add,
                             static_cast<unsigned short>(number_coils));

    if (auto *reply = modbusDevice->sendReadRequest(readUnit, server)) {
      if (!reply->isFinished())
        //      connect the finished signal of the request to your read slot
        connect(reply, &QModbusReply::finished, this, &Modbus::readDiscreteCompleted);
      //    else
      //      delete reply; // broadcast replies return immediately
    } else
      qDebug() << "request error";

     discrete_result= data;
}
void Modbus::readDiscreteCompleted()  {
  QModbusReply *reply = qobject_cast<QModbusReply *>(sender());
  const QModbusDataUnit result = reply->result();

  for (int j = 0; j < nDiscrete; j++)
  {
    discrete_result[j] = result.value(j);
//    qDebug() << QString("The Discrete Input value of %1 is %2").arg(j).arg(result.value(j));
  }
  emit readDiscreteCompletedSignal ();
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

