import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
Item {
    anchors.fill: parent
    //property alias mouseArea: mouseArea
    visible: true
    property var pRefer: []
    property var pHientai: []
    property var xValue: []
    property int time: 0

    Rectangle{
        anchors.fill: parent
        color: "#ddf6fe"
        Component.onCompleted: screenLabel.text = qsTr("KIỂM ĐỊNH TỰ ĐỘNG")

        Chart{
            x: 272
            y: 0
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
                                 data : pHientai
                             },
                             {
                                 fillColor : "rgba(151,187,205,0.5)",
                                 strokeColor : "rgba(151,187,205,1)",
                                 pointColor : "rgba(151,187,205,1)",
                                 pointStrokeColor : "#fff",
                                 data :  pRefer
                             }
                         ]

                     });

           }

        }

        Timer{
            id:timer_chart
            interval: 1000
            repeat: true
            running: false
            triggeredOnStart: true
            onTriggered:{

                var apsuatLV = apSuatLamViec.text.replace(" MPa","");
                var apsuatT = apSuatThu.text.replace(" MPa","");
                var time_pre_apsuatlv = apsuatLV/0.5*60
                var time_apsualv = time_pre_apsuatlv + 180
                var time_pre_apsuatthu = time_apsualv +(apsuatT-apsuatLV)/0.5*60
                if (time%10 === 0) xValue.push(time)
                else xValue.push("")
                if (time<time_pre_apsuatlv) pRefer.push(0.5/60*time.toFixed(2))
                if (time >= time_pre_apsuatlv && time<=time_apsualv)  pRefer.push(apsuatLV)
                if ((time >time_apsualv) && (time<=time_pre_apsuatthu))  pRefer.push(0.5/60*time -1.5)
                if (time >time_pre_apsuatthu) pRefer.push(apsuatT)
                if(time == time_pre_apsuatthu+120) timer_chart.stop()
                time +=1;
                pHientai.push(Cambien.q_pressure)
                chartID.requestPaint();

            }
        }


        PrimaryButton {
            x: 55
            y: 391
            width: 167
            height: 47
            text: "BẮT ĐẦU KIỂM ĐỊNH"
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    timer_chart.restart();
                    pRefer = []
                    pHientai =  []
                    xValue = []
                    time = 0
                }
            }
        }

        Text {
            x: 19
            y: 171
            text: qsTr("VAN CẤP NƯỚC")
        }

        Rectangle {

            x: 46
            y: 195
            width: 60
            height: 37
            Image {
                id: image
                source: Relay.q_input_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                anchors.fill: parent
            }

        }

        Text {
            x: 171
            y: 171
            text: qsTr("VAN XẢ NƯỚC")
        }

        Rectangle {

            x: 184
            y: 195
            width: 60
            height: 37
            Image {
                source: Relay.q_ouput_vavle_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                anchors.fill: parent
            }

        }
        Text {
            x: 70
            y: 107
            text: qsTr("TỐC ĐỘ ĐỘNG CƠ")
        }

        Input {

            x: 76
            y: 131
            width: 103
            height: 34
            text: "123"
            pointSize: 18
            disabled: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }


        Text {
            id: textPressureDial
            x: 105
            y: -60
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
                anchors.verticalCenterOffset: -174
                anchors.horizontalCenterOffset: -204
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
                value: Cambien.q_pressure
                visible: false
            }
        }
        Dropdown {
            id: dropdownListLoaiVoi
            x: 85
            y: 263
            width: 127
            height: 35
            dropdownTextColor: "black"
            dropdownItemHeight: 30
            model: listLoaiVoi
            z: 7
            onTextChanged: {
                var data=Object.values(listLoaiVoi)
                var i,index;
                for (i = 0; i < data.length; i++) {
                 if(data[i].item === dropdownListLoaiVoi.text) index = i;
                }
                apSuatLamViec.text = listApSuatLamViec[index].item+" MPa"
                apSuatThu.text = listApSuatThu[index].item +" MPa"
                pRefer = []
                pHientai =  []
                xValue = []
                time = 0
                timer_chart.stop()
                chartID.requestPaint();

            }
        }
        Rectangle
        {
            x: 46
            y: 333
            height: dropdownListLoaiVoi.height
            width: dropdownListLoaiVoi.width/2
            color: dropdownListLoaiVoi.color
            Text {
                id: apSuatLamViec
                anchors.centerIn: parent
                text: listApSuatLamViec[0].item+" MPa"
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: -3
            }
        }

        Rectangle {
            x: 195
            y: 333
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
            y: 239
            text: qsTr("LOẠI VÒI")
        }

        Text {
            x: 19
            y: 309
            text: qsTr("ÁP SUÂT LÀM VIỆC")
        }

        Text {
            x: 175
            y: 309
            text: qsTr("ÁP SUÂT THỬ")
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
