#include "calib_param.h"


CalibParam::CalibParam()
{

}

void CalibParam::save(QString maxPressure, QString kd, QString kp, QString ki)
{
    qDebug() << maxPressure.toFloat();
    settings->calibParam.setMaxPressure(maxPressure.toFloat());
    settings->calibParam.setKD(kd.toFloat());
    settings->calibParam.setKP(kp.toFloat());
    settings->calibParam.setKI(ki.toFloat());
}

QString CalibParam::getMaxPressure()
{
    return QString::number(settings->calibParam.getMaxPressure());
}

QString CalibParam::getKD()
{
    return QString::number(settings->calibParam.getKD());
}

QString CalibParam::getKI()
{
    return QString::number(settings->calibParam.getKI());
}

QString CalibParam::getKP()
{
    return QString::number(settings->calibParam.getKP());
}
