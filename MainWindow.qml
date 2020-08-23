import QtQuick 2.0
import QtCharts 2.3
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
Item {
    id: window
    width: 1024
    height: 600
    visible: true

    Component.onCompleted: {
        Modbus.startConnection();
        Cambien.openSerialPort();
    }

    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        Text {
            y: 34
            width: 448
            height: 39
            text: qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
            font.bold: true
            anchors.horizontalCenterOffset: -39
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 27
        }

        PrimaryButton{
            id: thuNghiem
            x: 137
            y: 130
            width: 350
            height: 100
            radius: 1
            z: 1
            text: "TIẾN HÀNH THỬ NGHIỆM"
            anchors.horizontalCenterOffset: -221
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                width: 100
                height: 100
                source: "qrc:/Icon/play2.png"
                anchors.left:  parent.left
                scale: 0.7
            }
            MouseArea {
                anchors.fill: parent
                onClicked: stack.push("DangNhapTB.qml")
            }
        }

        PrimaryButton {
            id: thuNghiemBangTay
            x: 127
            y: 130
            width: 350
            height: 101
            text: "THỬ NGHIỆM BẰNG TAY"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247
            Image {
                y: 1
                width: 100
                height: 100
                anchors.leftMargin: -7
                source: "qrc:/Icon/hand2.png"
                anchors.left: parent.left
                 scale: 0.7
            }
            MouseArea {
                height: 100
                anchors.rightMargin: 0
                anchors.bottomMargin: 2
                anchors.leftMargin: 0
                anchors.topMargin: -2
                anchors.fill: parent
                onClicked: stack.push("ThuNghiemBangTay.qml")
            }
        }

        PrimaryButton {
            id: thuNghiem2
            x: 139
            y: 279
            width: 350
            height: 100
            radius: 1
            text: "LỊCH SỬ KIỂM ĐỊNH"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247

            Image {
                y: 6
                width: 100
                height: 100
                anchors.leftMargin: -2
                source: "qrc:/Icon/history2.png"
                anchors.left: parent.left
                 scale: 0.7
            }
            MouseArea {
                anchors.fill: parent
                onClicked: stack.push("LichSuKiemDinh.qml")
            }
        }

        PrimaryButton {
            id: capNhat
            x: 146
            y: 279
            height: 100
            radius: 1
            text: "CẬP NHẬT THÔNG SỐ\n         KIỂM ĐỊNH"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: -221
            Image {
                y: 0
                width: 100
                height: 100
                anchors.leftMargin: -6
                source: "qrc:/Icon/update2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }
        }

        PrimaryButton {
            id: thuNghiem4
            x: 137
            y: 420
            height: 100
            radius: 1
            text: "HIỆU CHỈNH THÔNG SỐ"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247

            Image {
                width: 100
                height: 100
                source: "qrc:/Icon/adjust2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }
            MouseArea {
                anchors.fill: parent
                onClicked: stack.push("HieuChinhThamSo.qml")
            }
        }

        PrimaryButton {
            id: thuNghiem5
            x: 132
            y: 420
            height: 100
            radius: 1
            text: "CÀI ĐẶT HỆ THỐNG"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: -221

            Image {
                y: 6
                width: 100
                height: 100
                anchors.leftMargin: 1
                source: "qrc:/Icon/setting2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }
            MouseArea {
            anchors.fill: parent
            onClicked: stack.push("CaiDatThongSo.qml")
            }
        }

        Image {
            source: "qrc:/Icon/account.png"
            scale: 0.8
            anchors.right: parent.right
            anchors.top: parent.top
        }

        DangerButton {
            x: 867
            y: 547
            text: "Modbus"
            anchors.rightMargin: 6
            color: "palegoldenrod"
            width: 151
            height: 53
            anchors.right: parent.right
            anchors.bottom:  parent.bottom
            Image {
                id: state_icon
                 source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                 anchors.right: parent.right
                 scale: 0.7
            }
        }
        DangerButton {
            text: "HOME"
            color: "palegoldenrod"
            width: 200
            anchors.left: parent.left
            anchors.bottom:  parent.bottom
            Image {
                 source: "qrc:/Icon/home2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }
        }
    }
}
