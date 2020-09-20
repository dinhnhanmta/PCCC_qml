#include "kiemdinhtudong.hpp"

//void KiemDinhTuDong::setPWorking(QString value)
//{
//    _pWorking = value.toFloat();
//}

//void KiemDinhTuDong::setPTried(QString value)
//{
//    _pTried = value.toFloat();
//}

KiemDinhTuDong::KiemDinhTuDong(CamBienApSuat *cbap, Modbus *modbus, Relay *_relay, lcd *_lcd, Bientan *_bientan)
{
    _pReferCurrent = 0;
    m_camBienApSuat = cbap;
    m_modbus = modbus;
    m_relay = _relay;
    m_lcd = _lcd;

    localDatabase = new LocalDatabase();
}


void KiemDinhTuDong::updateLogic()
{
    static int count_writeFre = 0;
    static int count_relay = 0;
    count_writeFre ++;
    count_relay ++;
    if(count_writeFre ==5)  // cap nhat cham hon 10 lan
    {
        count_writeFre = 0;
        m_lcd->writePressureLCD(m_camBienApSuat->getPressure()*10);
//        if(!running)
//        {
//            state = ST_IDLE;
//        }
        emit varChanged();
    }

    // Cap nhat trang thai nut nhan
    m_relay->readAllState();

    bool current_start_state = m_relay->getStartLedState();
    if(current_start_state != last_start_state && current_start_state ==1)
    {
        last_start_state = current_start_state;
        running = current_start_state;
//        m_relay->pump(current_start_state);
    }
    else if(current_start_state != last_start_state && current_start_state ==0)
    {
        last_start_state = current_start_state;
        running = current_start_state;
        state = ST_IDLE;
        m_relay->pump(false);
        m_relay->writeInputVavle(false);
//        m_relay->pump(current_start_state)
    }
    emit stateChanged();

}

void KiemDinhTuDong::checkState(){
    if (counter > 0){
        counter --;
        emit varChanged();
    }

     _pReferCurrent = updatePRefer(_pReferCurrent);

    qDebug()<< "state = "<< state;
    qDebug()<< "counter" << counter;
    qDebug()<< "current Refer" << _pReferCurrent;
}

bool KiemDinhTuDong::isRunning()
{
    return running;
}

void KiemDinhTuDong::stop(){
    state = ST_IDLE;
    counter = 0;
    running = false;
}

void KiemDinhTuDong::updateState()
{
    m_camBienApSuat->sendRequest();
    float currentPressure = m_camBienApSuat->getPressure();

    switch (state) {
        case ST_IDLE:
            _pReferCurrent = 0;
            counter = 0;
            if (running) {
                if(mode_do_ben ==false){
                    state = ST_PREPARATION;
                    m_relay->pump(true);
                    m_relay->writeInputVavle(true); // bat van vao
                }
                else {
                    state = ST_PREPERATION_DB;
                    m_relay->pump(true);
                    m_relay->writeInputVavle(true); // bat van vao
                }
            }
            break;
        case ST_PREPARATION:
            if (currentPressure > 0.1) {
                state = ST_START;
//                startTime = QDateTime::currentDateTime();
//                saveData = QList<double>();
            }
            break;
        case ST_START:
            if (currentPressure >= p_at_first) {
                _pReferCurrent = p_at_first;
                state = ST_WORKING_P_TEST;
                m_relay->writeInputVavle(false);
                counter = 60*3;
            }
            break;
        case ST_WORKING_P_TEST:
            if (counter == 0)
            {
                state = ST_WAIT_TO_ZERO;
                m_relay->pump(false);  // tat bom
            }
            break;
        case ST_WAIT_TO_ZERO:
             _pReferCurrent = 0;
            if (currentPressure < 0.1) {
                state = ST_PUMP_UP_TO_05;
                m_relay->pump(true); // bat bom
            }
            break;
        case ST_PUMP_UP_TO_05:
            if (currentPressure >= p_at_second)
            {
                _pReferCurrent = p_at_second;
                state = ST_HOLD_05_15S;
                m_relay->writeInputVavle(false);
                 m_relay->pump(false);
                counter = 15;
            }
            break;
        case ST_HOLD_05_15S:
            if (counter == 0)
            {
                 m_relay->pump(true);  // bat bom
                state = ST_PUMP_UP_TO_10;
            }
            break;
        case ST_PUMP_UP_TO_10:
            if (currentPressure >= p_at_third)
            {
                m_relay->writeInputVavle(false);
                state = ST_HOLD_10_15;
                counter = 15;
            }
            break;
        case ST_HOLD_10_15:
            if (counter == 0)
            {
                _pReferCurrent = p_at_third;
                state = ST_PUMP_DOWN;
                m_relay->pump(false);
            }
            break;
        case ST_PUMP_DOWN:
            _pReferCurrent = 0;
            if (currentPressure <= 0.2) state = ST_FINISH;
            break;
        case ST_FINISH:
//            saveRecordData();
            if(running==false)
            {
                state = ST_IDLE;
            }

            break;         
        case ST_PREPERATION_DB:
            if (currentPressure >= 0.1)
            {
                state = ST_START_DB;
            }
            break;
        case ST_START_DB:
                if (currentPressure >= p_at_fourth)
                {
                    m_relay->writeInputVavle(false);
                    _pReferCurrent = p_at_fourth;
                    state = ST_HOLD_48_1P;
                    counter =60;
                }
            break;
        case ST_HOLD_48_1P:
            if (counter == 0)
            {
                state = ST_PUMP_DOWN_DB;
                m_relay->pump(false);
            }
            break;
        case ST_PUMP_DOWN_DB:
            _pReferCurrent = 0;
            if (currentPressure <= 0.2)
            {
                state = ST_FINISH;
            }
            break;
    }

 //=========================ACTION OF STATES=============
    switch (state) {
        case ST_START:
            if (currentPressure >= _pReferCurrent) {
                m_relay->writeInputVavle(false);
                m_relay->pump(false);
            }else {
                m_relay->writeInputVavle(true);
                m_relay->pump(true);
            }
            break;
        case ST_WORKING_P_TEST:
//            if (currentPressure >= _pReferCurrent) {
//                m_relay->pump(false);
//            }else {
//                m_relay->pump(true);
//            }
            break;
        case ST_PUMP_UP_TO_05:
            if (currentPressure >= _pReferCurrent) {
                m_relay->writeInputVavle(false);
                m_relay->pump(false);
            }else {
                m_relay->writeInputVavle(true);
                m_relay->pump(true);
            }
            break;
        case ST_HOLD_05_15S:
            break;
        case ST_PUMP_UP_TO_10:
            if (currentPressure >= _pReferCurrent) {
                m_relay->writeInputVavle(false);
                m_relay->pump(false);
                }else {
                    m_relay->writeInputVavle(true);
                    m_relay->pump(true);
                }
            break;
        case ST_HOLD_10_15:
            break;
        case ST_FINISH:
//            saveRecordData();
            state = ST_IDLE;
            break;
        case ST_START_DB:
            if (currentPressure >= _pReferCurrent) {
                m_relay->writeInputVavle(false);
                m_relay->pump(false);
                }else {
                    m_relay->writeInputVavle(true);
                    m_relay->pump(true);
                }
            break;
        case ST_HOLD_48_1P:
            if (counter == 0)
            {
                state = ST_PUMP_DOWN_DB;
            }
            break;
    }

    stateMachineChanged();
}

