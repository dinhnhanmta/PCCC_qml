#ifndef BASEOBJECT_H
#define BASEOBJECT_H

#include "config.h"
#include "logger.h"
#include "constant.h"
class BaseObject
{
public:
    BaseObject();
protected:
    AppSetting *settings;
    Logger *logger;
};

#endif // BASEOBJECT_H
