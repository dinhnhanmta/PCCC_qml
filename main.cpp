#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "dialitem.h"
#include "Modbus.hpp"
#include "bientan.hpp"
#include "master.h"
int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    Modbus * m_modbus = new Modbus;
    //m_modbus->startConnection();
    master * m_master = new master(m_modbus);
    bientan *m_bientan = new bientan(m_modbus);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
     qmlRegisterType<DialItem>("IVIControls", 1, 0, "DialItem");
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("Master", m_master);
    context->setContextProperty("Modbus", m_modbus);
    context->setContextProperty("Bientan", m_bientan);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
