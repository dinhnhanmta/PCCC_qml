#include "kiemdinhtudong.hpp"

QList<double> KiemDinhTuDong::getPCurrent()
{
    return _pCurrent;
}

QList<double> KiemDinhTuDong::getPRefer()
{
    return _pRefer;
}

QList<QString> KiemDinhTuDong::getXValue()
{
    QList<QString> list = QList<QString>();
    foreach (const QDateTime & ele, _xValue) {
        list << ele.toString("mm.ss");
    }
    return list;
}

void KiemDinhTuDong::setPWorking(QString value)
{
    _pWorking = value.toFloat();
}

void KiemDinhTuDong::setPTried(QString value)
{
    _pTried = value.toFloat();
}

KiemDinhTuDong::KiemDinhTuDong(CamBienApSuat *cbap, Bientan *bientan, Modbus *modbus, Relay *relay)
{
    _pCurrent = QList<double>() << 0;
    _pRefer = QList<double>() << 0;
    _xValue = QList<QDateTime>();
    _xValue.append(QDateTime::currentDateTime());

    m_camBienApSuat = cbap;
    m_bienTan = bientan;
    m_modbus = modbus;
    m_relay = relay;
    m_lcd = new lcd(modbus);
    last_start_state = m_relay->getStartLedState();
}



void KiemDinhTuDong::updateLogic()
{
    static int count_writeFre = 0;
    count_writeFre ++;
    if(count_writeFre ==100)  // cap nhat cham hon 10 lan
    {
        count_writeFre = 0;
//        m_bienTan->write_friquency((int)(m_camBienApSuat->getValPot()*100));
        m_bienTan->readRealFrequency();
        m_lcd->writePressureLCD(m_camBienApSuat->getPressure());
        if (_xValue.size() > 30){
            _xValue.pop_front();
            _pRefer.pop_front();
            _pCurrent.pop_front();
        }
        _xValue.append(QDateTime::currentDateTime());
        _pRefer.append(updatePRefer(_pRefer.last()));
        saveData.append(_pRefer);
        _pCurrent.append(m_camBienApSuat->getPressure());
        emit xValueChange();
    }

    m_relay->readAllState();

    bool current_start_state = m_relay->getStartLedState();

    // Cap nhat gia tri bien tan
    if(current_start_state != last_start_state && current_start_state ==1){
        last_start_state = current_start_state;
        m_bienTan->setStart(1);
    } else if(current_start_state != last_start_state && current_start_state ==0){
        last_start_state = current_start_state;
        m_bienTan->setStart(5);
    }
}

void KiemDinhTuDong::checkState(){
    if (counter > 0){
        counter --;
    }
    updateState();
}

bool KiemDinhTuDong::isRunning()
{
    return running;
}

void KiemDinhTuDong::start(){
    startTime = QDateTime::currentDateTime();
    saveData = QList<double>();
    running = true;
}

void KiemDinhTuDong::stop(){
    state = ST_IDLE;
    counter = 0;
    running = false;
}

void KiemDinhTuDong::updateState()
{
    switch (state) {
        case ST_IDLE:
            if (running) state = ST_PREPARATION;
            break;
        case ST_PREPARATION:
            if (m_camBienApSuat->getPressure() > 0) state = ST_START;
            break;
        case ST_START:
            if (m_camBienApSuat->getPressure() >= _pWorking) {
                state = ST_WORKING_P_TEST;
                counter = 60*3;
            }
            break;
        case ST_WORKING_P_TEST:
            if (counter == 0) state = ST_PUMP_UP_TO_TEST;
            break;
        case ST_PUMP_UP_TO_TEST:
            if (m_camBienApSuat->getPressure() > _pTried) {
                state = ST_TEST_PRESSURE;
                counter = 60*2;
            }
            break;
        case ST_TEST_PRESSURE:
            if (counter == 0) state = ST_PUMPDOWN;
            break;
        case ST_PUMPDOWN:
            if (m_camBienApSuat->getPressure() < 0.2) state = ST_FINISH;
            break;
        case ST_FINISH:
            state = ST_IDLE;
            running = false;
            break;
    }
}

double KiemDinhTuDong::updatePRefer(double _currentPRefer){
    double tmp;
    switch (state) {
        case ST_START:
            tmp = _currentPRefer + 0.083;
            return tmp < _pWorking ? tmp : _currentPRefer;
        case ST_PUMP_UP_TO_TEST:
            tmp = _currentPRefer + 0.083;
            return tmp < _pTried ? tmp : _currentPRefer;
    }
    return _currentPRefer;
}
