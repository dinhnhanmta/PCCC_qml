#include "bientan.hpp"
Bientan::Bientan(Modbus *modbus)
{
    bientan_modbus = modbus;
    ID = 1;
}

void Bientan::write_friquency(int freq)
{
    bientan_modbus->writeSingleHoldingRegister(8193,freq,ID);
}

void Bientan::setStart(int val)
{
     bientan_modbus->writeSingleHoldingRegister(8192,val,ID);
}
