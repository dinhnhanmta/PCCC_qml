#include "hieuchinhthongso.hpp"

HieuChinhThongSo::HieuChinhThongSo(QObject *parent) : QObject(parent)
{
    readJson("thietbi.json");
}
void HieuChinhThongSo::readJson(QString name)
{
    QString val;
    QFile file;
    file.setFileName(name);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();
//    qDebug() << val;
    QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject sett2 = d.object();
    qDebug() << sett2;
    QJsonValue value = sett2.value(QString("iParameter"));


    for (int i=0;i<value.toArray().size();i++)
    {
         qDebug() << value[i].toString();
         parameterList.append(value[i].toString());
    }
    emit paraChanged();
    //QJsonObject item = value.to();
    //qDebug() << tr("QJsonObject of description: ") << item;

//    /* in case of string value get value and convert into string*/
//    qDebug() << tr("QJsonObject[appName] of description: ") << item["description"];
//    QJsonValue subobj = item["description"];
//    qDebug() << subobj.toString();

//    /* in case of array get array and convert into string*/
//    qDebug() << tr("QJsonObject[appName] of value: ") << item["imp"];
//    QJsonArray test = item["imp"].toArray();
//    qDebug() << test[1].toString();

}
