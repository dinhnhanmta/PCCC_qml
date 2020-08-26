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
            //<<<<<<< HEAD
            //            y: 34
            //            width: 448
            //            height: 39
            //            text: qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
            //            font.bold: true
            //            anchors.horizontalCenterOffset: -39
            //=======
            id: screenLabel
            y: 18
            height: 40
            color: "#0335b8"
            text: qsTr("THIẾT BỊ KIỂM ĐỊNH VÒI CHỮA CHÁY")
            font.capitalization: Font.AllUppercase
            font.weight: Font.ExtraBold
            style: Text.Outline
            anchors.horizontalCenterOffset: 13
            font.bold: true
            font.family: "Tahoma"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 27
        }

        //<<<<<<< HEAD
        //        PrimaryButton{
        //            id: thuNghiem
        //            x: 137
        //            y: 130
        //            width: 350
        //            height: 100
        //            radius: 1
        //            z: 1
        //            text: "TIẾN HÀNH THỬ NGHIỆM"
        //            anchors.horizontalCenterOffset: -221
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            Image {
        //                width: 100
        //                height: 100
        //                source: "qrc:/Icon/play2.png"
        //                anchors.left:  parent.left
        //                scale: 0.7
        //            }
        //            MouseArea {
        //                anchors.fill: parent
        //                onClicked: stack.push("DangNhapTB.qml")
        //            }
        //        }

        //        PrimaryButton {
        //            id: thuNghiemBangTay
        //            x: 127
        //            y: 130
        //            width: 350
        //            height: 101
        //            text: "THỬ NGHIỆM BẰNG TAY"
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 1
        //            anchors.horizontalCenterOffset: 247
        //            Image {
        //                y: 1
        //                width: 100
        //                height: 100
        //                anchors.leftMargin: -7
        //                source: "qrc:/Icon/hand2.png"
        //                anchors.left: parent.left
        //                 scale: 0.7
        //            }
        //            MouseArea {
        //                height: 100
        //                anchors.rightMargin: 0
        //                anchors.bottomMargin: 2
        //                anchors.leftMargin: 0
        //                anchors.topMargin: -2
        //                anchors.fill: parent
        //                onClicked: stack.push("ThuNghiemBangTay.qml")
        //            }
        //        }

        //        PrimaryButton {
        //            id: thuNghiem2
        //            x: 139
        //            y: 279
        //            width: 350
        //            height: 100
        //            radius: 1
        //            text: "LỊCH SỬ KIỂM ĐỊNH"
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 1
        //            anchors.horizontalCenterOffset: 247

        //            Image {
        //                y: 6
        //                width: 100
        //                height: 100
        //                anchors.leftMargin: -2
        //                source: "qrc:/Icon/history2.png"
        //                anchors.left: parent.left
        //                 scale: 0.7
        //            }
        //            MouseArea {
        //                anchors.fill: parent
        //                onClicked: stack.push("LichSuKiemDinh.qml")
        //            }
        //        }

        //        PrimaryButton {
        //            id: capNhat
        //            x: 146
        //            y: 279
        //            height: 100
        //            radius: 1
        //            text: "CẬP NHẬT THÔNG SỐ\n         KIỂM ĐỊNH"
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 1
        //            anchors.horizontalCenterOffset: -221
        //            Image {
        //                y: 0
        //                width: 100
        //                height: 100
        //                anchors.leftMargin: -6
        //                source: "qrc:/Icon/update2.png"
        //                 anchors.left: parent.left
        //                 scale: 0.7
        //            }
        //        }

        //        PrimaryButton {
        //            id: thuNghiem4
        //            x: 137
        //            y: 420
        //            height: 100
        //            radius: 1
        //            text: "HIỆU CHỈNH THÔNG SỐ"
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 1
        //            anchors.horizontalCenterOffset: 247

        //            Image {
        //                width: 100
        //                height: 100
        //                source: "qrc:/Icon/adjust2.png"
        //                 anchors.left: parent.left
        //                 scale: 0.7
        //            }
        //            MouseArea {
        //                anchors.fill: parent
        //                onClicked: stack.push("HieuChinhThamSo.qml")
        //            }
        //        }

        //        PrimaryButton {
        //            id: thuNghiem5
        //            x: 132
        //            y: 420
        //            height: 100
        //            radius: 1
        //            text: "CÀI ĐẶT HỆ THỐNG"
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            z: 1
        //            anchors.horizontalCenterOffset: -221

        //            Image {
        //                y: 6
        //                width: 100
        //                height: 100
        //                anchors.leftMargin: 1
        //                source: "qrc:/Icon/setting2.png"
        //                 anchors.left: parent.left
        //                 scale: 0.7
        //            }
        //            MouseArea {
        //            anchors.fill: parent
        //            onClicked: stack.push("CaiDatThongSo.qml")
        //=======
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
                    anchors.topMargin: 30
                    spacing: parent.height/3 - 120

                    PrimaryButton{
                        id: thuNghiem
                        height: 100
                        radius: 1
                        text: "              TIẾN HÀNH THỬ NGHIỆM"
                        border.color: "#4dade9"
                        activeFocusOnTab: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            width: 100
                            height: 100
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
                        height: 100
                        radius: 1
                        text: "                 CẬP NHẬT THÔNG SỐ\n                        KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/update2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem5
                        height: 100
                        radius: 1
                        text: "         CÀI ĐẶT HỆ THỐNG"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            width: 100
                            height: 100
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
                    anchors.topMargin: 30
                    spacing: parent.height/3 - 120

                    PrimaryButton {
                        id: thuNghiemBangTay
                        height: 100
                        radius: 1
                        text: "                THỬ NGHIỆM BẰNG TAY"
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/hand2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            height: 64
                            anchors.fill: parent
                            onClicked: stack2.push("ThuNghiemBangTay.qml")
                        }
                    }

                    PrimaryButton {
                        id: thuNghiem2
                        y: 175
                        height: 100
                        radius: 1
                        text: "LỊCH SỬ KIỂM ĐỊNH"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            width: 100
                            height: 100
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
                        height: 100
                        radius: 1
                        text: "         HIỆU CHỈNH THÔNG SỐ"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            width: 100
                            height: 100
                            source: "qrc:/Icon/adjust2.png"
                            anchors.left: parent.left
                            scale: 0.7
                        }
                        MouseArea {
                            height: 100
                            anchors.fill: parent
                            onClicked: stack2.push("HieuChinhThamSo2.qml")
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
            y: 551
            anchors.left: parent.left

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 50
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            DangerButton {
                id: dangerButton1
                y: 0
                text: ""
                color: "palegoldenrod"
                radius: 1
                width: 100
                height: 50
                anchors.right: parent.right
                anchors.bottom:  parent.bottom
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.top: parent.top
                    source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                    scale: 0.7
                }
            }


            DangerButton {
                id: dangerButton
                width: 100
                height: 50
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 1
                color: "#eee8e7"
                anchors.bottom:  parent.bottom
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
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

        Text {
            id: element
            x: 298
            y: 566
            text: qsTr("Kết nối cảm biến")
            font.pixelSize: 15
        }

        Text {
            id: element1
            x: 798
            y: 566
            text: qsTr("Kết nối ngoại vi")
            font.pixelSize: 15
        }
    }
}





/*##^## Designer {
    D{i:28;anchors_height:50;anchors_width:100}
}
 ##^##*/
