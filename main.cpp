#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <calib_param.h>
#include "dialitem.h"
#include "modbus.hpp"
#include "devices/bientan.hpp"
#include "devices/vavle.hpp"
#include "cambienapsuat.hpp"
#include "master.h"
#include "login.hpp"
#include "dangnhapthietbi.hpp"
#include "devices/relay.hpp"
#include "thunghiembangtay.h"
#include "dothi.hpp"
#include "kiemdinhtudong.hpp"
#include "dataobject.h"
#include "hieuchinhthongso.hpp"
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
    CalibParam *m_CalibParam = new CalibParam();
    DangNhapThietBi *m_DangNhapThietBi = new DangNhapThietBi();
    ThuNghiemBangTay *m_thuNghiemBangTay = new ThuNghiemBangTay(m_cambien, m_bientan, m_modbus, m_relay);
    KiemDinhTuDong *m_kiemDinhTuDong = new KiemDinhTuDong();
    HieuChinhThongSo *m_hieuChinhThongSo = new HieuChinhThongSo();
    qmlRegisterType<DialItem>("IVIControls", 1, 0, "DialItem");
    qmlRegisterType<CamBienApSuat>("camBienApSuat", 1, 0, "CamBienApSuat");
    //qmlRegisterType<HieuChinhThongSo>("HieuChinhThongSo", 1, 0, "HieuChinhThongSo");

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
    context->setContextProperty("CParam", m_CalibParam);
    context->setContextProperty("Relay", m_relay);
    context->setContextProperty("TnBangTay", m_thuNghiemBangTay);
    context->setContextProperty("KiemDinhTD", m_kiemDinhTuDong);
    context->setContextProperty("listLoaiVoi", QVariant::fromValue(m_kiemDinhTuDong->listLoaiVoi));
    context->setContextProperty("listApSuatThu", QVariant::fromValue(m_kiemDinhTuDong->listApSuatThu));
    context->setContextProperty("listApSuatLamViec", QVariant::fromValue(m_kiemDinhTuDong->listApSuatLamViec));
    context->setContextProperty("HieuChinh", m_hieuChinhThongSo);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
