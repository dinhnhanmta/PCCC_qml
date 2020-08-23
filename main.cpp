#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "dialitem.h"
#include "modbus.hpp"
#include "bientan.hpp"
#include "vavle.hpp"
#include "cambienapsuat.hpp"
#include "master.h"
#include "login.hpp"
#include "dangnhapthietbi.hpp"
#include "relay.hpp"
#include "thunghiembangtaycontroller.h"
#include "icpthread.h"
#include "modbusthread.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    Modbus * m_modbus = new Modbus;
    Master * m_master = new Master(m_modbus);
    Bientan *m_bientan = new Bientan(m_modbus);
    Vavle *m_vavle = new Vavle (m_modbus);
    Relay *m_relay = new Relay(m_modbus);
    CamBienApSuat *m_cambien = new CamBienApSuat();
    Login *m_login = new Login();
    DangNhapThietBi *m_DangNhapThietBi = new DangNhapThietBi();
    IcpThread *m_icpThread = new IcpThread(m_cambien);
    ModbusThread *m_modbusThread = new ModbusThread(m_bientan, m_modbus, m_relay);

    ThuNghiemBangTayController *m_thuNghiemBangTay = new ThuNghiemBangTayController(m_icpThread, m_modbusThread);

    qmlRegisterType<DialItem>("IVIControls", 1, 0, "DialItem");
    qmlRegisterType<CamBienApSuat>("camBienApSuat", 1, 0, "CamBienApSuat");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    context->setContextProperty("Master", m_master);
    context->setContextProperty("Modbus", m_modbus);
    context->setContextProperty("Bientan", m_bientan);
    context->setContextProperty("Vavle", m_vavle);
    context->setContextProperty("Cambien", m_cambien);
    context->setContextProperty("QLogin", m_login);
    context->setContextProperty("LoginTB", m_DangNhapThietBi);
    context->setContextProperty("Relay", m_relay);

    m_thuNghiemBangTay->startModbus();
    m_thuNghiemBangTay->startICP();

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
