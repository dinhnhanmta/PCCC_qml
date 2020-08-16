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

    Rectangle{
        anchors.fill: parent
        color: "lightblue"


    Text {
        y: 33

        text: qsTr("THIET BI KIEM DINH VOI CHUA CHAY")
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 26
    }






        PrimaryButton{
        id: thuNghiem
        x: 137
        y: 159
        width: 250
        height: 64
        z: 1
        text: "               TIẾN HÀNH THỬ NGHIỆM"
        anchors.horizontalCenterOffset: -221

        anchors.horizontalCenter: parent.horizontalCenter

        Image {
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
            y: 159
            width: 250
            height: 64
            text: "              THỬ NGHIỆM BẰNG TAY"


            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247

            Image {
                 source: "qrc:/Icon/hand2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }
            MouseArea {
            anchors.fill: parent
            onClicked: stack.push("ThuNghiemBangTay.qml")
            }
        }

        PrimaryButton {
            id: thuNghiem2
            x: 139
            y: 289
            width: 250
            height: 64
            text: "             LỊCH SỬ KIỂM ĐỊNH"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247

            Image {
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
            y: 289
            width: 250
            height: 64
            text: "             CẬP NHẬT THÔNG SỐ\n                     KIỂM ĐỊNH"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: -221
            Image {
                 source: "qrc:/Icon/update2.png"
                 anchors.left: parent.left
                 scale: 0.7
            }


        }

        PrimaryButton {
            id: thuNghiem4
            x: 137
            y: 420
            width: 250
            height: 64
            text: "              HIỆU CHỈNH THÔNG SỐ"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: 247

            Image {
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
            width: 250
            height: 64
            text: "                CÀI ĐẶT HỆ THỐNG"
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            anchors.horizontalCenterOffset: -221

            Image {
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

        Rectangle {
            color: "palegoldenrod"
            width: 175
            height: 64
            anchors.right: parent.right
            anchors.bottom:  parent.bottom
        Image {
            id: state_icon
            source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
            anchors.right: parent.right
            scale: 0.8
        }

        Text {
            anchors.left:  parent.left
            anchors.verticalCenter: state_icon.verticalCenter
            text: qsTr("     Trang thai \n     ket noi")
            font.pixelSize: 18
        }
        }
        DangerButton {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: 175
            height: 64
            text: "      HOME"
            color: "palegoldenrod"
        Image {
             source: "qrc:/Icon/home2.png"
             anchors.left: parent.left
             scale: 0.7
        }

        }

}
scale: 0.7

}
