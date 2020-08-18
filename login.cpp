#include "login.hpp"

login::login()
{

}

bool login::checkLogin(QString user,QString pass)
{
    bool success = false;
    mydb.setDatabaseName("/home/nhan/Downloads/PCCC_qml/pccc.db");

    if (mydb.open()){
        qDebug() << "Open successfully";
        QSqlQuery q;
        success = q.exec("SELECT * FROM user;");
           if(!success)
           {
               qDebug() << "ERROR:"
                        << q.lastError();
           }

        while (q.next()){
            qDebug()<<"read value from database";
            if (q.value(0)==user && q.value(1)==pass)
            {
                qDebug()<<"Login successfully";
                mydb.close();
                return true;
            }
        }
        qDebug() << "Login Failed";
        mydb.close();
        return false;
    }
    else
    {
        qDebug() << "Open failed";
        return false;
    }

}
