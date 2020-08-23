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
}


void Relay::readStateCompleted()
{
    start_led_state = data_receive[0];
    input_vavle_state = data_receive[2];
    ouput_vavle_state = data_receive[1];
    emit stateChanged();

}
