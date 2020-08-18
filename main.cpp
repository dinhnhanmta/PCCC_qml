#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "dialitem.h"
#include "Modbus.hpp"
#include "bientan.hpp"
#include "vavle.hpp"
#include "cambienapsuat.hpp"
#include "master.h"
#include "login.hpp"
#include "dangnhapthietbi.hpp"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    Modbus * m_modbus = new Modbus;
    master * m_master = new master(m_modbus);
    bientan *m_bientan = new bientan(m_modbus);
    Vavle *m_vavle = new Vavle (m_modbus);
    camBienApSuat *m_cambien = new camBienApSuat();
    login *m_login = new login();
    DangNhapThietBi *m_DangNhapThietBi = new DangNhapThietBi(m_login);
    qmlRegisterType<DialItem>("IVIControls", 1, 0, "DialItem");

    qmlRegisterType<camBienApSuat>("camBienApSuat", 1, 0, "CamBienApSuat");

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

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
