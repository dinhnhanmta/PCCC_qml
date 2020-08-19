#ifndef CONFIG_H
#define CONFIG_H

#include <QSettings>
#include <constant.h>

class AppSetting: public QSettings {
    Q_OBJECT
public:
    AppSetting(QString savedPath = CONFIG_PATH);
    QString databasePath();
    QString userToken();

private:
    QString savedPath;

protected:
    const QString baseGroup = "Base";
    const QString database = "database";

    const QString valveGroup = "Valve";
    const QString baudrate = "baudrate";

    const QString authGroup = "Auth";
    const QString userName = "userName";
    const QString password = "password";
    const QString token = "token";
};

#endif // CONFIG_H
