#ifndef BIENTAN_H
#define BIENTAN_H
#include "Modbus.hpp"

class bientan: public QObject {
    Q_OBJECT
    Q_PROPERTY(int q_address READ getAddress WRITE setAddress NOTIFY varChanged)
    Q_PROPERTY(int q_ID READ getID WRITE setID NOTIFY varChanged)
    Q_PROPERTY(int q_baudrate READ getBaudrate WRITE setBaudrate NOTIFY varChanged)
    Q_PROPERTY(int q_frequency READ getFrequency WRITE setFrequency NOTIFY varChanged)
signals:
    void varChanged ();
public:
    bientan();
    bientan(Modbus *modbus);

public:
    int getAddress (){return address;}
    void setAddress (int add){address = add;}

    int getID (){return ID;}
    void setID (int i){ID = i;}

    int getBaudrate(){return baudrate;}
    void setBaudrate (int rate){baudrate = rate;}

    int getFrequency(){return frequency;}
    void setFrequency (int fred){frequency = fred;}

public:
    Q_INVOKABLE void write_friquency();
private:
    Modbus *bientan_modbus;
    int address;
    int ID;
    int baudrate;
    int frequency;
};

#endif // BIENTAN_H
