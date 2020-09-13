import QtQuick 2.12
import "FlatUI-Controls-QML-master"
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.2
import IVIControls 1.0
Item {
    anchors.fill: parent
    visible: true

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.checkState()
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered:{
            KiemDinhTDObj.updateLogic()
        }
    }


    Constants {
        id: constants
    }

    Connections {
        target: KiemDinhTDObj
        onXValueChange: {
            chartID.requestPaint();
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
                    width: 300
                    spacing: 10
                    children: [
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 11
                            text: qsTr("ÁP SUẤT")
                        },
                        Rectangle {
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 35
                            color: dropdownListLoaiVoi.color
                            Text {
                                id: apSuat
                                anchors.centerIn: parent
                                text: Cambien.q_val_pot.toFixed(1)
                                font.pointSize: 10
                            }
                        },
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 11
                            text: qsTr("LOẠI VÒI")
                        },
                        Dropdown {
                            id: dropdownListLoaiVoi
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 35
                            dropdownTextColor: "black"
                            dropdownItemHeight: 30
                            z: 7
                            onTextChanged: {
                            }
                        },
                        Text {
                            text: qsTr("ÁP SUẤT LÀM VIỆC")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 11
                        },
                        Input {
                            id: apSuatLamViec
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 35
                            Text {
                                anchors.centerIn: parent
                                font.pointSize: 10
                            }
                        },
                        Text {
                            text: qsTr("ÁP SUẤT THỬ")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 11
                        },
                        Input {
                            id: apSuatThu
                            width: parent.width - 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 35
                            Text {
                                anchors.centerIn: parent
                                font.pointSize: 10
                            }
                        },
                        Text {
                            text: qsTr("ĐÈN BẮT ĐẦU")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 11
                        },
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 120
                            height: 35
                            Image {
                                source: Relay.q_start_led_state ? "./Icon/switch-on.jpg" : "./Icon/switch-off.jpg"
                                anchors.fill: parent
                            }
                        },
                        PrimaryButton {
                            id: btnStart
                            width: 200
                            height: 47
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "BẮT ĐẦU"
                            MouseArea{
                                anchors.fill: parent
                                onClicked:
                                {
                                    if (!KiemDinhTDObj.isRunning()){
                                        btnStart.text = "DỪNG";
                                        btnStart.color = constants.carrot;
                                        KiemDinhTDObj.setPWorking(apSuatLamViec.text);
                                        KiemDinhTDObj.setPTried(apSuatThu.text);
                                        KiemDinhTDObj.start();
                                    } else {
                                        btnStart.text = "BẮT ĐẦU";
                                        btnStart.color = constants.turquoise;
                                        KiemDinhTDObj.stop();
                                    }
                                }
                            }
                        }
                    ]
                },
                Chart{
                    id: chartID
                    width: 700
                    height: 450
                    onPaint: {
                        line({
                         labels : KiemDinhTDObj.xValue,
                         datasets : [
                             {
                                 fillColor : "rgba(220,220,220,0)",
                                 strokeColor : "rgba(220,220,220,1)",
                                 pointColor : "rgba(220,220,220,1)",
                                 pointStrokeColor : "#fff",
                                 data : KiemDinhTDObj.pCurrent
                             },
                             {
                                 fillColor : "rgba(151,187,205,0)",
                                 strokeColor : "rgba(151,187,205,1)",
                                 pointColor : "rgba(151,187,205,1)",
                                 pointStrokeColor : "#fff",
                                 data :  KiemDinhTDObj.pRefer
                             }
                         ]
                     });
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
