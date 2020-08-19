#ifndef LOGGER_H
#define LOGGER_H

#include <QString>
#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QTime>
#include <QDebug>

enum class LoggerLevel
{
    DEBUG = 1,
    WARNING = 2,
    CRITICAL = 3,
    FATAL = 4
};

class Logger: public QObject {
  Q_OBJECT
public:
    Logger(LoggerLevel level);
    void printLog(LoggerLevel level, QString log);
private:
    LoggerLevel level;

};

#endif // LOGGER_H
