#ifndef RELAY_HPP
#define RELAY_HPP

#include <QObject>
#include "modbus.hpp"

#define INPUT_VALVE_ADDRESS 3
#define OUTPUT_VALVE_ADDRESS 2
#define START_LED_ADDRESS 1

class Relay : public QObject
{
public:
    explicit Relay(QObject *parent = nullptr);
    Relay(Modbus *modbus);

    void writeInputVavle(bool value);
    void writeOutputVavle(bool value);
    void writeStartLed(bool value);

    void readAllState();

    int getID() {return RELAY_ID;}
    void setID(int id)
    {
        RELAY_ID = id;
    }

    void readStateCompleted();
    void readDiscreteCompleted();

    bool getStartLedState(){ return start_led_state;}
    bool getOuputVavleState(){return ouput_vavle_state;}
    bool getInputVavleState(){return input_vavle_state;}

private:

    int RELAY_ID;
    Modbus *relay_modbus;
    bool input_vavle_state = false;
    bool ouput_vavle_state = false;
    bool start_led_state = false;
    bool last_start_led_state = false;
    bool last_input_vavle_state = false;
    bool last_ouput_vavle_state = false;
    bool start_status = false;
    bool data_receive[3] = {false,false,false};
    bool discrete_receive[3] = {false,false,false};

};

#endif // RELAY_HPP
