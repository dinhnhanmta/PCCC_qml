#ifndef RELAY_HPP
#define RELAY_HPP

#include <QObject>
#include "modbus.hpp"

#define INPUT_VALVE_ADDRESS 3
#define OUTPUT_VALVE_ADDRESS 2
#define START_LED_ADDRESS 1
#define RELAY_ID 11
#define RELAY_ID_LL 21

class Relay : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool q_start_led_state READ getStartLedState  NOTIFY stateChanged)
    Q_PROPERTY(bool q_ouput_vavle_state READ getOuputVavleState  NOTIFY stateChanged)
    Q_PROPERTY(bool q_input_vavle_state READ getInputVavleState  NOTIFY stateChanged)

    Q_PROPERTY(bool q_start_led_stateLL READ getStartLedStateLL  NOTIFY stateChangedLL)
    Q_PROPERTY(bool q_ouput_vavle_stateLL READ getOuputVavleStateLL  NOTIFY stateChangedLL)
    Q_PROPERTY(bool q_input_vavle_stateLL READ getInputVavleStateLL  NOTIFY stateChangedLL)
public:
    explicit Relay(QObject *parent = nullptr);
    Relay(Modbus *modbus);

    Q_INVOKABLE void writeInputVavle(bool value);
    Q_INVOKABLE void writeOutputVavle(bool value);
    Q_INVOKABLE void writeStartLed(bool value);

    Q_INVOKABLE void writeInputVavleLL(bool value);
    Q_INVOKABLE void writeOutputVavleLL(bool value);
    Q_INVOKABLE void writeStartLedLL(bool value);

    Q_INVOKABLE void readAllState();
    Q_INVOKABLE void readAllStateLL();
    void readStateCompleted();
    void readDiscreteCompleted();
    bool getStartLedState(){return start_led_state;}
    bool getOuputVavleState(){return ouput_vavle_state;}
    bool getInputVavleState(){return input_vavle_state;}

    bool getStartLedStateLL(){return start_led_state;}
    bool getOuputVavleStateLL(){return ouput_vavle_state;}
    bool getInputVavleStateLL(){return input_vavle_state;}
//    bool getStartButton(){return last_start_led_state;}
signals:

    void stateChanged();
    void stateChangedLL();
//    void buttonStartChange();

private:
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

    bool input_vavle_stateLL = false;
    bool ouput_vavle_stateLL = false;
    bool start_led_stateLL = false;
    bool last_start_led_stateLL = false;
    bool last_input_vavle_stateLL = false;
    bool last_ouput_vavle_stateLL = false;
    bool start_statusLL = false;
    bool data_receiveLL[3] = {false,false,false};
    bool discrete_receiveLL[3] = {false,false,false};
};

#endif // RELAY_HPP
