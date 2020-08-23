import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import IVIControls 1.0
import QtQuick.Controls 1.2
Item
{
    anchors.fill: parent
    Component.onCompleted:
        {

        screenLabel.text = qsTr("THỬ NGHIỆM BẰNG TAY")

    }

    Timer {
            interval: 200; running: true; repeat: true
          onTriggered: Cambien.sendRequest()
        }
    Timer {
                interval: 200; running: true; repeat: true
                onTriggered:
                {
//                     Relay.readAllState()
                  // Bientan.readVelocity()
                    TnBangTay.updateLogic()
                }
            }

    Rectangle {
        anchors.fill: parent
        color: "lightblue"

        Row {
            id: row
            anchors.centerIn: parent
            width: parent - 60
            height: parent.height
            spacing: 60

            Column {
                id: column1
                y: 20
                spacing: 20
                height: parent.height - 40

                Text {
                    text: qsTr("PUML UP")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: vanXaButton
                    width: 108
                    height: 64
                    enabled: Modbus.q_connectionState
                    property bool press: false
                    Image {
                        id: buttonImage
                        source: Relay.q_ouput_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        Relay.writeOutputVavle(!Relay.q_ouput_vavle_state)
                    }
                }

                Text {
                    text: qsTr("VAN CẤP NƯỚC")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: vanBomButton
                    width: 108
                    height: 64
                    enabled: Modbus.q_connectionState
                    property bool press: false
                    Image {
                        id: buttonImage2
                        source: Relay.q_input_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        press= !press
                        Relay.writeInputVavle(!Relay.q_input_vavle_state)
                    }
                }

                Text {
                    text: qsTr("ĐÈN BẮT ĐẦU")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: denBatDau
                    width: 108
                    height: 64
                    enabled: Modbus.q_connectionState
                    property bool press: false
                    Image {
                        id: buttonImage4
                        source: Relay.q_start_led_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        press= !press
                        Relay.writeStartLed(!Relay.q_start_led_state)
                    }
                }

            }
            Column {
                id: column2
                spacing: 40
                height: parent.height
                Text {
                    text: qsTr("ÁP SUẤT")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 18
                }

                DialItem {
                    id: speed
                    width: 200
                    height: width
                    startAngle: 30
                    spanAngle: 300
                    startValue: 0
                    stopValue: 25
                    dialWidth: 4
                    dialColor: "darkblue"

                    Image {
                        id: needle
                        source: "./Icon/needle.png"
                        scale: 0.8
                        anchors.centerIn: parent
                        rotation: 39 + 30 + slider.value
                        Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
                    }

                    Slider {
                        id: slider
                        y: -58
                        anchors.top: speed.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 300
                        anchors.horizontalCenterOffset: -55
                        minimumValue: 0
                        maximumValue: 300
                        value: Cambien.q_pressure*12
                        visible: false
                    }
                }

                Text {
                    id: pressure_value
                    text: Cambien.q_pressure.toFixed(1)
                    anchors.horizontalCenter: parent.horizontalCenter
                    elide: Text.ElideNone
                    font.pointSize: 18
                }
            }
            Column {
                id: column
                spacing: 55
                height: parent.height
                anchors.top: parent.top
                anchors.topMargin: 50
                Text {
                    id: tocDoText
                    text: qsTr("ĐIỀU KHIỂN TỐC ĐỘ")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 18
                    font.bold: false
                }
                Row
                {
                    id: row_speed
//                    layoutDirection: Qt.LeftToRight
                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.leftMargin: 0
                    Text {
                        width: 108
                        height: 37
                        text: Cambien.q_val_pot.toFixed(1)

                        font.weight: Font.Bold
                        font.pointSize: 24
                    }
                    //                Text {
                    //                    width: 108
                    //                    height: 37
                    //                    text: "Hz"
                    //                    anchors.horizontalCenter: parent.horizontalCenter
                    //                    font.weight: Font.Bold
                    //                    font.pointSize: 24
                    //                }
                }
                Text {
                    text: qsTr("TỐC ĐỘ BIẾN TẦN THỰC TẾ")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }
                Text {
                    text: Bientan.q_velocity
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

            }
        }
    }
}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
