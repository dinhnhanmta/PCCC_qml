import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import IVIControls 1.0
import QtQuick.Controls 1.2
Item
{
    id: window
    width: 1024
    height: 600
     visible: true

    Component.onCompleted: {
//        TnBangTay.startModbus();
//        TnBangTay.startICP();
    }


    Rectangle {
        anchors.fill: parent
        color: "lightblue"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Image {

        source: "qrc:/Icon/account.png"
        scale: 0.8
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Rectangle {
        x: 877
        y: 548
        color: "palegoldenrod"
        width: 147
        height: 44
        anchors.right: parent.right
        anchors.bottom:  parent.bottom
        Image {
            id: state_icon
            source: Cambien.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
            anchors.right: parent.right
            anchors.rightMargin: -15
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.4
        }

        Text {
            anchors.left:  parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("     Trạng thái \n     Dcon")
            anchors.leftMargin: -15
            font.pixelSize: 18
        }
    }
    //    Timer {
    //            interval: 200; running: true; repeat: true
    ////            onTriggered: Cambien.sendRequest()
    //        }
    Rectangle {
        x: 706
        y: 556
        color: "palegoldenrod"
        width: 147
        height: 44
        Image {
            id: state_icon1
            source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
            anchors.right: parent.right
            anchors.rightMargin: -15
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.4
        }

        Text {
            anchors.left:  parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("     Trạng thái \n     Modbus")
            anchors.leftMargin: -15
            font.pixelSize: 18
        }
    }
    DangerButton {
        y: 550
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 175
        height: 44
        text: "     HOME"
        color: "palegoldenrod"
        Image {
            source: "qrc:/Icon/home2.png"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.4
        }
        MouseArea {
            anchors.fill: parent
            onClicked:
            {
//                TnBangTay.stopICP();
//                TnBangTay.stopModbus();
                stack.pop("ThuNghiemBangTay.qml")
            }

        }
    }
    Button{
        id: vanXaButton
        x: 121
        y: 161
        width: 120
        height: 70
        enabled: Modbus.q_connectionState
        property bool press: false
        Image {
            id: buttonImage
            anchors.rightMargin: -1
            anchors.bottomMargin: 3
            anchors.leftMargin: 1
            anchors.topMargin: -3
            source: Relay.q_ouput_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
                    Relay.writeOutputVavle(!Relay.q_ouput_vavle_state)
                   // Relay.readAllState();
                    //Modbus.writeSingleCoil(3,press,11)
        }
    }
    Button{
        id: vanBomButton
        x: 121
        y: 304
        width: 120
        height: 70
        enabled: Modbus.q_connectionState
        property bool press: false
        Image {
            id: buttonImage2
            anchors.rightMargin: -1
            anchors.bottomMargin: -2
            anchors.leftMargin: 1
            anchors.topMargin: 2
            source: Relay.q_input_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
            press= !press
            Relay.writeInputVavle(!Relay.q_input_vavle_state)
            //Relay.readAllState();
            //Modbus.writeSingleCoil(2,press,11)
        }
    }

    Button{
        id: denBatDau
        x: 121
        y: 435
        width: 120
        height: 70
        enabled: Modbus.q_connectionState
        property bool press: false
        Image {
            id: buttonImage3
            width: 120
            height: 70
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            source: "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
            press= !press
            if (press)
            {
                buttonImage3.source  = "./Icon/switch-on.jpg";
                Bientan.setStart(1);
            }
            else
            {
                buttonImage3.source = "./Icon/switch-off.jpg";
                Bientan.setStart(5);
            }
        }
    }


    DialItem {
        id: speed

        width: 200
        height: width
        anchors.centerIn: parent
        startAngle: 30
        spanAngle: 300
        startValue: 0
        stopValue: 25
        dialWidth: 4
        dialColor: "darkblue"

        Image {
            id: needle
            anchors.verticalCenterOffset: -24
            anchors.horizontalCenterOffset: 1
            source: "./Icon/needle.png"
            scale: 0.8
            anchors.centerIn: parent
            rotation: 39 + 30 + slider.value
            Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
        }

        Slider {
            id: slider
            y: -82
            anchors.top: speed.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            anchors.horizontalCenterOffset: 7
            minimumValue: 0
            maximumValue: 300
            value: Cambien.q_pressure*12
            visible: false
        }
    }
    Text {
        id: pressure_value
        x: 444
        y: 406
        text: Cambien.q_pressure.toFixed(2)
        elide: Text.ElideNone
        font.pointSize: 18
    }

    Slider {
        id: velocity_slider
        x: 691
        y: 419
        width: 300
        minimumValue: 0
        maximumValue: 50
        onValueChanged:
        {
           txtSpeed.text = velocity_slider.value.toFixed(0)
        }

        onPressedChanged:
        {
            if(!pressed)  Bientan.write_friquency(velocity_slider.value.toFixed(0));
        }
    }



//    Image {
//        id: inputVavleState
//        x: 338
//        y: 465
//        height: 67
//        width: 81
//        source: Relay.q_input_vavle_state ? "qrc:/Icon/on_state.png" : "qrc:/Icon/off_state.png"
//    }
//    Image {
//        id: outputVavleState
//        x: 541
//        y: 465
//        height: 67
//        width: 81
//        source: Relay.q_ouput_vavle_state ? "qrc:/Icon/on_state.png" : "qrc:/Icon/off_state.png"
//    }
//    Image {
//        id: startLedState
//        x: 773
//        y: 465
//        height: 67
//        width: 81
//        source: Relay.q_start_led_state ? "qrc:/Icon/on_state.png" : "qrc:/Icon/off_state.png"
//    }
    Text {
        id: name
        x: 467
        y: 117
        text: qsTr("ÁP SUẤT")
        font.bold: true
        font.pointSize: 18
    }
    Input{
        id: txtSpeed
        x: 837
        y: 170
        width: 100
        height: 40
        borderColor: "black"
        backgroundColor: "lightblue"
        textColor: "black"
        text: "0"

    }
    PrimaryButton {
        id: btnSpeed
        x: 681
        y: 170
        width: 125
        height: 40
        enabled: Modbus.q_connectionState
        text: "Đặt tốc độ"
        MouseArea {
            anchors.fill: parent
            onClicked: Bientan.write_friquency(parseInt(txtSpeed.text)*100)
        }
    }
    Text {
        x: 816
        y: 337
        width: 108
        height: 37
        text: Cambien.q_val_pot
        font.weight: Font.Bold
        font.pointSize: 36
       }

    Text {
        id: name1
        x: 310
        y: 33
        text: qsTr("THỬ NGHIỆM BẰNG TAY")
        font.bold: true
        font.pointSize: 24
    }

    Text {
        x: 949
        y: 183
        width: 62
        height: 14
        text: qsTr("RPM")
        font.pointSize: 12
        font.bold: false
    }

    Text {
        x: 144
        y: 396
        text: qsTr("START")
        font.bold: true
        font.pointSize: 18
    }

    Text {
        x: 121
        y: 117
        text: qsTr("PUMP- UP")
        font.bold: true
        font.pointSize: 18
    }

    Text {
        x: 728
        y: 286
        text: qsTr("ĐIỀU KHIỂN TỐC ĐỘ")
        font.pointSize: 18
        font.bold: false
    }

    Text {
        x: 772
        y: 103
        text: qsTr("ĐẶT TỐC ĐỘ")
        font.pointSize: 18
        font.bold: false
    }

    Text {
        x: 102
        y: 262
        text: qsTr("PUMP-DOWN")
        font.bold: true
        font.pointSize: 18
    }

    Text {
        x: 369
        y: 476
        text: qsTr("TỐC ĐỘ BIẾN TẦN THỰC TẾ")
        font.bold: false
        font.pointSize: 18
    }
    Text {
        x: 454
        y: 519
        text: Bientan.q_velocity
        font.bold: false
        font.pointSize: 18
    }

    Timer {
            interval: 200; running: true; repeat: true
            onTriggered: Cambien.sendRequest()
        }

    Timer {
            interval: 200; running: true; repeat: true
            onTriggered:
            {
//                Relay.readAllState()
              // Bientan.readVelocity()
            }
        }

  }
