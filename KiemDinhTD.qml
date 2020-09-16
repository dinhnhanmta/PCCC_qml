import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
import QtQuick.Extras 1.4
import QtCharts 2.3


Item {
    anchors.fill: parent
    visible: true

    //    Timer cho cap nhat gia tri led
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.checkState()
        }
    }
    // Timer cap nhat state machine
    Timer {
        interval: 100; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.updateState()
        }
    }

    //    Timer cap nhat ngoai vi
    Timer {
        interval: 100; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.updateLogic()
        }
    }

    //    Timer cap nhat Chart
    property var x_var: 0
    Constants {
        id: constants
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered:{
            x_var ++;
            if(lineSeries1.count > 300) lineSeries1.remove(0);
            lineSeries1.append(x_var, Cambien.q_pressure);

            if(lineSeries2.count > 300) lineSeries2.remove(0);
            lineSeries2.append(x_var, KiemDinhTDObj.q_pReference);

            axisX.min = lineSeries2.at(0).x
            axisX.max = lineSeries2.at(lineSeries1.count-1).x
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "#ddf6fe"
        Component.onCompleted: screenLabel.text = qsTr("KIỂM ĐỊNH TỰ ĐỘNG")

        Row {
            spacing: 24
            children: [
                Column {
                    id: col2
                    anchors.topMargin: 50
                    width: 250
                    spacing: 17
                    children: [
                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2.5
                                    font.pointSize: 16
                                    height: 35
                                    text: qsTr("  Loại vòi ")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                ComboBox {
                                    id: cbListLoaiVoi
                                    width: col2.width/1.5
                                    height: 35
                                    model: ListModel {
                                        id: loaiVoiModel
                                        ListElement {
                                            text: "VP 51"
                                            working: 16
                                            test: 20
                                        }
                                        ListElement {
                                            text: "VP 66"
                                            working: 16
                                            test: 20
                                        }
                                        ListElement {
                                            text: "VP 77"
                                            working: 16
                                            test: 20
                                        }
                                        ListElement {
                                            text: "VP 110"
                                            working: 14
                                            test: 18
                                        }
                                        ListElement {
                                            text: "VP 150"
                                            working: 12
                                            test: 14
                                        }
                                    }

                                    onCurrentIndexChanged: {
                                        apSuatLamViec.text = loaiVoiModel.get(cbListLoaiVoi.currentIndex).working
                                        apSuatThu.text = loaiVoiModel.get(cbListLoaiVoi.currentIndex).test
                                    }
                                }
                            ]
                        },

                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    font.pointSize: 16
                                    text: qsTr("  P ")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Text {
                                    width: col2.width/4
                                    id: apSuat
                                    text: Cambien.q_pressure.toFixed(1)
                                    font.bold: true
                                    horizontalAlignment: Text.AlignRight
                                    font.pointSize: 16
                                    color: "red"
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr("bar ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },
                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    font.pointSize: 16
                                    text: qsTr("  Pref")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Text {
                                    width: col2.width/4
                                    text: KiemDinhTDObj.q_pReference
                                    horizontalAlignment: Text.AlignRight
                                    font.bold: true
                                    font.pointSize: 16
                                    color: "#2a00ff"
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr("bar ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },
                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    font.pointSize: 16
                                    text: qsTr("  P làm việc ")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Input {
                                    id: apSuatLamViec
                                    width: col2.width/4
                                    height: 35
                                    text: "16"
                                    pointSize: 16
                                    Text {
                                        anchors.centerIn: parent
                                        font.pointSize: 10
                                    }
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr("bar ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },
                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    font.pointSize: 16
                                    text: qsTr("  P thử ")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Input {
                                    id: apSuatThu
                                    width: col2.width/4
                                    height: 35
                                    text: "20"
                                    pointSize: 15
                                    Text {
                                        anchors.centerIn: parent
                                        font.pointSize: 10
                                    }
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr("bar ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },


                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    font.pointSize: 16
                                    text: qsTr("  F biến tần")
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Text {
                                    width: col2.width/4
                                    text: (Bientan.q_real_frequency/100).toFixed(1)
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pointSize: 16
                                    color: "blue"
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr("Hz ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },
                        Row {
                            spacing: 10
                            height: 35
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    height: 35
                                    font.pointSize: 16
                                    text: qsTr("  Thời gian")
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: false
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Text {
                                    width: col2.width/4
                                    text: KiemDinhTDObj.q_counter_test
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pointSize: 16
                                    color: "blue"
                                },
                                Text {
                                    width: col2.width/4
                                    font.pointSize: 16
                                    text: qsTr(" s  ")
                                    horizontalAlignment: Text.AlignRight
                                }
                            ]
                        },
                        Row {
                            spacing: 10
                            height: 55
                            width: col2.width
                            children: [
                                Text {
                                    width: col2.width/2
                                    height: 60
                                    font.pointSize: 16
                                    text: qsTr("  Bắt đầu: ")
                                    font.bold: false
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                },
                                Button{
                                    id: denBatDau
                                    width: col2.width/2
                                    height: 60
                                    property bool press: false
                                    Image {
                                        anchors.rightMargin: -2
                                        anchors.bottomMargin: 1
                                        anchors.leftMargin: 2
                                        anchors.topMargin: -1
                                        source: Relay.q_start_led_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                                        anchors.fill: parent
                                    }
                                    onClicked: {
                                        press= !press
//                                        Relay.writeStartLed(!Relay.q_start_led_state)
//                                        if (!KiemDinhTDObj.isRunning()){
//                                            KiemDinhTDObj.setPWorking(apSuatLamViec.text);
//                                            KiemDinhTDObj.setPTried(apSuatThu.text);
//                                        } else {
//                                            KiemDinhTDObj.stop();
//                                        }
                                    }
                                }
                            ]
                        }

                    ]
                },

                ChartView {
                    id: spline
                    x: 340
                    y: 16
                    width: 700
                    height: 450
                    antialiasing: true
                    ValueAxis {
                            id: axisY1
                            min: 0
                            max: 25
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
                        name: "Áp suất vòi"
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

                    MouseArea{
                       anchors.fill: parent
                       onDoubleClicked: chartView.zoomReset();
                   }

                   PinchArea{
                       id: pa
                       anchors.fill: parent
                       onPinchUpdated: {
                           chartView.zoomReset();
                           var center_x = pinch.center.x
                           var center_y = pinch.center.y
                           var width_zoom = height/pinch.scale;
                           var height_zoom = width/pinch.scale;
                           var r = Qt.rect(center_x-width_zoom/2, center_y - height_zoom/2, width_zoom, height_zoom)
                           chartView.zoomIn(r)
                       }

                   }
                }

            ]

        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/























































































































































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
