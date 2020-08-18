#include "cambienapsuat.hpp"

camBienApSuat::camBienApSuat()
{
    m_serial=new QSerialPort(this);
    connect(m_serial, &QSerialPort::errorOccurred, this, &camBienApSuat::handleError);
    connect(m_serial, &QSerialPort::readyRead, this, &camBienApSuat::readData);
    connect(this,&camBienApSuat::receiveCompleted,this,&camBienApSuat::OnReceiveCompleted);
    pressure = 0;
    m_baudrate = 9600;
    m_stopBits = 1;
    m_parity = "None";
    m_dataBits = 8;
    m_portName = "/dev/ttyUSB0";

    m_receiveText="";
}

void camBienApSuat::openSerialPort()
{
    m_serial->setPortName(m_portName);
    m_serial->setBaudRate(m_baudrate);
    m_serial->setDataBits((QSerialPort::DataBits)m_dataBits);

    if (m_parity == "None") m_serial->setParity(QSerialPort::NoParity);
    else if (m_parity == "Even") m_serial->setParity(QSerialPort::EvenParity);
    else if (m_parity == "Odd") m_serial->setParity(QSerialPort::OddParity);
    m_serial->setStopBits(( QSerialPort::StopBits)m_stopBits);
    if (m_serial->open(QIODevice::ReadWrite)) {
        qDebug()<<(tr("Connected to %1 : %2, %3, %4, %5, %6")
                          .arg(m_portName).arg(m_baudrate).arg(m_dataBits)
                          .arg(m_parity).arg(m_stopBits).arg(m_flow));

    sendRequest();
    } else {
        qDebug()<< m_serial->errorString();


    }
}

void camBienApSuat::closeSerialPort()
{
    if (m_serial->isOpen())
        m_serial->close();

}


void camBienApSuat::writeData(const QByteArray &data)
{
    m_serial->write(data);
}

void camBienApSuat::sendRequest()
{

        m_serial->write("#01\r");
}



void camBienApSuat::readData()
{
    const QByteArray data = m_serial->readAll();
    //qDebug()<<"dulieu... "<<data;
    for (int i=0;i<data.length();i++) {
        if (data[i]==13) emit receiveCompleted();
        m_receiveText +=data[i];
    }
}

void camBienApSuat::OnReceiveCompleted()
{
   QStringList splitted;
    qDebug()<< "receive complete"<< m_receiveText;
     qDebug()<< "splitted";
    splitted = m_receiveText.split("+");
    /*for (int i=0;i<splitted.size();i++) {
        qDebug()<<splitted[i];
    }*/
    pressure = splitted[6].toFloat()/2.5*10;
    emit pressureChanged();

}
void camBienApSuat::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        qDebug()<< m_serial->errorString();
        closeSerialPort();
    }
}


/*
camBienApSuat::camBienApSuat(Modbus *modbus)
{

     m_serial=new QSerialPort(this);
    connect(m_serial, &QSerialPort::errorOccurred, this, &camBienApSuat::handleError);
    connect(m_serial, &QSerialPort::readyRead, this, &camBienApSuat::readData);

    camBienModbus = modbus;
    address = 8;
    ID = 2;
    pressure = 0;
    baudrate= 9600;

    m_baudrate = 9600;
    m_stopBits = 1;
    m_parity = "None";
    m_dataBits = 8;
    m_portName = "/dev/ttyACM0";
}

void camBienApSuat::readPressure()
{
    camBienModbus->setBaudrate(baudrate);
    connect(camBienModbus,&Modbus::readSingleHoldingRegisterCompleted,this,&camBienApSuat::readPressureCompleted);
    camBienModbus->readSingleHoldingRegister(address,ID);
}
void camBienApSuat::readPressureCompleted(int value)
{
    pressure = value;
    qDebug() << "Receive Pressure Value: " << value;
}

*/
