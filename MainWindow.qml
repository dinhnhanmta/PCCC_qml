import QtQuick 2.0
import QtCharts 2.3
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
Item {
    id: window
    width: 1024
    height: 600
    visible: true

    Component.onCompleted: {
        Modbus.startConnection();
        Cambien.openSerialPort();
    }

    Rectangle{
        anchors.fill: parent
        color: "lightblue"

        Text {
            id: screenLabel
            y: 30
            height: 40
            text: qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
        }

        StackView {
            id: stack2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: screenLabel.bottom
            anchors.bottom: footer.top
            anchors.topMargin: 20

            Row {
                width: parent.width - 20
                height: parent.height
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.top: parent.top
                    width: parent.width/2
                    anchors.topMargin: parent.height/6 - 32
                    spacing: parent.height/3 - 64

                    PrimaryButton{
                        id: thuNghiem
                        text: "TIẾN HÀNH THỬ NGHIỆM"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            source: "qrc:/Icon/play2.png"
                            anchors.left:  parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("DangNhapTB.qml")
                        }
                    }

                    PrimaryButton {
                        id: capNhat
                        text: "CẬP NHẬT THÔNG SỐ\n         KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            source: "qrc:/Icon/update2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem5
                        text: "CÀI ĐẶT HỆ THỐNG"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            source: "qrc:/Icon/setting2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("CaiDatThongSo.qml")
                        }
                    }
                }

                Column {
                    anchors.top: parent.top
                    width: parent.width/2
                    anchors.topMargin: parent.height/6 - 32
                    spacing: parent.height/3 - 64

                    PrimaryButton {
                        id: thuNghiemBangTay
                        text: "THỬ NGHIỆM BẰNG TAY"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            source: "qrc:/Icon/hand2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("ThuNghiemBangTay.qml")
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem2
                        text: "LỊCH SỬ KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            source: "qrc:/Icon/history2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("LichSuKiemDinh.qml")
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem4
                        text: "HIỆU CHỈNH THÔNG SỐ"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            source: "qrc:/Icon/adjust2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: stack2.push("HieuChinhThamSo.qml")
                        }
                    }
                }
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
                    anchors.fill: parent
                    onClicked: {
                        if (!stack2.empty) stack2.clear()
                    }
                }
            }
        }
    }
}
