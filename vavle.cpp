#include "vavle.hpp"


Vavle::Vavle(Modbus *modbus)
{
    vavle_modbus = modbus;
    address1 = 1;
    address2 = 2;
    ID = 1;
    vavle_state1 = false;
    vavle_state2 = false;
    baudrate = 9600;
}
void Vavle::writeVavleState1()
{
    vavle_modbus->writeSingleCoil(address1,vavle_state1,ID);
}
void Vavle::writeVavleState2()
{
    vavle_modbus->writeSingleCoil(address2,vavle_state2,ID);
}
