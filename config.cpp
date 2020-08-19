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
}

QString AppSetting::getServerUrl() const
{
    return serverUrl != "" ? serverUrl : DEFAULT_SERVER_URL;
}

void AppSetting::setServerUrl(const QString &value)
{
    this->setValue("serverUrl", serverUrl);
    serverUrl = value;
}

int AppSetting::getBaudrate() const
{
    return baudrate != 0 ? baudrate : DEFAULT_BAUDRATE;
}

void AppSetting::setBaudrate(int value)
{
    this->setValue("baudrate", baudrate);
    baudrate = value;
}

QString AppSetting::getUserName() const
{
    return userName;
}

void AppSetting::setUserName(const QString &value)
{
    this->setValue("userName", userName);
    userName = value;
}

QString AppSetting::getPassword() const
{
    return password;
}

void AppSetting::setPassword(const QString &value)
{
    this->setValue("password", password);
    password = value;
}

QString AppSetting::getToken() const
{
    return token;
}

void AppSetting::setToken(const QString &value)
{
    this->setValue("token", token);
    token = value;
}
