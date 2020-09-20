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
        connection_state = true;
        emit varChanged();
    } else {
        qDebug()<< m_serial->errorString();
        connection_state = false;
        emit varChanged();
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
        //        qDebug() << "write #01\r";
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
    qDebug()<< "receive complete"<< m_receiveText;
//     qDebug()<< "splitted";
    QStringList splitted ;
    splitted = m_receiveText.split("+");
    qDebug()<<"pressure = "<<splitted[7].toFloat();
    pressure = (splitted[7].toFloat()-0.877)*25/(4.380-0.877); //2.5*10; // Tu Voi

//    pressure = (splitted[7].toFloat()-0.878)*25/(4.385-0.878); //2.5*10; // Tu khop noi
//    pressure = (splitted[7].toFloat()-0.879)*60/(4.390-0.879); //2.5*10; // Tu spinkler ap luc
//    pressure = (splitted[7].toFloat()-0.878)*40/(4.385-0.878); //2.5*10; // Tu spinkler luu luong
//    pressure = ((splitted[7].toFloat()-0.874)*1/(4.37-0.874)) -1 ; //2.5*10; // Ap suat am vali
//      pressure = (splitted[7].toFloat()-0.88)*250/(4.396-0.88); //2.5*10; // Tu thu no binh chua chay
//       pressure = (splitted[7].toFloat()-0.879)*40/(4.391-0.879); //2.5*10; // tu kiem dinh tru
//        pressure = (splitted[7].toFloat()-0.878)*25/(4.384-0.878); //2.5*10; // tu kiem dinh Lang
    val_pot = splitted[6].toFloat()*5; //2.5*10;
//    qDebug()<<"val_pot = "<<val_pot;

    m_receiveText = "";
    emit pressureChanged();

}

bool CamBienApSuat::getState() const
{
    return connection_state;
}

void CamBienApSuat::setState(bool value)
{
    connection_state = value;
}
void CamBienApSuat::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        qDebug()<< m_serial->errorString();
        closeSerialPort();
    }
}
