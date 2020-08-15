#ifndef CAMBIENAPSUAT_HPP
#define CAMBIENAPSUAT_HPP
#include "Modbus.hpp"


class camBienApSuat: public QObject
{
    Q_OBJECT
    //Q_PROPERTY(int q_address READ getAddress WRITE setAddress NOTIFY varChanged)
   // Q_PROPERTY(int q_ID READ getID WRITE setID NOTIFY varChanged)
    Q_PROPERTY(float q_pressure READ getPressure WRITE setPressure NOTIFY varChanged)
signals:
    void varChanged ();
public:
    camBienApSuat();
    //camBienApSuat(Modbus *modbus);
    //int getAddress (){return address;}
    //void setAddress (int add){address = add;}
    //int getID (){return ID;}
    //void setID (int i){ID = i;}

    float getPressure (){return pressure;}
    void setPressure (float p){pressure = p;}

public:
    //void readPressure();
    //void readPressureCompleted(int value);

public:
    Q_INVOKABLE void openSerialPort();
    void closeSerialPort();
    Q_INVOKABLE void writeData(const QByteArray &data);
    Q_INVOKABLE void writeData1();
    void readData();
    void handleError(QSerialPort::SerialPortError error);
private:
    //int address;
    //int ID;
    //int baudrate;

    //Modbus *camBienModbus;
    QSerialPort *m_serial;
    float pressure;
    QString m_portName;
    int m_baudrate;
    int m_dataBits;
    QString m_flow;
    QString m_parity;
    int m_stopBits;
};

#endif // CAMBIENAPSUAT_HPP
