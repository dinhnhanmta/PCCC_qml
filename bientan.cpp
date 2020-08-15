#include "bientan.hpp"
bientan::bientan(Modbus *modbus)
{
    bientan_modbus = modbus;
}

bientan::bientan()
{

}

void bientan::write_friquency()
{
    bientan_modbus->setBaudrate(baudrate);
    bientan_modbus->writeSingleHoldingRegister(address,frequency,ID);
}
