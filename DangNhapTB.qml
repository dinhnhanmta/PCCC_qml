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

    MessageDialog {
        id: messageDialog2
        title: "Lỗi"
        icon: StandardIcon.Critical
        text: "Lỗi lấy danh sách thiết bị"
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
        onGetDeviceModelsFailed: {
            messageDialog2.visible = true;
        }
        onGetDevicesFailed: {
            messageDialog2.visible = true;
        }
        onGetDeviceModelDetailSuccess: {
            cbDeviceCode.enabled = true;
            maTB.enabled = true;
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
            LoginTB.getListDeviceModels();
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
                            model: LoginTB.deviceModels
                            width: 400
                            font.pointSize: 13
                            anchors.horizontalCenter: parent.horizontalCenter
                            textRole: "display"
                            onCurrentIndexChanged: {
                                LoginTB.setDeviceModelName(cbDeviceModel.textAt(cbDeviceModel.currentIndex))
                            }
                            onModelChanged: {
                                currentIndex = LoginTB.currentDeviceModelIndex()
                                LoginTB.getListDevicesCode()
                            }
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
                                    enabled: LoginTB.deviceModelName() !== ""
                                    model: LoginTB.deviceCodes
                                    width: 235
                                    textRole: "display"
                                    font.pointSize: 13
                                    onCurrentIndexChanged: {
                                        if (cbDeviceCode.textAt(cbDeviceCode.currentIndex) === ""){
                                            deviceLoginBtn.color = constants.grayLight
                                        } else {
                                            deviceLoginBtn.color = constants.turquoise
                                        }
                                    }
                                },
                                TextField {
                                    id: maTB
                                    enabled: LoginTB.deviceModelName() !== ""
                                    width: 235
                                    font.pointSize: 13
                                    onTextChanged: {
                                        if (maTB.text === ""){
                                            generateDeviceBtn.color = constants.grayLight
                                        } else {
                                            generateDeviceBtn.color = constants.turquoise
                                        }
                                    }
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
                                        anchors.fill: parent
                                        onClicked: {
                                            if (cbDeviceCode.currentText !== "") {
                                                LoginTB.loginDevice(cbDeviceCode.currentText)
                                            }
                                        }
                                    }
                                },
                                PrimaryButton {
                                    id: generateDeviceBtn
                                    color:  maTB.text === "" ? constants.grayLight : constants.turquoise
                                    width: 235
                                    text: "TẠO MÃ KIỂM ĐỊNH"
                                    pointSize: 10
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            if (maTB.text !== "") {
                                                LoginTB.saveDevice(maTB.text)
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


