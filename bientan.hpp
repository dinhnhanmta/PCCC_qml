#ifndef BIENTAN_H
#define BIENTAN_H
#include "modbus.hpp"

class Bientan: public QObject {
    Q_OBJECT
    Q_PROPERTY(int q_address READ getAddress WRITE setAddress NOTIFY varChanged)
    Q_PROPERTY(int q_ID READ getID WRITE setID NOTIFY varChanged)
    Q_PROPERTY(int q_baudrate READ getBaudrate WRITE setBaudrate NOTIFY varChanged)
    Q_PROPERTY(int q_frequency READ getFrequency WRITE setFrequency NOTIFY varChanged)

     Q_PROPERTY(int q_velocity  READ getVelocity  NOTIFY varChanged)
signals:
    void varChanged ();
public:
    Bientan(Modbus *modbus);

public:
    int getAddress (){return address;}
    void setAddress (int add){address = add;}

    int getID (){return ID;}
    void setID (int i){ID = i;}

    int getBaudrate(){return baudrate;}
    void setBaudrate (int rate){baudrate = rate;}

    int getFrequency(){return frequency;}
    void setFrequency (int fred){frequency = fred;}
    int getVelocity(){return velocity;}
    void readVelocityCompleted();
public:
    Q_INVOKABLE void write_friquency(int freq);

    Q_INVOKABLE void setStart(int val);
    Q_INVOKABLE void readVelocity();
private:
    Modbus *bientan_modbus;
    int address;
    int ID;
    int baudrate;
    int frequency;
    int velocity;
};

#endif // BIENTAN_H
