#ifndef CAMBIENAPSUAT_HPP
#define CAMBIENAPSUAT_HPP
#include "modbus.hpp"


class CamBienApSuat: public QObject
{
    Q_OBJECT
    //Q_PROPERTY(int q_address READ getAddress WRITE setAddress NOTIFY varChanged)
   // Q_PROPERTY(int q_ID READ getID WRITE setID NOTIFY varChanged)
    Q_PROPERTY(float q_pressure READ getPressure WRITE setPressure NOTIFY pressureChanged)

    Q_PROPERTY(QString q_portName READ getPortName WRITE setPortName NOTIFY varChanged)
    Q_PROPERTY(QString q_flow READ getFlow WRITE setFlow NOTIFY varChanged)
    Q_PROPERTY(QString q_parity READ getParity WRITE setParity NOTIFY varChanged)
    Q_PROPERTY(int q_baudrate READ getBaudrate WRITE setBaudrate NOTIFY varChanged)
    Q_PROPERTY(int q_dataBits READ getDatabits WRITE setDatabis NOTIFY varChanged)
    Q_PROPERTY(int q_stopBits READ getStopbits WRITE setStopbits NOTIFY varChanged)
    Q_PROPERTY(bool q_connectionState READ getState NOTIFY varChanged)

signals:
    void varChanged ();
    void pressureChanged ();
public:
    CamBienApSuat();
    float getPressure (){return pressure;}
    void setPressure (float p){pressure = p;}

    QString getPortName (){return m_portName;}
    void setPortName (QString p){m_portName = p;}
    QString getFlow (){return m_flow;}
    void setFlow (QString p){m_flow = p;}
    QString getParity (){return m_parity;}
    void setParity (QString p){m_parity = p;}
    int getBaudrate (){return m_baudrate;}
    void setBaudrate (int p){m_baudrate = p;}
    int getDatabits (){return m_dataBits;}
    void setDatabis (int p){m_dataBits = p;}
    int getStopbits (){return m_stopBits;}
    void setStopbits (int p){m_stopBits = p;}

    bool getState () {return connection_state;}
public:
    //void readPressure();
    //void readPressureCompleted(int value);
signals:
    void receiveCompleted();
public slots:
    void OnReceiveCompleted();
public:
    Q_INVOKABLE void openSerialPort();
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE void writeData(const QByteArray &data);
    Q_INVOKABLE void sendRequest();
    void readData();
    void handleError(QSerialPort::SerialPortError error);
private:
    QSerialPort *m_serial;
    float pressure;
    QString m_portName;
    int m_baudrate;
    int m_dataBits;
    QString m_flow;
    QString m_parity;
    int m_stopBits;
    bool connection_state;
    QString m_receiveText;
};

#endif // CAMBIENAPSUAT_HPP
