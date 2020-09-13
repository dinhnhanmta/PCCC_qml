#include "baseobject.h"

BaseObject::BaseObject()
{
    this->settings = new AppSetting(CONFIG_PATH);
    this->logger = new Logger(LoggerLevel::DEBUG);
}
