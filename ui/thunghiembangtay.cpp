#include "thunghiembangtay.h"

ThuNghiemBangTay::ThuNghiemBangTay(QObject *parent) : QObject(parent)
{

}

ThuNghiemBangTay::ThuNghiemBangTay(CamBienApSuat *cbap, Modbus *modbus)
{
    m_camBienApSuat = cbap;
    m_modbus = modbus;
    m_bienTan = new Bientan(modbus);
    m_relay = new Relay(modbus);
    m_lcd = new lcd(modbus);
    m_dong_ho_ll = new DongHoLuuLuong(modbus);

    m_bienTan->setID(1);
    m_relay->setID(11);  // dia chi relay
    m_lcd->setId(10);   // dia chi modbus lcd
    last_start_state = m_relay->getStartLedState();
//    connect(m_relay,&Relay::readStateCompleted, this, &ThuNghiemBangTay::readRelayDone);
//    connect(m_relay,&Relay::readDiscreteCompleted, this, &ThuNghiemBangTay::readButtonDone);

}

ThuNghiemBangTay::~ThuNghiemBangTay()
{
    delete m_bienTan;
    delete m_lcd;
    delete m_relay;
}

void ThuNghiemBangTay::updateLogic()
{
    static int count_writeFre = 0;
    count_writeFre ++;
    if(count_writeFre ==10)  // cap nhat cham hon 10 lan
    {
        count_writeFre = 0;

        if(is_test_luu_luong)
        {
               m_bienTan->write_friquency((int)(m_camBienApSuat->getValPot()*100));
//                    m_bienTan->readRealFrequency();
                m_lcd->writePressureLCD(int16_t(m_camBienApSuat->getPressureLl()*10));
                m_dong_ho_ll->getLuuLuong();
        }
        else {
            m_lcd->writePressureLCD(int16_t(m_camBienApSuat->getPressure()*10));
        }



//        qDebug()<< "update pot";

//        m_lcd->writePressureLCD(250);

         qDebug()<< "id lcd" << m_lcd->getId();
         qDebug()<< "id bientan" << m_bienTan->getID();
         qDebug()<< "id relay" << m_relay->getID();
         qDebug()<< "is test luu luong" <<  is_test_luu_luong;
    }

    m_relay->readAllState();

    bool current_start_state = m_relay->getStartLedState();

//     Cap nhat gia tri bien tan
    if(current_start_state != last_start_state && current_start_state ==1)
    {
        last_start_state = current_start_state;
        if(is_test_luu_luong)
        {
            m_bienTan->setStart(1);
        }

    }
    else if(current_start_state != last_start_state && current_start_state ==0)
    {
        last_start_state = current_start_state;
        if(is_test_luu_luong)
        {
            m_bienTan->setStart(5);
        }
    }
    emit stateChanged();
}

bool ThuNghiemBangTay::getLedStart()
{
    return m_relay->getStartLedState();
}

bool ThuNghiemBangTay::getValveUp()
{
    return m_relay->getInputVavleState();
}

bool ThuNghiemBangTay::setLedStart(bool val)
{
    m_relay->writeStartLed(val);
}

void ThuNghiemBangTay::setLedValveUp(bool val)
{
    m_relay->writeInputVavle(val);
}

void ThuNghiemBangTay::setLedValveDown(bool val)
{
    m_relay->writeOutputVavle(val);
}

void ThuNghiemBangTay::setLcdID(int id)
{
    m_lcd->setId(id);
}

void ThuNghiemBangTay::setBienTanID(int id)
{
    m_bienTan->setID(id);
}

void ThuNghiemBangTay::setRelayID(int id)
{
    m_relay->setID(id);
}

void ThuNghiemBangTay::swapTuLuuLuong(bool value)
{
    is_test_luu_luong = value;
    if(is_test_luu_luong ==false){
        m_relay->setID(11);
        m_lcd->setId(10);
    }
    else {
        m_relay->setID(21);
        m_lcd->setId(20);
        m_bienTan->setID(2);
    }

}

void ThuNghiemBangTay::readRelayDone()
{
    emit stateChanged();
}

void ThuNghiemBangTay::readButtonDone()
{
    emit stateChanged();
}

bool ThuNghiemBangTay::getValveDown()
{
    return m_relay->getOuputVavleState();
}





