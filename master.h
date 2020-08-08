#ifndef MASTER_H
#define MASTER_H
#include <QString>
#include <QObject>
#include <Modbus.hpp>
class master: public QObject {
  Q_OBJECT
    Q_PROPERTY( int q_number_port READ getNumberPort  NOTIFY varChanged)
    Q_PROPERTY(QStringList q_port READ getPort NOTIFY varChanged)
    Q_PROPERTY(QString q_current_port WRITE setPort NOTIFY varChanged)
signals:
    void varChanged ();
public:
    Modbus *master_modbusDevice;
    master();
    master(Modbus *modbus_device);
    Q_INVOKABLE void getPortAvalable (void);
    int getNumberPort(){return m_number_port;}
    Q_INVOKABLE bool startConnection();
    QStringList getPort() {
            return m_port;
        }
    void setPort(QString port)
    {
        m_port_name = port;
    }


private:
     QString  m_port_name;       // danh sach cong com
     int m_number_port;               // so luong cong com
     QStringList m_port;


};

#endif // MASTER_H
