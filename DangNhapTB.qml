import QtQuick 2.0
import "FlatUI-Controls-QML-master"
Item {
    width: 1024
    height: 800
    visible: true
    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        Text {
            y: 120

            text: qsTr("ĐĂNG NHẬP THÔNG SỐ THIẾT BỊ")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }

        Text {
            id: name
            x: 481
            y: 334
            text: qsTr("MÃ THIẾT BỊ")
        }
        Input {
            initText: "4"
            x: 436
            y: 380
            objectName: "inverterID"
        }

        PrimaryButton {
            x: 201
            y: 511
            width: 227
            height: 51
            text: "ĐĂNG NHẬP MÃ KIỂM ĐỊNH"
        }

        PrimaryButton {
            x: 638
            y: 511
            width: 227
            height: 51
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
