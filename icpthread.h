#ifndef ICPTHREAD_H
#define ICPTHREAD_H
#include <QMutex>
#include <QThread>
#include <QWaitCondition>
#include <cambienapsuat.hpp>

class IcpThread : public QThread
{
public:

    IcpThread(CamBienApSuat *cbap);

    void run();
    void IcpUpdate();

private:
    CamBienApSuat *m_cbas;
};

#endif // ICPTHREAD_H
