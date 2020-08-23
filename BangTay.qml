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
    Button{
        id: vanXaButton
        x: 115
        y: 234
        width: 133
        height: 99
        property bool press: false
        Image {
            id: buttonImage
            source: "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
            press= !press
            if (press) buttonImage.source = "./Icon/switch-on.jpg";
            else buttonImage.source = "./Icon/switch-off.jpg";
            Vavle.writeVavleState1(press)
    }
    }
    Button{
        id: vanBomButton
        x: 121
        y: 456
        width: 133
        height: 99
        property bool press: false
        Image {
            id: buttonImage2
            source: "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
            press= !press
            if (press)
                buttonImage2.source = "./Icon/switch-on.jpg";
            else buttonImage2.source = "./Icon/switch-off.jpg";
            Vavle.writeVavleState2(press)

    }
    }
    DialItem {
        id: speed
        objectName: "speed"
        width: 250
        height: width
        anchors.centerIn: parent
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
            rotation: 39 + 30 + inverter_slider.value
            Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
        }
    }
    Slider {
        id: inverter_slider
        anchors.top: speed.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        minimumValue: 0
        maximumValue: 300
        onValueChanged:
        {
            Bientan.q_frequency = inverter_slider.value
            Bientan.write_friquency();
        }
    }
    Text {
        id: element
        x: 498
        y: 494
        width: 39.525
        text: (inverter_slider.value/300*(speed.stopValue-speed.startValue)).toFixed(0)
        font.pixelSize: 20
    }

    DangerButton{
        x: 396
        y: 703
        width: 233
        height: 64
        text: "HOME"
        MouseArea {
        anchors.fill: parent
        onClicked: stack.pop("MainWindow.qml")
        }
    }

    Text {
        id: name
        x: 751
        y: 276
        text: qsTr("AP SUAT")
        font.bold: true
        font.pointSize: 18
    }
    Input{
        x: 751
        y: 325
        borderColor: "black"
        backgroundColor: "lightblue"
        disabled: true
        text: Cambien.q_pressure
        textColor: "black"

    }

    Input{
        x: 751
        y: 477
        borderColor: "black"
        backgroundColor: "lightblue"
        disabled: true
        text: (inverter_slider.value/300*(speed.stopValue-speed.startValue)).toFixed(0)
        textColor: "black"

    }

    Text {
        id: name1
        x: 330
        y: 95
        text: qsTr("THU NGHIEM BANG TAY")
        font.bold: true
        font.pointSize: 24
    }

    Text {
        id: name2
        x: 940
        y: 351
        width: 62
        height: 14
        text: qsTr("Bar")
        font.pointSize: 12
        font.bold: false
    }

    Text {
        id: name3
        x: 751
        y: 428
        text: qsTr("TAN SO")
        font.pointSize: 18
        font.bold: true
    }

    Text {
        id: name4
        x: 940
        y: 503
        width: 62
        height: 14
        text: qsTr("Hz")
        font.pointSize: 12
        font.bold: false
    }

    Text {
        id: name5
        x: 123
        y: 396
        text: qsTr("VAN DAU VAO")
        font.bold: true
        font.pointSize: 18
    }

    Text {
        id: name6
        x: 121
        y: 188
        text: qsTr("VAN XA NUOC")
        font.bold: true
        font.pointSize: 18
    }


  }
