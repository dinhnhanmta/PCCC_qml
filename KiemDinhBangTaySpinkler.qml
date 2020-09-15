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

        screenLabel.text = qsTr("KIỂM ĐỊNH BẰNG TAY LƯU LƯỢNG SPINKLER")

        TnBangTay.swapTuLuuLuong(true);
        TnBangTay.setLcdID(20)
        TnBangTay.setRelayD(21)
        TnBangTay.setBienTanID(2)
    }

    Timer {
            interval: 200; running: true; repeat: true
          onTriggered: Cambien.sendRequest()
        }
    Timer {
                interval: 200; running: true; repeat: true
                onTriggered:
                {
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
                width: 350
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
                        source: TnBangTay.q_led_start ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        press= !press
                        TnBangTay.setLedStart(!TnBangTay.q_led_start);
                    }
                }

                Text {
                    text: qsTr("PUML UP")
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
                        source: TnBangTay.q_led_vavle_up ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        press= !press
                        TnBangTay.setLedValveUp(!TnBangTay.q_led_vavle_up);
                    }
                }

                Text {
                    text: qsTr("PUMP DOWN")
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
                        source: TnBangTay.q_led_vavle_down ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                        anchors.fill: parent
                    }
                    onClicked: {
                        press= !press
                        TnBangTay.setLedValveDown(!TnBangTay.q_led_vavle_down)
                    }
                }

            }
            Column {
                id: column2
                width: 350
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
                        value: Cambien.q_pressure_ll*12
                        visible: false
                    }


                }
                Text {
                    id: pressure_value
                    text: Cambien.q_pressure_ll.toFixed(1)
                    anchors.horizontalCenter: parent.horizontalCenter
                    elide: Text.ElideNone
                    font.pointSize: 18
                }


            }
            Column {
                id: column
                width: 350
                spacing: 50
                height: parent.height
                anchors.top: parent.top
                anchors.topMargin: 20
                Text {
                    id: tocDoText
                    text: qsTr("TỐC ĐỘ ĐẶT")
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
                        color: "#0410d6"
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
                    text: qsTr("TỐC ĐỘ THỰC TẾ")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pointSize: 18
                }
                Text {
                    color: "#fd410b"
//                    text: "#Bientan.q_real_frequency/100#"
                    text: (Bientan.q_real_frequency/100).toFixed(1)
                    font.family: "Tahoma"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 18
                }

            }
        }
    }
}

