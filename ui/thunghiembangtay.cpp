#include "thunghiembangtay.h"

ThuNghiemBangTay::ThuNghiemBangTay(QObject *parent) : QObject(parent)
{

}

ThuNghiemBangTay::ThuNghiemBangTay(CamBienApSuat *cbap, Bientan *bientan, Modbus *modbus, Relay *relay)
{
    m_camBienApSuat = cbap;
    m_bienTan = bientan;
    m_modbus = modbus;
    m_relay = relay;
    m_lcd = new lcd(modbus);
    last_start_state = m_relay->getStartLedState();
}

void ThuNghiemBangTay::updateLogic()
{
    static int count_writeFre = 0;
    count_writeFre ++;
    if(count_writeFre ==10)  // cap nhat cham hon 10 lan
    {
        count_writeFre = 0;
        m_bienTan->write_friquency((int)(m_camBienApSuat->getValPot()*100));
        m_bienTan->readRealFrequency();

        m_lcd->writePressureLCD(int16_t(m_camBienApSuat->getPressure()*10));
//        m_lcd->writePressureLCD(200);

    }

    m_relay->readAllState();

    bool current_start_state = m_relay->getStartLedState();


    // Cap nhat gia tri bien tan
    if(current_start_state != last_start_state && current_start_state ==1)
    {
        last_start_state = current_start_state;
        m_bienTan->setStart(1);
    }
    else if(current_start_state != last_start_state && current_start_state ==0)
    {
        last_start_state = current_start_state;
        m_bienTan->setStart(5);
    }

}




