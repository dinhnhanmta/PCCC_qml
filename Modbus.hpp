#ifndef MODBUS_HPP
#define MODBUS_HPP

#include <QDebug>
#include <QModbusDataUnit>
#include <QModbusReply>
#include <QModbusRtuSerialMaster>
#include <QObject>
#include <QTimer>
#include <QtSerialPort/QSerialPort>
#include <QString>
#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

class Modbus: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString q_current_port READ getPort WRITE setPort NOTIFY varChanged)
    Q_PROPERTY(int q_baudrate READ getBaudrate WRITE setBaudrate NOTIFY varChanged)
    Q_PROPERTY(int q_dataBits READ getDataBits WRITE setDataBits NOTIFY varChanged)
    Q_PROPERTY(QString q_flow READ getFlow WRITE setFlow NOTIFY varChanged)
    Q_PROPERTY(QString q_parity READ getParity WRITE setParity NOTIFY varChanged)
    Q_PROPERTY(int q_stopBits READ getStopBits WRITE setStopBits NOTIFY varChanged)

signals:
    void varChanged ();
public:
  Modbus();
  ~Modbus();
public:
   void setPort(QString port){ m_portName = port;}
   QString getPort(){return m_portName;}

   void setBaudrate(int baudrate){ m_baudrate = baudrate;}
   int getBaudrate(){return m_baudrate;}

   void setDataBits(int databits){ m_dataBits = databits;}
   int getDataBits(){return m_dataBits;}

   void setFlow(QString flow){ m_flow = flow;}
   QString getFlow(){return m_flow;}

   void setParity(QString parity){ m_parity = parity;}
   QString getParity(){return m_parity;}

   void setStopBits(int stopbits){ m_stopBits = stopbits;}
   int getStopBits(){return m_stopBits;}

public:
   Q_INVOKABLE bool startConnection();   // khoi tao
   void writeSingleHoldingResister(int add, int value,int server);
   void writeSingleHoldingResisterCompleted();

private:
   QModbusRtuSerialMaster *modbusDevice;
   // parameter
   QString m_portName;
   int m_baudrate;
   int m_dataBits;
   QString m_flow;
   QString m_parity;
   int m_stopBits;
};

#endif // MODBUS_HPP
