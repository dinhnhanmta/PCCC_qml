#ifndef HIEUCHINHTHONGSO_HP
#define HIEUCHINHTHONGSO_HP
#include "baseobject.h"
#include "localdatabase.h"
#include "network.h"

#include <QFile>
#include <QDebug>
#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

class HieuChinhThongSo : public QObject, BaseObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList q_parameterList READ getPara WRITE setPara NOTIFY paraChanged)
public:
    HieuChinhThongSo();
    void readJson(QString name);

    QStringList getPara(){return parameterList; }
    void setPara(QStringList list){parameterList  = list;}

    Q_INVOKABLE void submitData();
signals:
    void paraChanged();
    void submitSuccess();
    void submitFailed();
    void unauthorized();
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

    Network *network;
    LocalDatabase *localDatabase;

    bool saveInspectData(QByteArray jsonData, bool sync);
};

#endif // HIEUCHINHTHONGSO_HP
