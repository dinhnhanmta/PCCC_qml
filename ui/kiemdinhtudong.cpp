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
    static int count_relay = 0;
    count_writeFre ++;
    count_relay ++;
    if(count_writeFre ==10)  // cap nhat cham hon 10 lan
    {
        count_writeFre = 0;
        qDebug()<< "update chart";
//        m_bienTan->write_friquency((int)(m_camBienApSuat->getValPot()*100));
        m_bienTan->readRealFrequency();
        m_lcd->writePressureLCD(m_camBienApSuat->getPressure()*10);
        if(running ==false)
        {
            m_bienTan->setStart(5);
            state = ST_IDLE;
        }

        if (_xValue.size() > 30){
            _xValue.pop_front();
            _pRefer.pop_front();
            _pCurrent.pop_front();
        }
        _pReferCurrent = updatePRefer(_pReferCurrent);
        _xValue.append(QDateTime::currentDateTime());
        _pRefer.append(_pReferCurrent);
        saveData.append(_pRefer);
        _pCurrent.append(m_camBienApSuat->getPressure());
        emit xValueChange();
    }

    // Cap nhat trang thai nut nhan

    if(m_relay->getStartLedState() ==true)
    {
        running = true;
    }
    else {
        running = false;
    }

    if(count_relay ==2)  // cap nhat cham hon 10 lan
    {
       count_relay =0;
        m_relay->readAllState();
    }

//    if(state == ST_IDLE)
//    {
//        m_bienTan->setStart(5);
//    }

//    if(current_start_state != last_start_state && current_start_state ==1){
//        last_start_state = current_start_state;
//        m_bienTan->setStart(1);
//    } else if(current_start_state != last_start_state && current_start_state ==0){
//        last_start_state = current_start_state;
//        m_bienTan->setStart(5);
//    }
}

void KiemDinhTuDong::checkState(){
    if (counter > 0){
        counter --;
    }
//    updateState();
    qDebug()<< "state = "<< state;
    qDebug()<< "counter" << counter;
    qDebug()<< "current Refer" << _pReferCurrent;
//    qDebug()<< "P Working" << _pWorking;
//    qDebug()<< "P Tried" << _pTried;
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
    m_camBienApSuat->sendRequest();
    switch (state) {
        case ST_IDLE:
            if (running) {
                m_bienTan->write_friquency(50*100);
                m_bienTan->setStart(1);  // bat bien tan
                state = ST_PREPARATION;
//                state = ST_START;
            }
            break;
        case ST_PREPARATION:
            if (m_camBienApSuat->getPressure() > 0.3) state = ST_START;
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
            if (counter == 0)
            {
                state = ST_PUMPDOWN;
            }
            break;
        case ST_PUMPDOWN:
            if (m_camBienApSuat->getPressure() < 0.3) state = ST_FINISH;
            break;
        case ST_FINISH:
//            state = ST_IDLE;
//            running = false;
            break;
    }

    switch (state) {
        case ST_IDLE:
            break;
        case ST_PREPARATION:
                m_bienTan->write_friquency(50*100);
            break;
        case ST_START:
            if(m_camBienApSuat->getPressure() < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_WORKING_P_TEST:
            if(m_camBienApSuat->getPressure() < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_PUMP_UP_TO_TEST:
            if(m_camBienApSuat->getPressure() < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_TEST_PRESSURE:
            if(m_camBienApSuat->getPressure() < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }

            break;
        case ST_PUMPDOWN:
            m_relay->writeOutputVavle(true);
            m_bienTan->setStart(5);
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
