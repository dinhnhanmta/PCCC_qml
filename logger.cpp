#include "logger.h"

Logger::Logger(LoggerLevel level)
{
    this->level = level;
}

void Logger::printLog(LoggerLevel level, QString log)
{
       QString dt = QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
       QString txt = QString("[%1] ").arg(dt);

       switch (level)
       {
          case LoggerLevel::DEBUG:
           if (level > LoggerLevel::DEBUG){
               return;
           }
             txt += QString("{Debug} \t\t %1").arg(log);
             qDebug() << txt;
             break;
          case LoggerLevel::WARNING:
           if (level > LoggerLevel::WARNING){
               return;
           }
             txt += QString("{Warning} \t %1").arg(log);
             qWarning() << txt;
             break;
          case LoggerLevel::CRITICAL:
           if (level > LoggerLevel::CRITICAL){
               return;
           }
             txt += QString("{Critical} \t %1").arg(log);
             qCritical() << txt;
             break;
          case LoggerLevel::FATAL:
           if (level > LoggerLevel::FATAL){
               return;
           }
             txt += QString("{Fatal} \t\t %1").arg(log);
       }

       QFile outFile(LOG_PATH);
       outFile.open(QIODevice::WriteOnly | QIODevice::Append);

       QTextStream textStream(&outFile);
       textStream << txt << endl;
}
