#include "cambienapsuat.hpp"

CamBienApSuat::CamBienApSuat()
{
    m_serial=new QSerialPort(this);
    connect(m_serial, &QSerialPort::errorOccurred, this, &CamBienApSuat::handleError);
    connect(m_serial, &QSerialPort::readyRead, this, &CamBienApSuat::readData);
    connect(this,&CamBienApSuat::receiveCompleted,this,&CamBienApSuat::OnReceiveCompleted);
    pressure = 0;
    m_receiveText="";
}

void CamBienApSuat::openSerialPort()
{
    m_serial->setPortName("/dev/" + settings->cambienParam.getPortName());
    m_serial->setBaudRate(settings->cambienParam.getBaudrate());
    m_serial->setDataBits((QSerialPort::DataBits)settings->cambienParam.getDataBits());

    if (settings->cambienParam.getParity() == "None") m_serial->setParity(QSerialPort::NoParity);
    else if (settings->cambienParam.getParity() == "Even") m_serial->setParity(QSerialPort::EvenParity);
    else if (settings->cambienParam.getParity() == "Odd") m_serial->setParity(QSerialPort::OddParity);
    m_serial->setStopBits(( QSerialPort::StopBits)settings->cambienParam.getStopBits());
    if (m_serial->open(QIODevice::ReadWrite)) {
        sendRequest();
    } else {
        qDebug()<< m_serial->errorString();
    }
}

void CamBienApSuat::closeSerialPort()
{
    if (m_serial->isOpen())
        m_serial->close();
}


void CamBienApSuat::writeData(const QByteArray &data)
{
    m_serial->write(data);
}

void CamBienApSuat::sendRequest()
{
        m_serial->write("#01\r");
}

void CamBienApSuat::readData()
{
    const QByteArray data = m_serial->readAll();
    for (int i=0;i<data.length();i++) {
        if (data[i]==13) emit receiveCompleted();
        m_receiveText +=data[i];
    }
}

void CamBienApSuat::OnReceiveCompleted()
{
   QStringList splitted;
    qDebug()<< "receive complete"<< m_receiveText;
     qDebug()<< "splitted";
    splitted = m_receiveText.split("+");
    val_pot = splitted[5].toFloat()/2.5*10;
    pressure = splitted[6].toFloat()/2.5*10;
    qDebug()<<"val_pot = "<<val_pot;
    qDebug()<<"pressure = "<<pressure;
    emit pressureChanged();

}
void CamBienApSuat::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        qDebug()<< m_serial->errorString();
        closeSerialPort();
    }
}
