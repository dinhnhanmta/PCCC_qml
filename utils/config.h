#ifndef CONFIG_H
#define CONFIG_H

#include <QSettings>
#include "constant.h"
#include <QString>

class SerialParameter: public QSettings {
public:
    SerialParameter(const QString savedPath, const QString group);

    QString getPortName();
    void setPortName(const QString &value);

    int getBaudrate();
    void setBaudrate(int value);

    QString getFlow();
    void setFlow(const QString &value);

    QString getParity();
    void setParity(const QString &value);

    int getStopBits();
    void setStopBits(int value);

    int getDataBits();
    void setDataBits(int value);

private:
    QString group;
};

class DefaultConfig: public QSettings {

public:
    DefaultConfig(const QString savedPath);

    QString getServerUrl();
    void setServerUrl(const QString &value);

    QString getUserName();
    void setUserName(const QString &value);

    QString getPassword();
    void setPassword(const QString &value);

    QString getToken();
    void setToken(const QString &value);

    Q_INVOKABLE QString getDeviceCode();
    void setDeviceCode(const QString &value);

    Q_INVOKABLE QString getDeviceModelName();
    void setDeviceModelName(const QString &value);
};

class CalibConfig: public QSettings {

public:
    CalibConfig(const QString savedPath, const QString group);

    float getMaxPressure();
    void setMaxPressure(float value);

    float getKP();
    void setKP(const float value);

    float getKD();
    void setKD(const float value);

    float getKI();
    void setKI(const float value);
private:
    QString group;
};

class AppSetting {
public:
    AppSetting(const QString savedPath);
    DefaultConfig defautConfig;
    SerialParameter modbusParam;
    SerialParameter cambienParam;
    CalibConfig calibParam;
};

#endif // CONFIG_H
