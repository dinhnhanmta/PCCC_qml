#ifndef RELAY_HPP
#define RELAY_HPP

#include <QObject>
#include "modbus.hpp"

#define INPUT_VALVE_ADDRESS 3
#define OUTPUT_VALVE_ADDRESS 2
#define START_LED_ADDRESS 1
#define RELAY_ID 11

class Relay : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool q_start_led_state READ getStartLedState  NOTIFY stateChanged)
    Q_PROPERTY(bool q_ouput_vavle_state READ getOuputVavleState  NOTIFY stateChanged)
    Q_PROPERTY(bool q_input_vavle_state READ getInputVavleState  NOTIFY stateChanged)
public:
    explicit Relay(QObject *parent = nullptr);
    Relay(Modbus *modbus);

    Q_INVOKABLE void writeInputVavle(bool value);
    Q_INVOKABLE void writeOutputVavle(bool value);
    Q_INVOKABLE void writeStartLed(bool value);

    Q_INVOKABLE void readAllState();
    void readStateCompleted();


    bool getStartLedState(){return start_led_state;}
    bool getOuputVavleState(){return ouput_vavle_state;}
    bool getInputVavleState(){return input_vavle_state;}

signals:

    void stateChanged();

private:
    Modbus *relay_modbus;
    bool input_vavle_state = false;
    bool ouput_vavle_state = false;
    bool start_led_state = false;
    bool data_receive[3] = {false,false,false};
};

#endif // RELAY_HPP
