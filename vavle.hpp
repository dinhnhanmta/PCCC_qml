#ifndef VAVLE_HPP
#define VAVLE_HPP
#include "modbus.hpp"

class Vavle: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int q_address1 READ getAddress1 WRITE setAddress1 NOTIFY varChanged)
    Q_PROPERTY(int q_address2 READ getAddress2 WRITE setAddress2 NOTIFY varChanged)
    Q_PROPERTY(int q_ID READ getID WRITE setID NOTIFY varChanged)
    Q_PROPERTY(bool q_vavleState1 READ getVavleState1 WRITE setVavleState1 NOTIFY varChanged)
    Q_PROPERTY(bool q_vavleState2 READ getVavleState2 WRITE setVavleState2 NOTIFY varChanged)
signals:
    void varChanged ();
public:
    Vavle(Modbus *modbus);

    int getAddress2 (){return address2;}
    void setAddress2 (int add){address2 = add;}

    int getAddress1 (){return address1;}
    void setAddress1 (int add){address1 = add;}

    int getID (){return ID;}
    void setID (int i){ID = i;}

    void setVavleState1 (bool state){vavle_state1 = state;}
    bool getVavleState1 (){return vavle_state1;}

    void setVavleState2 (bool state){vavle_state2 = state;}
    bool getVavleState2 (){return vavle_state2;}

public:
    Q_INVOKABLE void writeVavleState1();
    Q_INVOKABLE void writeVavleState2();
private:
    bool vavle_state1;
    bool vavle_state2;
    int address1;
    int address2;
    int ID;
    int baudrate;
    Modbus *vavle_modbus;
};

#endif // VAVLE_HPP
