#include "config.h"

#include <QString>


QString AppSetting::databasePath()
{
    this->beginGroup(baseGroup);
    QString path = this->value(database, "").toString();
    this->endGroup();
    return path;
}

QString AppSetting::userToken()
{
    this->beginGroup(authGroup);
    QString path = this->value(token, "").toString();
    this->endGroup();
    return path;
}
