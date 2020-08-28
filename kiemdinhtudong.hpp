#ifndef KIEMDINHTUDONG_HPP
#define KIEMDINHTUDONG_HPP

#include <QObject>
#include "constant.h"
#include <QtSql>
#include "dataobject.h"
class KiemDinhTuDong : public QObject
{
    Q_OBJECT
public:
    //explicit KiemDinhTuDong(QObject *parent = nullptr);
    KiemDinhTuDong ();
    QList<QObject*> listLoaiVoi;
    QList<QObject*> listApSuatThu;
    QList<QObject*> listApSuatLamViec;
signals:

private:
    QSqlDatabase db;
    QSqlQuery *query;

};

#endif // KIEMDINHTUDONG_HPP
