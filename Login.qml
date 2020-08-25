import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.1

Item {
    anchors.fill: parent
    id: loginPage

    property color backGroundColor : "#394454"
    property color mainAppColor: "#6fda9c"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"
        Rectangle{
        anchors.fill: parent
        color: backGroundColor

        Text {
            id: label
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ĐĂNG NHẬP KIỂM ĐỊNH VIÊN"
            font.pixelSize: 26
            font.bold: true
            color: "white"
        }

        Item {
            anchors.top: label.bottom
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.fill: parent

            MessageDialog {
                id: messageDialog
                icon: StandardIcon.Critical
                title: "Đăng nhập thất bại"
                text: "Vui lòng kiểm tra lại tài khoản hoặc mật khẩu"
                onAccepted: {
                    messageDialog.visible = false
                }
            }

            Connections {
                target: QLogin
                onLoginSuccess: {
                   stack.push("MainWindow.qml")
                }
                onLoginFailed: {
                    messageDialog.visible = true
                }
            }

            Component.onCompleted: {
                if (QLogin.logged()){
                    stack.push("MainWindow.qml")
                }
            }

            Rectangle {
                anchors.fill: parent
                color: backGroundColor

                FontLoader {
                    id: fontAwesome
                    name: "fontawesome"
                    source: "qrc:/fontawesome-webfont.ttf"
                }

                Item {
                    anchors.fill: parent
                    anchors.margins: 20

                    Rectangle {
                        id: iconRect
                        height: parent.height / 3
                        color: backGroundColor
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Text {
                            id: icontext
                            text: qsTr("\uf170")
                            anchors.centerIn: parent
                            font.pointSize: 112
                            font.family: "fontawesome"
                            color: mainAppColor
                        }
                    }

                    ColumnLayout {
                        id: loginLayout
                        anchors.top: iconRect.bottom
                        anchors.topMargin: 50
                        anchors.left: parent.left
                        anchors.leftMargin: 200
                        anchors.right: parent.right
                        anchors.rightMargin: 200

                        TextField {
                            id: loginUsername
                            placeholderText: qsTr("User name")
                            color: mainTextCOlor
                            font.pointSize: 14
                            Layout.alignment: Qt.AlignCenter
                            Layout.fillWidth: true
                            font.family: "fontawesome"
                            leftPadding: 40
                            text: QLogin.loggedUsername()
                            background: Rectangle {
                                radius: implicitHeight / 2
                                color: "transparent"

                                Text {
                                    text: "\uf007"
                                    font.pointSize: 14
                                    font.family: "fontawesome"
                                    color: mainAppColor
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    leftPadding: 10
                                }

                                Rectangle {
                                    width: parent.width - 10
                                    height: 1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    color: mainAppColor
                                }
                            }
                        }

                        TextField {
                            id: loginPassword
                            placeholderText: qsTr("Password")
                            color: mainTextCOlor
                            font.pointSize: 14
                            font.family: "fontawesome"
                            Layout.alignment: Qt.AlignCenter
                            Layout.fillWidth: true
                            leftPadding: 40
                            echoMode: TextField.Password
                            text: QLogin.loggedPassword()
                            background: Rectangle {
                                implicitWidth: 200
                                implicitHeight: 50
                                radius: implicitHeight / 2
                                color: "transparent"
                                Text {
                                    text: "\uf023"
                                    font.pointSize: 14
                                    font.family: "fontawesome"
                                    color: mainAppColor
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    leftPadding: 10
                                }

                                Rectangle {
                                    width: parent.width - 10
                                    height: 1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    color: mainAppColor
                                }
                            }
                        }

                        Item {
                            height: 20
                        }

                        CButton{
                            height: 50
                            Layout.alignment: Qt.AlignCenter
                            Layout.preferredWidth: 200
                            name: "Đăng nhập"
                            baseColor: mainAppColor
                            borderColor: mainAppColor
                            onClicked: QLogin.onClick(loginUsername.text,loginPassword.text)
                        }

                        CButton{
                            height: 50
                            Layout.alignment: Qt.AlignCenter
                            Layout.preferredWidth: 200
                            name: "Bỏ qua"
                            baseColor: mainAppColor
                            borderColor: mainAppColor
                            onClicked: QLogin.onClick()
                        }
                    }
                }

            }
        }
    }

}


