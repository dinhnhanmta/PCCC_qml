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

        screenLabel.text = qsTr("KIỂM ĐỊNH BẰNG TAY")

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
        color: "#e4f9ff"

        Row {
            id: row
            anchors.centerIn: parent
            width: parent - 60
            height: parent.height
            spacing: 10

            Column {
                id: column1
                y: 20
                width: 450
                spacing: 12
                height: parent.height

                Text {
                    text: qsTr("ĐÈN BẮT ĐẦU")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: denBatDau
                    width: 150
                    height: 80
                    anchors.horizontalCenter: parent.horizontalCenter
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

                Text {
                    text: qsTr("PUML DOWN")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: vanXaButton
                    width: 150
                    height: 80
                    anchors.horizontalCenter: parent.horizontalCenter
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
                    text: qsTr("PUMP UP")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }

                Button{
                    id: vanBomButton
                    width: 150
                    height: 80
                    anchors.horizontalCenter: parent.horizontalCenter
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



            }
            Column {
                id: column2
                width: 450
                spacing: 16
                height: parent.height
                Text {
                    text: qsTr("ÁP SUẤT")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 18
                }

                DialItem {
                    id: speed
                    width: 300
                    height: width
                    startAngle: 30
                    spanAngle: 300
                    startValue: 0
                    stopValue: 25
                    dialWidth: 4
                    dialColor: "darkblue"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: needle
                        width: 270
                        height: 270
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
                    font.pointSize: 20
                }


            }
        }
    }
}

