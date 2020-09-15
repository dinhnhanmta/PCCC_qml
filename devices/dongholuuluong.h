#ifndef DONGHOLUULUONG_H
#define DONGHOLUULUONG_H

#include <QObject>
#include "modbus.hpp"

class DongHoLuuLuong : public QObject
{
    Q_OBJECT
public:
    explicit DongHoLuuLuong(QObject *parent = nullptr);
    DongHoLuuLuong(Modbus *modbus);

    float getLuuLuong();

    void buffertoFloat(int *buffer);
signals:

public slots:

private:
    Modbus *cbll_modbus;
    int cbll_ID;
    int cbll_address;
    int data_ll[2];
    float luu_luong;
};

#endif // DONGHOLUULUONG_H
