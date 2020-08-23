#include "bientan.hpp"
Bientan::Bientan(Modbus *modbus)
{
    bientan_modbus = modbus;
    ID = 1;
    velocity = 0;
    connect (bientan_modbus,&Modbus::readSingleHoldingRegisterCompleted,this,&Bientan::readVelocityCompleted);
}

void Bientan::write_friquency(int freq)
{
    bientan_modbus->writeSingleHoldingRegister(8193,freq,ID);
}

void Bientan::setStart(int val)
{
     bientan_modbus->writeSingleHoldingRegister(8192,val,ID);
}

void Bientan::readVelocity()
{
    bientan_modbus->readSingleHoldingRegister(address,1,&velocity);
}

void Bientan::readVelocityCompleted()
{
    emit varChanged();
}
