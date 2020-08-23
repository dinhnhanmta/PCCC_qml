import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("HIỆU CHỈNH THAM SỐ HỆ THỐNG")

    Rectangle{
        anchors.fill: parent
        color: "lightblue"
        Row {
            anchors.centerIn: parent
            width: parent - 60
            height: parent.height
            spacing: 60

            Column {
                y: 60
                height: parent.height - 120
                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("HỆ SỐ HIỆU CHỈNH ÁP SUẤT")
                    }
                    Input {
                    }
                }

                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("TỐC ĐỘ NHỎ NHẤT")
                    }
                    Input {
                    }
                }
            }


            Column{
                y: 60
                height: parent.height - 120
                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("TẦN SỐ LỚN NHẤT")
                    }
                    Input {
                    }
                }

                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("NGƯỠNG ÁP SUẤT LẦN 1")
                    }
                    Input {
                    }
                }

                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("THỜI GIAN GIỮ")
                    }
                    Input {
                    }
                }
            }

            Column{
                y: 60
                height: parent.height - 120
                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("NGƯỠNG ÁP SUẤT LẦN 2")
                    }
                    Input {
                    }
                }

                Column {
                    height: parent.height/3
                    Text {
                        text: qsTr("TỐC ĐỘ GIA TĂNG ÁP SUẤT")
                    }
                    Input {
                    }
                }
            }
        }
    }
}
