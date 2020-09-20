import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
import QtQuick.Extras 1.4
import QtCharts 2.3

Item {
    anchors.fill: parent
    visible: true

    Component.onCompleted:
    {
//        KiemDinhTDObj.startThreadICP();
//         KiemDinhTDObj.setPTried(apSuatThu.text)
    }

    // Timer cho cap nhat gia tri led
//    Timer {
//        interval: 100; running: true; repeat: true
//        onTriggered:{
//            Cambien.sendRequest();
//        }
//    }

    // Timer count down
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.checkState()
        }
    }
    //        // Timer cap nhat state machine
        Timer {
            interval: 100; running: true; repeat: true
            onTriggered:{
                KiemDinhTDObj.updateState()
            }
        }

//    Timer cap nhat ngoai vi
        Timer {
            interval: 150; running: true; repeat: true
            onTriggered:{
                KiemDinhTDObj.updateLogic()
            }
        }

    //        //    Timer cap nhat Chart
            property var x_var: 0
            Constants {
                id: constants
            }

            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered:{
                    x_var ++;
                    if(lineSeries1.count > 100) lineSeries1.remove(0);
                    lineSeries1.append(x_var, Cambien.q_pressure);

                    if(lineSeries2.count > 100) lineSeries2.remove(0);
                    lineSeries2.append(x_var, KiemDinhTDObj.q_pReference);

                    axisX.min = lineSeries2.at(0).x
                    axisX.max = lineSeries2.at(lineSeries1.count-1).x
                }
            }

    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
        Component.onCompleted: screenLabel.text = qsTr("KIỂM ĐỊNH TỰ ĐỘNG")


        Text {
            id: element
            x: 82
            y: 9
            width: 123
            height: 24
            text: qsTr("Áp Suất Đo")
            font.bold: true
            font.family: "Ubuntu"
            font.pixelSize: 18
        }

        SplitView {
            id: splitView
            x: 22
            y: 44
            width: 214
            height: 205

            DialItem {
                id: speed1
                width: 230
                height: 230
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                //                fillColor: "#0f0f00"
                startAngle: 40
                spanAngle: 290
                startValue: 0
                stopValue: 25
                dialWidth: 5
                dialColor: "darkblue"
                Image {
                    id: needle
                    width: 200
                    height: 200
                    source: "./Icon/needle.png"
                    scale: 0.8
                    anchors.centerIn: parent
                    rotation: 39 + 30 + slider.value
                    Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
                }

                Slider {
                    id: slider
                    y: -58
                    anchors.top: speed1.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 250
                    anchors.horizontalCenterOffset: -55
                    minimumValue: 0
                    maximumValue: 300
                    value: Cambien.q_pressure*12
                    visible: false
                }
            }
        }

        ChartView {
            id: spline
            x: 263
            y: 22
            width: 750
            height: 450

            ValueAxis {
                    id: axisY1
                    min: 0
                    max: 70
                    gridVisible: false
                    color: "black"
                    labelsColor: "black"
                    labelFormat: "%.0f"
                }

           ValueAxis {
                id: axisX
                min: 0
                max: 50
                gridVisible: false
                color: "black"
                labelsColor: "black"
                labelFormat: "%.0f"
                tickCount: 5
            }
            LineSeries {
                id: lineSeries1
                name: "Áp suất đo"
                color: "red"
                axisX: axisX
                axisY: axisY1
            }
            LineSeries {
                id: lineSeries2
                name: "Áp suất tham chiếu"
                color: "blue"
                axisX: axisX
                axisY: axisY1
            }

        }

        Text {
            id: element1
            x: 525
            y: 8
            width: 123
            height: 24
            text: qsTr("Biểu Đồ Áp suất")
            font.bold: true
            font.family: "Ubuntu"
            font.pixelSize: 18
        }

        Text {
            id: element2
            x: 267
            y: 45
            text: qsTr("Áp Suất\n (bar)")
            z: 0
            font.pixelSize: 14
        }

        Text {
            id: element4
            x: 28
            y: 281
            text: qsTr("Áp Suất Thử")
            font.pixelSize: 18
        }

        Label {
            id: label
            x: 118
            y: 173
            color: "#3465a4"
            text: qsTr("bar")
        }

        Text {
            id: element5
            x: 109
            y: 221
            color: "#ef2929"
            text: Cambien.q_pressure.toFixed(1)
            font.bold: true
            font.pixelSize: 20
        }

        Label {
            id: label1
            x: 215
            y: 283
            color: "#3465a4"
            text: qsTr("bar")
        }

        Text {
            id: element6
            x: 28
            y: 332
            text: qsTr("Thời Gian Thử")
            font.pixelSize: 18
        }

        Button{
            id: denBatDau
            x: 28
            y: 380
            width: 214
            height: 60
            property bool press: false
            Image {
                anchors.rightMargin: -2
                anchors.bottomMargin: 1
                anchors.leftMargin: 2
                anchors.topMargin: -1
                source: KiemDinhTDObj.q_led_start ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                anchors.fill: parent
            }
            onClicked: {
                press= !press
                KiemDinhTDObj.setLedStart(!KiemDinhTDObj.q_led_start);
                if (!KiemDinhTDObj.isRunning()){
                } else {
                    KiemDinhTDObj.stop();
                }
            }
        }

        Text {
            id: element3
            x: 892
            y: 448
            text: qsTr("Thời gian  (s)")
            font.pixelSize: 14
        }

        Label {
            id: label2
            x: 215
            y: 332
            width: 14
            height: 17
            color: "#3465a4"
            text: qsTr("s")
        }

        Text {
            id: txt_count
            x: 162
            y: 328
            text: KiemDinhTDObj.q_counter_test
            font.bold: true
            font.pixelSize: 24
        }

        Text {
            id: txt_pRef
            x: 162
            y: 272
            text: KiemDinhTDObj.q_pReference
            font.pixelSize: 24
            font.bold: true
        }

        Text {
            id: element7
            x: 23
            y: 457
            text: qsTr("Trạng Thái: ")
            font.pixelSize: 12
        }

        Text {
            id: txt_state
            x: 104
            y: 453
            text: KiemDinhTDObj.q_state_machine
            font.pixelSize: 20
        }
    }

}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
