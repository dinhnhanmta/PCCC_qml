import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
Item {
    width: 1024
    height: 600
    property alias mouseArea: mouseArea
    visible: true
    property int test : 45;
    property string thu : "??";
    property var pThu: []
    property var pLamviec: []
    property var pHientai: []
    property var xValue: []
    property int time: 0
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
        Text {
            y: 8
            text: qsTr("QUY TRÌNH KIỂM ĐỊNH TỰ ĐỘNG")
            anchors.horizontalCenterOffset: 1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }
        Chart{
            x: 280
            y: 55
            id :chartID
            width: 700
            height: 450

            onPaint: {

                line({
                         labels : xValue,
                         datasets : [
                             {
                                 fillColor : "rgba(220,220,220,0.5)",
                                 strokeColor : "rgba(220,220,220,1)",
                                 pointColor : "rgba(220,220,220,1)",
                                 pointStrokeColor : "#fff",
                                 data : pThu
                             },
                             {
                                 fillColor : "rgba(151,187,205,0.5)",
                                 strokeColor : "rgba(151,187,205,1)",
                                 pointColor : "rgba(151,187,205,1)",
                                 pointStrokeColor : "#fff",
                                 data : [10,3,4,1,0]
                             }
                         ],
                     });


           }

        }

        Timer{
            id:t
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered:{
                //var d = new Date()
                //thu = d.getSeconds() + ":" + d. getMilliseconds()
                time +=1;
                xValue.push(time)
                pThu.push(apSuatThu.text.replace(" MPa",""))
                chartID.requestPaint();
            }
        }

            Image {

            source: "qrc:/Icon/account.png"
            scale: 0.8
            anchors.right: parent.right
            anchors.top: parent.top
        }

        Row {
            id: footer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 64
            DangerButton {
                text: "Modbus"
                color: "palegoldenrod"
                width: 200
                anchors.right: parent.right
                anchors.bottom:  parent.bottom
                Image {
                    source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                    anchors.right: parent.right
                    scale: 0.7
                }
            }


            DangerButton {
                text: "Cảm biến"
                color: "palegoldenrod"
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    source: Cambien.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                    anchors.right: parent.right
                    scale: 0.7
                }
            }

            DangerButton {
                text: "Home"
                color: "palegoldenrod"
                width: 200
                anchors.left: parent.left
                anchors.bottom:  parent.bottom
                Image {
                     source: "qrc:/Icon/home2.png"
                     anchors.left: parent.left
                     scale: 0.7
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        stack.pop("DangNhapTB.qml")
                    }
                }
            }
        }

        PrimaryButton {

            x: 59
            y: 473
            width: 167
            height: 47
//=======
//            x: 616
//            y: 447
//            width: 206
//            height: 93
//>>>>>>> refs/remotes/origin/issue_4
            text: "BẮT ĐẦU KIỂM ĐỊNH"
        }

        Text {
            x: 17
            y: 269
            text: qsTr("VAN CẤP NƯỚC")
        }

        Rectangle {

            x: 42
            y: 299
            width: 60
            height: 37
//=======
//            x: 215
//            y: 481
//            width: 108
//            height: 59
//>>>>>>> refs/remotes/origin/issue_4
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }

        }

        Text {
            x: 155
            y: 269
            text: qsTr("VAN XẢ NƯỚC")
        }

        Rectangle {

            x: 176
            y: 299
            width: 60
            height: 37
//=======
//            x: 441
//            y: 481
//            width: 108
//            height: 59
//>>>>>>> refs/remotes/origin/issue_4
            Image {
                source: "qrc:/Icon/switch-off.jpg"
                anchors.fill: parent
            }

        }

        Text {
            x: 79
            y: 192
            text: qsTr("TỐC ĐỘ ĐỘNG CƠ")
        }

        Input {

            x: 91
            y: 223
            width: 103
            height: 34
            text: "123"
            pointSize: 18
//=======
//            x: 117
//            y: 351
//            width: 164
//            height: 65
//            text: "100"
//            pointSize: 26
//>>>>>>> refs/remotes/origin/issue_4
            disabled: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }


        Text {
            id: textPressureDial
            x: 101
            y: 31
            text: qsTr("ÁP SUẤT")
        }
        DialItem {
            scale: 0.7
            x: 100
            id: speed
            anchors.top: textPressureDial.bottom
            anchors.topMargin: -17
            anchors.horizontalCenter: textPressureDial.horizontalCenter
            width: 200
            height: width
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
                rotation: 39 + 30 + pressureValue.value*3
                Behavior on rotation { SpringAnimation { spring: 5; damping: 0.5 } }
            }
            Slider {
                id: pressureValue
                anchors.top: speed.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 300
                minimumValue: 0
                maximumValue: 300
                value: 80
                visible: false
            }
        }
        Dropdown {
            id: dropdownListLoaiVoi
            x: 79
            y: 359
            width: 127
            height: 35
            dropdownTextColor: "black"
            model: listLoaiVoi
            //Text { text: modelData }
            z: 2
            onTextChanged: {
                var data=Object.values(listLoaiVoi)
                var i,index;
                for (i = 0; i < data.length; i++) {
                 if(data[i].item === dropdownListLoaiVoi.text) index = i;
                }
                apSuatLamViec.text = listApSuatLamViec[index].item+" MPa"
                apSuatThu.text = listApSuatThu[index].item +" MPa"
            }
        }
        Rectangle
        {
            x: 48
            y: 424
            height: dropdownListLoaiVoi.height
            width: dropdownListLoaiVoi.width/2
            color: dropdownListLoaiVoi.color
            Text {
                id: apSuatLamViec
                anchors.centerIn: parent
                text: listApSuatLamViec[0].item+" MPa"
            }
        }

        Rectangle {
            x: 176
            y: 424
            width: dropdownListLoaiVoi.width/2
            height: dropdownListLoaiVoi.height
            color: dropdownListLoaiVoi.color
            Text {
                id: apSuatThu
                anchors.centerIn: parent
                text: listApSuatThu[0].item +" MPa"
            }
        }

        Text {
            x: 112
            y: 335
            text: qsTr("LOẠI VÒI")
        }

        Text {
            x: 8
            y: 400
            text: qsTr("ÁP SUÂT LÀM VIỆC")
        }

        Text {
            x: 163
            y: 400
            text: qsTr("ÁP SUÂT THỬ")
        }

    }
}
