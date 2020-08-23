import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("QUY TRÌNH KIỂM ĐỊNH TỰ ĐỘNG")

    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        Row {
            id: row1
            anchors.top: parent.top
            anchors.topMargin: 20
            height: parent.height - 40 - 100
            width: parent.width
            Column {
                id: column3
                y: 0
                height: parent.height
                width: parent.width/3
                spacing: 10
                Text {
                    text: qsTr("ÁP SUẤT")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                DialItem {
                    width: 200
                    height: width
                    startAngle: 30
                    anchors.horizontalCenter: parent.horizontalCenter
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 300
                        minimumValue: 0
                        maximumValue: 300
                        value: 80
                        visible: false
                    }
                }
                Text {
                    text: qsTr("TỐC ĐỘ ĐỘNG CƠ")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Input {
                    width: 164
                    height: 35
                    text: "100"
                    pointSize: 16
                    disabled: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column {
                height: parent.height
                width: parent.width*2/3
                DoThi{
                    anchors.centerIn: parent
                }
            }
        }

        Row {
            id: row
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            height: 100
            width: parent.width

            Column{
                id: column1
                spacing: 20
                width: parent.width/3
                Text {
                    text: qsTr("TRẠNG THÁI VAN CÁP NƯỚC")
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    width: 108
                    height: 59
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        source: "qrc:/Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                }
            }

            Column{
                id: column
                spacing: 20
                width: parent.width/3
                Text {
                    text: qsTr("TRẠNG THÁI VAN XẢ NƯỚC")
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    width: 108
                    height: 59
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        source: "qrc:/Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                }
            }

            Column {
                id: column2
                width: parent.width/3
                height: parent.height/2
                anchors.verticalCenter: parent.verticalCenter
                PrimaryButton {
                    width: 206
                    height: parent.height
                    text: "BẮT ĐẦU KIỂM ĐỊNH"
                }
            }
        }

    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
