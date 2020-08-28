import QtQuick 2.0
import "FlatUI-Controls-QML-master"

Item {
    anchors.fill: parent
    Component.onCompleted: {
        screenLabel.text = qsTr("MENU")
    }
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
        Column {
            anchors.centerIn: parent
            spacing: 30
            PrimaryButton {
                text: qsTr("ĐĂNG XUẤT KIỂM ĐỊNH VIÊN")

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        QLogin.logout()
                        stack.pop()
                        stack.push("Login.qml")
                        stack2.clear()
                    }
                }
            }

            PrimaryButton {
                text: qsTr("ĐĂNG XUẤT THIẾT BỊ")

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        LoginTB.logout()
                        stack2.clear()
                    }
                }
            }
        }


    }
}
