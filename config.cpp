#include "config.h"

#include <QString>

AppSetting::AppSetting(const QString savedPath): QSettings(savedPath, QSettings::Format::IniFormat, nullptr)
{
    this->beginGroup("default");
    this->serverUrl = this->value("serverUrl").toString();
    this->baudrate = this->value("baudrate").toInt();
    this->userName = this->value("userName").toString();
    this->password = this->value("password").toString();
    this->token = this->value("token").toString();
    this->endGroup();
}

QString AppSetting::getServerUrl() const
{
    return serverUrl != "" ? serverUrl : DEFAULT_SERVER_URL;
}

void AppSetting::setServerUrl(const QString &value)
{
    this->beginGroup("default");
    this->setValue("serverUrl", value);
    serverUrl = value;
    this->endGroup();
}

int AppSetting::getBaudrate() const
{
    return baudrate != 0 ? baudrate : DEFAULT_BAUDRATE;
}

void AppSetting::setBaudrate(int value)
{
    this->beginGroup("default");
    this->setValue("baudrate", value);
    baudrate = value;
    this->endGroup();
}

QString AppSetting::getUserName() const
{
    return userName;
}

void AppSetting::setUserName(const QString &value)
{
    this->beginGroup("default");
    this->setValue("userName", value);
    userName = value;
    this->endGroup();
}

QString AppSetting::getPassword() const
{
    return password;
}

void AppSetting::setPassword(const QString &value)
{
    this->beginGroup("default");
    this->setValue("password", value);
    password = value;
    this->endGroup();
}

QString AppSetting::getToken() const
{
    return token;
}

void AppSetting::setToken(const QString &value)
{
    this->beginGroup("default");
    this->setValue("token", value);
    token = value;
    this->endGroup();
}
