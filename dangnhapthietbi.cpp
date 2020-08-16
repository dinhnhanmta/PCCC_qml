#include "dangnhapthietbi.hpp"

DangNhapThietBi::DangNhapThietBi()
{

}

DangNhapThietBi::DangNhapThietBi(login *log)
{
    m_login = log;
}

bool DangNhapThietBi::checkLogin(int maTB)
{
    bool success = false;
     m_login->mydb.setDatabaseName("/home/nhan/Documents/QT/project/PCCC_thong/pccc.db");

     if (m_login->mydb.open()){
         qDebug() << "Open successfully";
         QSqlQuery q;
         success = q.exec("SELECT * FROM thietbi;");
            if(!success)
            {
                qDebug() << "ERROR:"
                         << q.lastError();
            }

         while (q.next()){
             qDebug()<<"read value from database";
             if (q.value(0).toInt()==maTB )
             {
                 qDebug()<<"Login successfully";
                 m_login->mydb.close();
                 return true;
             }
         }
         qDebug() << "Login Failed";
         m_login->mydb.close();
         return false;
     }
     else
     {
         qDebug() << "Open failed";
         return false;
     }

}
