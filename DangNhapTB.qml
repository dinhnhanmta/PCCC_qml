import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Dialogs 1.1
Item {
    width: 1024
    height: 600
    visible: true
    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        MessageDialog {
            id: messageDialog
            title: "Lỗi Đăng Nhập"
            icon: StandardIcon.Critical
            text: "Mã thiết bị không tồn tại! Hãy tạo mã mới!"
        }

        Text {
            y: 120

            text: qsTr("ĐĂNG NHẬP THÔNG SỐ THIẾT BỊ")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }

        Text {
            id: name
            x: 487
            y: 244
            text: qsTr("MÃ THIẾT BỊ")
        }
        Input {
            id: maTB
            x: 442
            y: 290
            objectName: "inverterID"
        }

        PrimaryButton {
            x: 100
            y: 447
            text: "ĐĂNG NHẬP MÃ KIỂM ĐỊNH"
            MouseArea {
            anchors.fill: parent
            onClicked:
                {
                if (LoginTB.checkLogin(maTB.text))
                stack.push("KiemDinhTD.qml")
                else messageDialog.visible = true
                }
            }
        }

        PrimaryButton {
            x: 600
            y: 447
            text: "TẠO MÃ KIỂM ĐỊNH"
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
                text: qsTr("     Trạng thái\n     kết nối")
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
            MouseArea {
            anchors.fill: parent
            onClicked: stack.pop("DangNhapTB.qml")
            }
            }

        }


}


