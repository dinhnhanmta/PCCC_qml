import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.0
Item {
    anchors.fill: parent

    MessageDialog {
        id: messageDialog
        title: "Lỗi Đăng Nhập"
        icon: StandardIcon.Critical
        text: "Mã thiết bị không tồn tại! Hãy tạo mã mới!"
    }

    Connections {
        target: LoginTB
        onLoginSuccess: {
           stack2.push("KiemDinhTD.qml")
        }
        onLoginFailed: {
            messageDialog.visible = true
        }
    }

    Component.onCompleted: {
        if (LoginTB.logged()){
            stack2.push("KiemDinhTD.qml")
        } else {
            screenLabel.text = qsTr("ĐĂNG NHẬP THÔNG SỐ THIẾT BỊ")
        }
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
        TextField {
            id: maTB
            width: 800
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
            onClicked: LoginTB.login(maTB.text)
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


