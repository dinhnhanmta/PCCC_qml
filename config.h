#ifndef CONFIG_H
#define CONFIG_H

#include <QSettings>
#include <constant.h>

class AppSetting: public QSettings {
    Q_OBJECT
public:
    AppSetting(const QString savedPath);
    QString getServerUrl() const;
    void setServerUrl(const QString &value);

    int getBaudrate() const;
    void setBaudrate(int value);

    QString getUserName() const;
    void setUserName(const QString &value);

    QString getPassword() const;
    void setPassword(const QString &value);

    QString getToken() const;
    void setToken(const QString &value);

private:
    QString serverUrl;
    int baudrate;
    QString userName;
    QString password;
    QString token;
};

#endif // CONFIG_H
