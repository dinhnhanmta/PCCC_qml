#ifndef CALIB_PARAM_H
#define CALIB_PARAM_H

#include "baseobject.h"
#include "network.h"
#include <QJsonDocument>
#include <QString>
#include <QObject>
#include <QJsonObject>
class CalibParam: public QObject, BaseObject {
    Q_OBJECT
public:
    CalibParam();
    Q_INVOKABLE void save(QString maxPressure , QString kd, QString kp,QString ki);
    Q_INVOKABLE QString getMaxPressure();
    Q_INVOKABLE QString getKD();
    Q_INVOKABLE QString getKI();
    Q_INVOKABLE QString getKP();

signals:
    void saveSuccess();
};

#endif // CALIB_PARAM_H
