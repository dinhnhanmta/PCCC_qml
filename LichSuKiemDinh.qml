import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import QtCharts 2.3
Item {
     property int sizeDeviceText: 23
    anchors.fill: parent
    property var x_var: 0
    Component.onCompleted: {
        screenLabel.text = qsTr("LỊCH SỬ THỬ NGHIỆM")
        LichSu.readRecords()
        var i = 0
        for (i = 0; i < LichSu.q_historyTime.length;i++)
        {
        historyModel.append({id:LichSu.q_historyID[i],historydata:LichSu.q_historyData[i],time:LichSu.q_historyTime[i]})
        }
    }
    Rectangle{

        anchors.fill: parent
        color: "lightblue"
        Text {
            id: deviceInfor
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Code:")
            font.pixelSize: sizeDeviceText
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 10
                text: LoginTB.deviceModelCode()
                font.bold: true
                font.pixelSize: sizeDeviceText
            }

            Text {
                text: LoginTB.deviceModelName()
                anchors.right: parent.left
                anchors.rightMargin: 10
                font.bold: true
                font.pixelSize: sizeDeviceText
                Text {
                    id: thietbiText
                    anchors.right: parent.left
                    anchors.rightMargin: 10
                    text: qsTr("Thiết bị:")
                    font.pixelSize: sizeDeviceText
                    }
                }
        }
        ListModel {
             id: historyModel
        }
        ListView {
                id: list
                anchors.top: deviceInfor.bottom
                anchors.topMargin: 10
                width: 300; height: 400
                model: historyModel
                delegate: listviewDele
                highlight: highlight
                highlightFollowsCurrentItem: true
                focus: true
                ScrollBar.vertical: ScrollBar {}

          }
        Component{
            id: listviewDele
        Item {
                        width: list.width;
                        height: 40;

                        Rectangle {
                            id: separation;
                            color: "black";
                            height: 2;
                            visible: true;
                            anchors {
                                top: parent.top;
                                left: parent.left;
                                right: parent.right;
                            }
                        }

                        Item {
                            anchors {
                                top: separation.bottom;
                                left: parent.left;
                                right: parent.right;
                                bottom: parent.bottom;
                            }


                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    x_var = 0
                                    lineSeries1.clear()
                                    list.currentIndex = index
                                    console.log(time)
                                    var data = historydata
                                    data = data.substring(1, data.length-1);
                                    data = data.split(",")
                                    var i
                                    for (i=0;i<data.length;i++)
                                    {
                                        x_var ++;
                                        lineSeries1.append(x_var,data[i])
                                    }
                                }
                            }
                            Text {
                                text: time;
                                color: "black";
                                anchors {
                                    verticalCenter: parent.verticalCenter;
                                    horizontalCenter: parent.horizontalCenter
                                }
                                font {
                                    pointSize: 20;
                                }
                            }
                        }
                    }
        }
        Component {
            id: highlight
            Rectangle {
                width: 180; height: 40
                color: "lightgreen"; radius: 5
                y: list.currentItem.y
                Behavior on y {
                    SpringAnimation {
                        spring: 3
                        damping: 0.2
                    }
                }
            }
        }

        ChartView {
            id: spline
            x: 340
            anchors.top: deviceInfor.bottom
            anchors.topMargin: 10
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


}
}
