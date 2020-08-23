import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
Item {
    width: 1024
    height: 600
    visible: true
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
        Text {
            y: 35
            text: qsTr("QUY TRÌNH KIỂM ĐỊNH TỰ ĐỘNG")
            anchors.horizontalCenterOffset: 1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }
        DoThi{
            x: 400
            y: 80
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
            MouseArea {
            anchors.fill: parent
            onClicked: stack.pop("KiemDinhTD.qml")
            }

        }

        PrimaryButton {
            x: 616
            y: 447
            width: 172
            height: 72
            text: "BẮT ĐẦU KIỂM ĐỊNH"
        }

        Text {
            x: 170
            y: 447
            text: qsTr("TRẠNG THÁI VAN CÁP NƯỚC")
        }

        Rectangle {
            x: 215
            y: 481
            width: 74
            height: 38
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }
        }

        Text {
            x: 400
            y: 447
            text: qsTr("TRẠNG THÁI VAN XẢ NƯỚC")
        }

        Rectangle {
            x: 441
            y: 481
            width: 74
            height: 38
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }
        }

        Text {
            x: 135
            y: 317
            text: qsTr("TỐC ĐỘ ĐỘNG CƠ")
        }

        Input {
            x: 117
            y: 351
            width: 145
            height: 42
            text: "100"
            pointSize: 26
            disabled: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }


        Text {
            x: 135
            y: 94
            text: qsTr("ÁP SUẤT")
        }
        DialItem {
            x: 100
            y: 120
            width: 200
            height: width
            startAngle: 30
            spanAngle: 300
            startValue: 0
            stopValue: 100
            dialWidth: 4
            dialColor: "darkblue"
            Image {
                id: needle
                source: "./Icon/needle.png"
                scale: 0.8
                anchors.centerIn: parent
                rotation: 39 + 30 + pressureValue.value*3
                Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
            }
            Slider {
                id: pressureValue
                anchors.top: speed.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 300
                minimumValue: 0
                maximumValue: 300
                value: Cambien.q_pressure
                visible: false
            }
        }
    }



}
