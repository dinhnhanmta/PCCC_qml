import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
Item {
    width: 1024
    height: 800
    visible: true
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
    }
    Text {
        y: 80
        text: qsTr("HIỆU CHỈNH THAM SỐ HỆ THỐNG")
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 26
        font.bold: true
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
            text: qsTr("     Trạng thái \n     kết nối")
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
        onClicked: stack.pop("HieuChinhThamSo.qml")
        }

    }
    property int space: 20
    GridLayout {
        x: 146
        y: 232
        columns: 3
        rows: 3
        rowSpacing: 100
        columnSpacing: 100

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("HỆ SỐ HIỆU CHỈNH ÁP SUẤT")
            }
            Input {
            }
        }

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("TỐC ĐỘ NHỎ NHẤT")
            }
            Input {
            }
        }

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("TẦN SỐ LỚN NHẤT")
            }
            Input {
            }
        }

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("NGƯỠNG ÁP SUẤT LẦN 1")
            }
            Input {
            }
        }

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("NGƯỠNG ÁP SUẤT LẦN 2")
            }
            Input {
            }
        }

        ColumnLayout {
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("TỐC ĐỘ GIA TĂNG ÁP SUẤT")
            }
            Input {
            }
        }

        ColumnLayout {
            Layout.column:   1
            Layout.row: 2
            x: 56
            y: 70
            spacing: space
            Text {
                text: qsTr("THỜI GIAN GIỮ")
            }
            Input {
            }
        }

    }

    scale: 0.7
}
