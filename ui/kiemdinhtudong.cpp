#include "kiemdinhtudong.hpp"

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
    m_camBienApSuat = cbap;
    m_bienTan = bientan;
    m_modbus = modbus;
    m_relay = relay;
    m_lcd = new lcd(modbus);
    last_start_state = m_relay->getStartLedState();
    localDatabase = new LocalDatabase();
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
        m_bienTan->readRealFrequency();
        m_lcd->writePressureLCD(m_camBienApSuat->getPressure()*10);
        if(!running)
        {
            m_bienTan->setStart(5);
            state = ST_IDLE;
        }
        _pReferCurrent = updatePRefer(_pReferCurrent);
    }

    // Cap nhat trang thai nut nhan
    running = m_relay->getStartLedState();

    if(count_relay ==2)  // cap nhat cham hon 10 lan
    {
       count_relay =0;
        m_relay->readAllState();
    }

}

void KiemDinhTuDong::checkState(){
    if (counter > 0){
        counter --;
    }
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
            if (running) {
                m_bienTan->write_friquency(50*100);
                m_bienTan->setStart(1);  // bat bien tan
                state = ST_PREPARATION;
            }
            break;
        case ST_PREPARATION:
            if (currentPressure > 0.3) {
                state = ST_START;
                startTime = QDateTime::currentDateTime();
                saveData = QList<double>();
            }
            break;
        case ST_START:
            if (currentPressure >= _pWorking) {
                state = ST_WORKING_P_TEST;
                counter = 60*3;
            }
            saveData.append(currentPressure);
            break;
        case ST_WORKING_P_TEST:
            if (counter == 0) state = ST_PUMP_UP_TO_TEST;
            saveData.append(currentPressure);
            break;
        case ST_PUMP_UP_TO_TEST:
            if (currentPressure > _pTried) {
                state = ST_TEST_PRESSURE;
                counter = 60*2;
            }
            saveData.append(currentPressure);
            break;
        case ST_TEST_PRESSURE:
            if (counter == 0)
            {
                state = ST_PUMPDOWN;
            }
            saveData.append(currentPressure);
            break;
        case ST_PUMPDOWN:
            if (currentPressure < 0.3) state = ST_FINISH;
            saveData.append(currentPressure);
            break;
        case ST_FINISH:
            saveRecordData();
            break;
    }

    switch (state) {
        case ST_IDLE:
            break;
        case ST_PREPARATION:
            m_bienTan->write_friquency(50*100);
            break;
        case ST_START:
            if(currentPressure < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_WORKING_P_TEST:
            if(currentPressure < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_PUMP_UP_TO_TEST:
            if(currentPressure < _pReferCurrent)
            {
               m_bienTan->write_friquency(50*100);
            }
            else {
                m_bienTan->write_friquency(0);
            }
            break;
        case ST_TEST_PRESSURE:
            if(currentPressure < _pReferCurrent)
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
