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
    Rectangle {
        anchors.fill: parent
        color: "lightblue"
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
        onClicked: stack.pop("ThuNghiemBangTay.qml")
        }

    }
    Button{
        id: vanXaButton
        x: 122
        y: 157
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
            Modbus.writeSingleCoil(3,press,11)
    }
    }
    Button{
        id: vanBomButton
        x: 122
        y: 357
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
            Modbus.writeSingleCoil(2,press,11)
        }
    }


    Button{
        id: startButton
        x: 759
        y: 409
        width: 133
        height: 99
        property bool press: false
        Image {
            id: startButtonImage
            source: "./Icon/switch-off.jpg"
            anchors.fill: parent
        }
        onClicked: {
            press= !press
            if (press)
            {
                startButtonImage.source = "./Icon/switch-on.jpg";
                Bientan.setStart(1);
            }
            else
            {
                Bientan.setStart(5);
                startButtonImage.source = "./Icon/switch-off.jpg";
            }
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
        stopValue: 300
        dialWidth: 4
        dialColor: "darkblue"

        Image {
            id: needle
            anchors.verticalCenterOffset: -26
            anchors.horizontalCenterOffset: 0
            source: "./Icon/needle.png"
            scale: 0.8
            anchors.centerIn: parent
            rotation: 39 + 30 + slider.value
            Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
        }

        Slider {
            id: slider
            anchors.top: speed.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            minimumValue: 0
            maximumValue: 300
            value: q_pressure
            visible: false
        }
    }


    Slider {
        id: velocity_slider
        x: 692
        y: 350
        width: 300
        minimumValue: 0
        maximumValue: 50
        onValueChanged:
        {
            ///Bientan.q_frequency = velocity_slider.value
//            Bientan.write_friquency(velocity_slider.value.toFixed(0));
        }
    }
    Text {
        id: txtTanSo
        x: 499
        y: 389
        width: 39.525
        text:  Modbus.readHoldingRegister(1,12288, 1)
        font.pixelSize: 20
    }

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

    }
    PrimaryButton {
        id: btnSpeed
        x: 641
        y: 175
        MouseArea {
        anchors.fill: parent
        onClicked: Bientan.write_friquency(parseInt(txtSpeed.text)*100)
        }
    }
    Text {
        x: 815
        y: 297
        width: 108
        height: 37
        text: velocity_slider.value.toFixed(0)
        font.weight: Font.Bold
        font.pointSize: 36
       }

    Text {
        id: name1
        x: 331
        y: 41
        text: qsTr("THỬ NGHIỆM BẰNG TAY")
        font.bold: true
        font.pointSize: 24
    }

    Text {
        x: 949
        y: 189
        width: 62
        height: 14
        text: qsTr("RPM")
        font.pointSize: 12
        font.bold: false
    }

    Text {
        x: 107
        y: 286
        text: qsTr("VAN CẤP NƯỚC")
        font.bold: false
        font.pointSize: 18
    }

    Text {
        x: 121
        y: 117
        text: qsTr("VAN XẢ NƯỚC")
        font.bold: false
        font.pointSize: 18
    }

    Text {
        x: 728
        y: 241
        text: qsTr("ĐIỀU KHIỂN TỐC ĐỘ")
        font.pointSize: 18
        font.bold: false
    }

    Text {
        x: 759
        y: 117
        text: qsTr("ĐẶT TỐC ĐỘ")
        font.pointSize: 18
        font.bold: false
    }

    Text {
        x: 537
        y: 471
        text: qsTr("START")
        font.bold: false
        font.pointSize: 18
    }

    Timer {
            interval: 500; running: true; repeat: true
            onTriggered: Cambien.sendRequest()
        }



  }
