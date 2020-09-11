import QtQuick 2.0
import "FlatUI-Controls-QML-master"

Item {
    anchors.fill: parent
    Component.onCompleted: {
        screenLabel.text = qsTr("MENU")
    }
    Constants {
      id: constants;
    }
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
        Column {
            anchors.centerIn: parent
            spacing: 30
            PrimaryButton {
                text: QLogin.logged() ? qsTr("ĐĂNG XUẤT KIỂM ĐỊNH VIÊN") : qsTr("ĐĂNG NHẬP")

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
                color: !LoginTB.logged() ? constants.grayLight : constants.turquoise
                text: qsTr("ĐĂNG XUẤT THIẾT BỊ")
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        LoginTB.logout()
                        stack2.clear()
                    }
                    enabled: LoginTB.logged()
                }
            }
        }


    }
}
