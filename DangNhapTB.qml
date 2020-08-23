import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Dialogs 1.1
Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("ĐĂNG NHẬP THÔNG SỐ THIẾT BỊ")

    MessageDialog {
        id: messageDialog
        title: "Lỗi Đăng Nhập"
        icon: StandardIcon.Critical
        text: "Mã thiết bị không tồn tại! Hãy tạo mã mới!"
    }

    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: "lightblue"

        Text {
            id: name
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -100
            text: qsTr("MÃ THIẾT BỊ")
        }
        Input {
            id: maTB
            width: 200
            anchors.verticalCenterOffset: -50
            anchors.centerIn: parent
        }

        PrimaryButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -200
            anchors.top: maTB.bottom
            anchors.topMargin: 50
            text: "ĐĂNG NHẬP MÃ KIỂM ĐỊNH"
            MouseArea {
            anchors.fill: parent
            onClicked:
                {
                    if (LoginTB.checkLogin(maTB.text)) stack.push("KiemDinhTD.qml")
                    else messageDialog.visible = true
                }
            }
        }

        PrimaryButton {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 200
            anchors.top: maTB.bottom
            anchors.topMargin: 50
            text: "TẠO MÃ KIỂM ĐỊNH"
        }
    }
}


