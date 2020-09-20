#ifndef LCD_H
#define LCD_H

#include <QObject>
#include "modbus.hpp"

class lcd : public QObject
{
    Q_OBJECT
public:
    explicit lcd(QObject *parent = nullptr);
    lcd(Modbus *modbus);
    void writePressureLCD(int16_t pressure);

signals:

public slots:


private:
    Modbus *lcd_modbus;
    int LCD_ID;
    int LCD_address;
    int16_t pressure_lcd;
};

#endif // LCD_H
