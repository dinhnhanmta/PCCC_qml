#include "lcd.h"

lcd::lcd(QObject *parent) : QObject(parent)
{

}

lcd::lcd(Modbus *modbus)
{
    lcd_modbus = modbus;
    LCD_ID = 10;
    LCD_address  = 0;
}

void lcd::writePressureLCD(int16_t pressure)
{
    lcd_modbus->writeSingleHoldingRegister(LCD_address, pressure, LCD_ID);
}
