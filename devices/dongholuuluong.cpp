#include "dongholuuluong.h"
#include <QThread>

DongHoLuuLuong::DongHoLuuLuong(QObject *parent) : QObject(parent)
{

}

DongHoLuuLuong::DongHoLuuLuong(Modbus *modbus)
{
      cbll_modbus = modbus;
      cbll_ID = 5;
      cbll_address = 4112;
}

float DongHoLuuLuong::getLuuLuong()
{
    //    qDebug()<<"Doc toc do thuc";
//    readMultiDiscrete(int server,int start_add, int number_coils, bool *data)
        cbll_modbus->readDiscreteRegister(cbll_ID, 4112, 2, data_ll);
        luu_luong = data_ll[0];
        int32_t s = data_ll[0] >>15 & 0x0001;
//        int32_t ex = data_ll[0] & 0x7F80
        return luu_luong;
}

void DongHoLuuLuong::buffertoFloat(int *buffer)
{

}

void DongHoLuuLuong::process()
{
    while (true) {
            getLuuLuong();
            qDebug()<<" process do luu luong";
            QThread::msleep(300);
    }

}


//    var s  = (buffer[0] >>> 15) & 0x0001;
//    var ex = (buffer[0] & 0x7F80) >>> 7;
//    var f  = buffer[1] & 0xFFFF;
//    f |= (buffer[0] & 0x007F) << 16;
//    var dec = 0;
//    for (var i = 0; i < 23; i++){
//        if ((f >>> i) & 0x0001 === 1){
//            dec += Math.pow(0.5,23-i);
//        }
//    }
//    return Math.pow(-1,s)*(1+dec)*Math.pow(2,ex - 127);
//}
