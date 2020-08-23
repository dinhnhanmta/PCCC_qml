#ifndef CAMBIENAPSUAT_HPP
#define CAMBIENAPSUAT_HPP
#include "Modbus.hpp"


class CamBienApSuat: public QObject, BaseObject
{
    Q_OBJECT
    Q_PROPERTY(float q_pressure READ getPressure WRITE setPressure NOTIFY pressureChanged)

    Q_PROPERTY(QString portname READ getPortName WRITE setPortName NOTIFY varChanged)
    Q_PROPERTY(int baudrate READ getBaudrate WRITE setBaudrate NOTIFY varChanged)
    Q_PROPERTY(QString flow READ getFlow WRITE setFlow NOTIFY varChanged)
    Q_PROPERTY(QString parity READ getParity WRITE setParity NOTIFY varChanged)
    Q_PROPERTY(int stopbits READ getStopBits WRITE setStopBits NOTIFY varChanged)
    Q_PROPERTY(int databits READ getDataBits WRITE setDatabits NOTIFY varChanged)

signals:
    void varChanged ();
    void pressureChanged ();
public:
    CamBienApSuat();
    float getPressure (){return pressure;}
    void setPressure (float p){pressure = p;}
    void setPortName(QString value){ settings->cambienParam.setPortName(value);}
    QString getPortName(){return settings->cambienParam.getPortName();}

    void setBaudrate(int value){ settings->cambienParam.setBaudrate(value);}
    int getBaudrate(){return settings->cambienParam.getBaudrate();}

    void setFlow(QString value){ settings->cambienParam.setFlow(value);}
    QString getFlow(){return settings->cambienParam.getFlow();}

    void setParity(QString value){ settings->cambienParam.setParity(value);}
    QString getParity(){return settings->cambienParam.getParity();}

    void setStopBits(int value){ settings->cambienParam.setStopBits(value);}
    int getStopBits(){return settings->cambienParam.getStopBits();}

    void setDatabits(int value){ settings->cambienParam.setDataBits(value);}
    int getDataBits(){return settings->cambienParam.getDataBits();}

    Q_INVOKABLE void openSerialPort();
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE void writeData(const QByteArray &data);
    Q_INVOKABLE void sendRequest();
    void readData();
    void handleError(QSerialPort::SerialPortError error);
signals:
    void receiveCompleted();
public slots:
    void OnReceiveCompleted();

private:
    QSerialPort *m_serial;
    float pressure;

    QString m_receiveText;
};

#endif // CAMBIENAPSUAT_HPP
