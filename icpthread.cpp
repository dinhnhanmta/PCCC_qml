#include "icpthread.h"
#include <QDebug>

IcpThread::IcpThread(CamBienApSuat *cbas)
{
    m_cbas = cbas;
}

void IcpThread::run()
{
    while(true)
    {
//        qDebug()<< "Update ICP";
        IcpUpdate();
        msleep(500);
    }
}

void IcpThread::IcpUpdate()
{
    m_cbas->sendRequest();
}
