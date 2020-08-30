#include "hieuchinhthongso.hpp"

HieuChinhThongSo::HieuChinhThongSo(QObject *parent) : QObject(parent)
{
    readJson("thietbi.json");

}

void HieuChinhThongSo::readJson(QString name)
{
    database = new LocalDatabase();
    QStringList fields;
    //fields.append("id");
    fields.append("iParameter");
    fields.append("oParameter");
    QVariantMap conditions;
    QVariantMap result = database->queryRecord("vehicles", fields, conditions);

    QString a = result["iParameter"].toString();
    qDebug()<<"thong so:    "<<a.split(QLatin1Char(','), Qt::SkipEmptyParts)[0];
    QString val;
    QFile file;
    file.setFileName(name);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();
    QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject sett2 = d.object();
    QJsonValue value = sett2.value(QString("iParameter"));

    for (int i=0;i<value.toArray().size();i++)
    {
         qDebug() << value[i].toString();
         parameterList.append(value[i].toString());
    }
    emit paraChanged();

}
