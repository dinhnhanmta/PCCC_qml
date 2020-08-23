#ifndef THUNGHIEMBANGTAYCONTROLLER_H
#define THUNGHIEMBANGTAYCONTROLLER_H

#include <icpthread.h>
#include <modbusthread.h>

class ThuNghiemBangTayController
{
public:
    ThuNghiemBangTayController(IcpThread *icpThread, ModbusThread *modbusThread);

    void startICP();
    void startModbus();

private:
    IcpThread * m_icpThread;
    ModbusThread *m_modbusThread;
};

#endif // THUNGHIEMBANGTAYCONTROLLER_H
