#ifndef CAMBIENAPSUAT_HPP
#define CAMBIENAPSUAT_HPP
#include "modbus.hpp"


class CamBienApSuat: public QObject, BaseObject
{
    Q_OBJECT
    Q_PROPERTY(float q_pressure READ getPressure WRITE setPressure NOTIFY pressureChanged)
    Q_PROPERTY(float q_val_pot READ getValPot NOTIFY pressureChanged)

    Q_PROPERTY(bool q_connectionState READ getState WRITE setState NOTIFY varChanged)
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
    float getValPot(){return  val_pot;}
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
    bool getState() const;
    void setState(bool value);

signals:
    void receiveCompleted();
public slots:
    void OnReceiveCompleted();

private:
    QSerialPort *m_serial;
    bool connection_state= false;
    float pressure;
    float val_pot;
    QString m_receiveText;
};    Q_INVOKABLE void writeData(const QByteArray &data);


#endif // CAMBIENAPSUAT_HPP
