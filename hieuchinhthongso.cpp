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
