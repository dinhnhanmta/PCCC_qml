#include "thunghiembangtay.h"

ThuNghiemBangTay::ThuNghiemBangTay(QObject *parent) : QObject(parent)
{

}

ThuNghiemBangTay::ThuNghiemBangTay(IcpThread *icpThread, ModbusThread *modbusThread)
{
    m_icpThread = icpThread;
    m_modbusThread = modbusThread; m_modbusThread->exit();
}

void ThuNghiemBangTay::startICP()
{
     m_icpThread->start();
}


void ThuNghiemBangTay::startModbus()
{
    m_modbusThread ->start();
}

void ThuNghiemBangTay::stopICP()
{
    m_icpThread->terminate();
}

void ThuNghiemBangTay::stopModbus()
{
     m_modbusThread->terminate();
}
