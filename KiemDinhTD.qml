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
            y: 8
            text: qsTr("QUY TRÌNH KIỂM ĐỊNH TỰ ĐỘNG")
            anchors.horizontalCenterOffset: 1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }
        DoThi{
            x: 280
            y: 55
        }
        Image {

            source: "qrc:/Icon/account.png"
            scale: 0.8
            anchors.right: parent.right
            anchors.top: parent.top
        }

        Row {
            id: footer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 64
            DangerButton {
                text: "Modbus"
                color: "palegoldenrod"
                width: 200
                anchors.right: parent.right
                anchors.bottom:  parent.bottom
                Image {
                    source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                    anchors.right: parent.right
                    scale: 0.7
                }
            }


            DangerButton {
                text: "Cảm biến"
                color: "palegoldenrod"
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    source: Cambien.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                    anchors.right: parent.right
                    scale: 0.7
                }
            }

            DangerButton {
                text: "Home"
                color: "palegoldenrod"
                width: 200
                anchors.left: parent.left
                anchors.bottom:  parent.bottom
                Image {
                     source: "qrc:/Icon/home2.png"
                     anchors.left: parent.left
                     scale: 0.7
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stack.pop("DangNhapTB.qml")
                    }
                }
            }
        }

        PrimaryButton {
            x: 59
            y: 449
            width: 167
            height: 47
            text: "BẮT ĐẦU KIỂM ĐỊNH"
        }

        Text {
            x: 17
            y: 357
            text: qsTr("VAN CÁP NƯỚC")
        }

        Rectangle {
            x: 35
            y: 390
            width: 60
            height: 37
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }
        }

        Text {
            x: 155
            y: 357
            text: qsTr("VAN XẢ NƯỚC")
        }

        Rectangle {
            x: 175
            y: 390
            width: 60
            height: 37
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }
        }

        Text {
            x: 68
            y: 277
            text: qsTr("TỐC ĐỘ ĐỘNG CƠ")
        }

        Input {
            x: 80
            y: 306
            width: 103
            height: 34
            text: "123"
            pointSize: 18
            disabled: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }


        Text {
            id: textPressureDial
            x: 101
            y: 31
            text: qsTr("ÁP SUẤT")
        }
        DialItem {
            x: 100
            id: speed
            anchors.top: textPressureDial.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: textPressureDial.horizontalCenter
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
