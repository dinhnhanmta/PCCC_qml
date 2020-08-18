#include "bientan.hpp"
bientan::bientan(Modbus *modbus)
{
    bientan_modbus = modbus;
    ID = 1;
}

bientan::bientan()
{

}

void bientan::write_friquency(int freq)
{
//    bientan_modbus->setBaudrate(baudrate);
    bientan_modbus->writeSingleHoldingRegister(8193,freq,ID);
}

void bientan::setStart(int val)
{
     bientan_modbus->writeSingleHoldingRegister(8192,val,ID);
}
