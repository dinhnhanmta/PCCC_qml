#include "thunghiembangtaycontroller.h"
#include <QDebug>

ThuNghiemBangTayController::ThuNghiemBangTayController(IcpThread *icpThread, ModbusThread *modbusThread)
{
    m_icpThread = icpThread;
    m_modbusThread = modbusThread;
}

void ThuNghiemBangTayController::startICP()
{
    m_icpThread->start();
}

void ThuNghiemBangTayController::startModbus()
{
    m_modbusThread ->start();
}
