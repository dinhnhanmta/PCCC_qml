#ifndef HIEUCHINHTHONGSO_HP
#define HIEUCHINHTHONGSO_HP
#include <QFile>
#include <QDebug>
#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include "localdatabase.h"
class HieuChinhThongSo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList q_parameterList READ getPara WRITE setPara NOTIFY paraChanged)
public:
    explicit HieuChinhThongSo(QObject *parent = nullptr);
    HieuChinhThongSo(LocalDatabase *db);
    void readJson(QString name);
    QStringList getPara(){return parameterList; }
    void setPara(QStringList list){parameterList  = list;}
signals:
    void paraChanged();
private:
    struct Lang{
        QString ma_tb = "";
        QString noi_sx = "";
        QString kichthuoc = "";
        QString p_lam_viec = "";
        QString khoi_luong = "";
        QString D1 = "";
        QString D2 = "";
        QString nam_sx = "";
        QString d = "";
        QString l = "";
        QString L = "";
        QString d1 = "";
        QString d2 = "";
        QString do_cung = "";
    } lang;

    QStringList parameterList ;
    LocalDatabase * database;

};

#endif // HIEUCHINHTHONGSO_HP
