#include "relay.hpp"

Relay::Relay(QObject *parent) : QObject(parent)
{

}
//#define INPUT_VALVE_ADDRESS 3
//#define OUTPUT_VALVE_ADDRESS 2
//#define START_LED_ADDRESS 1
//#define RELAY_ID 11

Relay::Relay(Modbus *modbus)
{
   relay_modbus = modbus;
   connect(modbus,&Modbus::readCoilsCompletedSignal,this,&Relay::readStateCompleted);
   connect(modbus,&Modbus::readDiscreteCompletedSignal,this,&Relay::readDiscreteCompleted);
}

void Relay::writeInputVavle(bool value)
{
    relay_modbus->writeSingleCoil(INPUT_VALVE_ADDRESS,value,RELAY_ID);
}

void Relay::writeOutputVavle(bool value)
{
    relay_modbus->writeSingleCoil(OUTPUT_VALVE_ADDRESS,value,RELAY_ID);
}

void Relay::writeStartLed(bool value)
{
    relay_modbus->writeSingleCoil(START_LED_ADDRESS,value,RELAY_ID);
}

void Relay::readAllState()
{
    relay_modbus -> readMultiCoils(RELAY_ID,START_LED_ADDRESS,3,data_receive);
    relay_modbus -> readMultiDiscrete(RELAY_ID,0,3,discrete_receive);
}

void Relay::readDiscreteCompleted()
{

    if(discrete_receive[0] ==1 && last_start_led_state ==false)
    {
        last_start_led_state = true;
        start_led_state = !start_led_state;
        relay_modbus ->writeSingleCoil(START_LED_ADDRESS,start_led_state,RELAY_ID);
    }
    if(discrete_receive[0] ==0) last_start_led_state = false;

    if(discrete_receive[1] ==1 && last_input_vavle_state ==false)
    {
        last_input_vavle_state = true;
        input_vavle_state = !input_vavle_state;
        relay_modbus ->writeSingleCoil(INPUT_VALVE_ADDRESS,input_vavle_state,RELAY_ID);
    }
    if(discrete_receive[1] ==0 ) last_input_vavle_state =false;
    if(discrete_receive[2] ==1 && last_ouput_vavle_state ==false)
    {
        last_ouput_vavle_state = true;
        ouput_vavle_state = !ouput_vavle_state;
        relay_modbus ->writeSingleCoil(OUTPUT_VALVE_ADDRESS,ouput_vavle_state,RELAY_ID);
    }
    if(discrete_receive[2] ==0 ) last_ouput_vavle_state =false;
}
void Relay::readStateCompleted()
{
    start_led_state = data_receive[0];
    input_vavle_state = data_receive[2];
    ouput_vavle_state = data_receive[1];
    emit stateChanged();

}
