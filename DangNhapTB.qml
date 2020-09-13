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

    Constants {
      id: constants;
    }

    Connections {
        target: LoginTB
        onLoginSuccess: {
           stack2.push("KiemDinhTD.qml")
        }
        onLoginFailed: {
            messageDialog.visible = true
            deviceLoginBtn.enabled = true
        }
        onUnauthorized: {
            stack2.pop()
            stack.pop()
            stack.push("Login.qml")
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
        color: "#ddf6fe"

        Row {
            spacing: 50
            anchors.centerIn: parent
            children: [
                Column {
                    id: column1
                    spacing: 50
                    children: [
                        Text {
                            text: qsTr("LOẠI THIẾT BỊ")
                            font.bold: true
                            font.pointSize: 16
                            anchors.horizontalCenter: parent.horizontalCenter
                        },
                        ComboBox {
                            id: cbDeviceModel
                            model: ListModel {
                                id: cbItems
                                ListElement { text: ""; }
                                ListElement { text: "Vòi"; }
                                ListElement { text: "Lăng phun"; }
                                ListElement { text: "Đầu nối chữa cháy"; }
                                ListElement { text: "Trụ nước chữa cháy"; }
                            }
                            width: 400
                            font.pointSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                            onCurrentIndexChanged: LoginTB.setDeviceModelName(cbItems.get(currentIndex).text)
                        }
                    ]
                },
                Column {
                    id: column
                    spacing: 50
                    children: [
                        Text {
                            text: qsTr("MÃ THIẾT BỊ")
                            font.bold: true
                            font.pointSize: 16
                            anchors.horizontalCenter: parent.horizontalCenter
                        },
                        Row {
                            spacing: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            children: [
                                ComboBox {
                                    id: cbDeviceCode
                                    model: ListModel {
                                        id: cbItems2
                                        ListElement { text: ""; }
                                        ListElement { text: "ABDC"; }
                                        ListElement { text: "XYZ"; }
                                        ListElement { text: "123"; }
                                        ListElement { text: "321"; }
                                    }
                                    width: 235
                                    font.pointSize: 13
                                },
                                TextField {
                                    id: maTB
                                    width: 235
                                    font.pointSize: 13
                                }
                            ]
                        },
                        Row {
                            spacing: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            children: [
                                PrimaryButton {
                                    id: deviceLoginBtn
                                    width: 235
                                    color: cbDeviceCode.currentText === "" ? constants.grayLight : constants.turquoise
                                    text: "ĐĂNG NHẬP MÃ KIỂM ĐỊNH"
                                    pointSize: 10
                                    MouseArea {
                                        onClicked: {
                                            if (cbDeviceCode.currentText !== "") {
                                                LoginTB.login(cbDeviceCode.text)
                                            }
                                        }
                                    }
                                },
                                PrimaryButton {
                                    color:  maTB.text === "" ? constants.grayLight : constants.turquoise
                                    width: 235
                                    text: "TẠO MÃ KIỂM ĐỊNH"
                                    pointSize: 10
                                    MouseArea {
                                        onClicked: {
                                            if (maTB.text !== "") {
                                                LoginTB.generateCode(maTB.text)
                                            }
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    }
}