double KiemDinhTuDong::updatePRefer(double _currentPRefer){
    double tmp;
    switch (state) {
        case ST_START:
            tmp = _currentPRefer + coef_inc_first;
            return tmp < p_at_first ? tmp : p_at_first;
        case ST_PUMP_UP_TO_05:
            tmp = _currentPRefer + coef_inc_sencond;
            return tmp < p_at_second ? tmp : p_at_second;
        case ST_PUMP_UP_TO_10:
            tmp = _currentPRefer + coef_inc_sencond;
            return tmp < p_at_third ? tmp : p_at_third;
        case ST_START_DB:
            tmp = _currentPRefer + coef_inc_sencond;
            return tmp < p_at_fourth ? tmp : p_at_fourth;
    }
    return _currentPRefer;
}

void KiemDinhTuDong::saveRecordData(){
    QVariantMap mapRecord;
    mapRecord["deviceModelName"] = settings->defautConfig.getDeviceModelName();
    mapRecord["code"] = settings->defautConfig.getDeviceCode();
    QString savedDataString = "[";
    for(int i=0; i < saveData.size(); i++){
        savedDataString += QString::number(saveData[i]);
        if(i < saveData.size() - 1) savedDataString += ",";
    }
    savedDataString += "]";
    mapRecord["data"] = savedDataString;
    mapRecord["createdAt"] = startTime.toString();
    localDatabase->insertRecord("records",mapRecord);
}




bool KiemDinhTuDong::getLedStart()
{
    return m_relay->getStartLedState();
}

bool KiemDinhTuDong::getValveUp()
{
    return m_relay->getInputVavleState();
}

bool KiemDinhTuDong::setLedStart(bool val)
{
    m_relay->writeStartLed(val);
}

void KiemDinhTuDong::setLedValveUp(bool val)
{
    m_relay->writeInputVavle(val);
}

void KiemDinhTuDong::setLedValveDown(bool val)
{
    m_relay->writeOutputVavle(val);
}

void KiemDinhTuDong::setLcdID(int id)
{
    m_lcd->setId(id);
}

void KiemDinhTuDong::setBienTanID(int id)
{
//    m_bienTan->setID(id);
}


void KiemDinhTuDong::setRelayID(int id)
{
    m_relay->setID(id);
}

void KiemDinhTuDong::swapTuLuuLuong(bool value)
{
    is_test_luu_luong = value;
    if(is_test_luu_luong ==false){
        m_relay->setID(11);
        m_lcd->setId(10);
    }
    else {
        m_relay->setID(21);
        m_lcd->setId(20);
//        m_bienTan->setID(2);
    }

}

void KiemDinhTuDong::readRelayDone()
{
    emit stateChanged();
}

void KiemDinhTuDong::readButtonDone()
{
    emit stateChanged();
}

bool KiemDinhTuDong::getValveDown()
{
    return m_relay->getOuputVavleState();
}
