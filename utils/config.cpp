#include "config.h"

AppSetting::AppSetting(const QString savedPath):
    defautConfig(savedPath),
    modbusParam(savedPath, "Modbus"),
    cambienParam(savedPath, "Cambien"),
    calibParam(savedPath, "CalibParam")
{}

SerialParameter::SerialParameter(const QString savedPath, const QString group)
    : QSettings(savedPath, QSettings::Format::IniFormat, nullptr), group(group)
{}

QString SerialParameter::getPortName()
{
    this->beginGroup(group);
    QString value = this->value("portname").toString();
    this->endGroup();
    return value != "" ? value : "ttyUSB0";
}

void SerialParameter::setPortName(const QString &value)
{
    this->beginGroup(group);
    this->setValue("portname", value);
    this->endGroup();
}

int SerialParameter::getBaudrate()
{
    this->beginGroup(group);
    int value = this->value("baudrate").toInt();
    this->endGroup();
    return value != 0 ? value : 19200;
}

void SerialParameter::setBaudrate(int value)
{
    this->beginGroup(group);
    this->setValue("baudrate", value);
    this->endGroup();
}

QString SerialParameter::getFlow()
{
    this->beginGroup(group);
    QString value = this->value("flow").toString();
    this->endGroup();
    return value;
}

void SerialParameter::setFlow(const QString &value)
{
    this->beginGroup(group);
    this->setValue("flow", value);
    this->endGroup();
}

QString SerialParameter::getParity()
{
    this->beginGroup(group);
    QString value = this->value("parity").toString();
    this->endGroup();
    return value != "" ? value : "None";
}

void SerialParameter::setParity(const QString &value)
{
    this->beginGroup(group);
    this->setValue("parity", value);
    this->endGroup();
}

int SerialParameter::getStopBits()
{
    this->beginGroup(group);
    int value = this->value("stopbits").toInt();
    this->endGroup();
    return value != 0 ? value : 1;
}

void SerialParameter::setStopBits(int value)
{
    this->beginGroup(group);
    this->setValue("stopbits", value);
    this->endGroup();
}

int SerialParameter::getDataBits()
{
    this->beginGroup(group);
    int value = this->value("databits").toInt();
    this->endGroup();
    return value != 0 ? value : 8;
}

void SerialParameter::setDataBits(int value)
{
    this->beginGroup(group);
    this->setValue("databits", value);
    this->endGroup();
}

DefaultConfig::DefaultConfig(const QString savedPath)
    : QSettings(savedPath, QSettings::Format::IniFormat, nullptr)
{}

QString DefaultConfig::getServerUrl()
{
    this->beginGroup("default");
    QString value = this->value("serverUrl").toString();
    this->endGroup();
    return value != "" ? value: DEFAULT_SERVER_URL;
}

void DefaultConfig::setServerUrl(const QString &value)
{
    this->beginGroup("default");
    this->setValue("serverUrl", value);
    this->endGroup();
}

QString DefaultConfig::getUserName()
{
    this->beginGroup("default");
    QString value = this->value("userName").toString();
    this->endGroup();
    return value;
}

void DefaultConfig::setUserName(const QString &value)
{
    this->beginGroup("default");
    this->setValue("userName", value);
    this->endGroup();
}

QString DefaultConfig::getPassword()
{
    this->beginGroup("default");
    QString value = this->value("password").toString();
    this->endGroup();
    return value;
}

void DefaultConfig::setPassword(const QString &value)
{
    this->beginGroup("default");
    this->setValue("password", value);
    this->endGroup();
}

QString DefaultConfig::getToken()
{
    this->beginGroup("default");
    QString value = this->value("token").toString();
    this->endGroup();
    return value;
}

void DefaultConfig::setToken(const QString &value)
{
    this->beginGroup("default");
    this->setValue("token", value);
    this->endGroup();
}

QString DefaultConfig::getDeviceCode()
{
    this->beginGroup("default");
    QString value = this->value("deviceCode").toString();
    this->endGroup();
    return value;
}

void DefaultConfig::setDeviceCode(const QString &value)
{
    this->beginGroup("default");
    this->setValue("deviceCode", value);
    this->endGroup();
}

QString DefaultConfig::getDeviceModelName()
{
    this->beginGroup("default");
    QString value = this->value("deviceModelName").toString();
    this->endGroup();
    return value;
}

void DefaultConfig::setDeviceModelName(const QString &value)
{
    this->beginGroup("default");
    this->setValue("deviceModelName", value);
    this->endGroup();
}

CalibConfig::CalibConfig(const QString savedPath, const QString group)
    : QSettings(savedPath, QSettings::Format::IniFormat, nullptr), group(group)
{}

float CalibConfig::getMaxPressure()
{
    this->beginGroup(group);
    float value = this->value("maxPressure").toFloat();
    this->endGroup();
    return value;
}

void CalibConfig::setMaxPressure(float value)
{
    this->beginGroup(group);
    this->setValue("maxPressure", value);
    this->endGroup();
}

float CalibConfig::getKP()
{
    this->beginGroup(group);
    float value = this->value("KP").toFloat();
    this->endGroup();
    return value;
}

void CalibConfig::setKP(const float value)
{
    this->beginGroup(group);
    this->setValue("KP", value);
    this->endGroup();
}


float CalibConfig::getKI()
{
    this->beginGroup(group);
    float value = this->value("KI").toFloat();
    this->endGroup();
    return value;
}

void CalibConfig::setKI(const float value)
{
    this->beginGroup(group);
    this->setValue("KI", value);
    this->endGroup();
}



float CalibConfig::getKD()
{
    this->beginGroup(group);
    float value = this->value("KD").toFloat();
    this->endGroup();
    return value;
}

void CalibConfig::setKD(const float value)
{
    this->beginGroup(group);
    this->setValue("KD", value);
    this->endGroup();
}

