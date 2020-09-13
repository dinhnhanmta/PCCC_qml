import QtQuick 2.0
import "FlatUI-Controls-QML-master"
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.1

Item {
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("HIỆU CHỈNH THÔNG SỐ")

    MessageDialog {
        id: messageDialog
        title: "Lỗi"
        icon: StandardIcon.Critical
        text: "Vui lòng nhập đầy đủ thông tin"
    }

    Rectangle{
        anchors.fill: parent
        color: "#ddf6fe"
        Column{

            anchors.centerIn: parent
            spacing: 100
            children: [
                Row {
                    spacing: 20
                    children: [
                        Column {
                            spacing: 100
                            children: [
                                Input{
                                    width: 400
                                    id: txtMaxPressure
                                    text: CParam.getMaxPressure()
                                    Text {
                                        text: "Áp suất tối đa"
                                        font.pointSize: 13
                                        anchors.bottom: parent.top
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter:  parent.horizontalCenter
                                    }
                                },
                                Input{
                                    width: 400
                                    id: txtKI
                                    text: CParam.getKI()
                                    Text {
                                        text: "KI"
                                        font.pointSize: 13
                                        anchors.bottom: parent.top
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter:  parent.horizontalCenter
                                    }
                                }
                            ]
                        },
                        Column {
                            spacing: 100
                            children: [
                                Input{
                                    id: txtKP
                                    width: 400
                                    text: CParam.getKP()
                                    Text {
                                        text: "KP"
                                        font.pointSize: 13
                                        anchors.bottom: parent.top
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter:  parent.horizontalCenter
                                    }
                                },
                                Input{
                                    id: txtKD
                                    width: 400
                                    text: CParam.getKD()
                                    Text {
                                        text: "KD"
                                        font.pointSize: 13
                                        anchors.bottom: parent.top
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter:  parent.horizontalCenter
                                    }
                                }
                            ]
                        }
                    ]
                },
                PrimaryButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width/4
                    height: 50
                    text: "Lưu"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if (txtMaxPressure.text === "" ||
                                    txtKD.text === "" ||
                                    txtKP.text === "" || txtKD.text){
                                CParam.save(txtMaxPressure.text, txtKD.text, txtKP.text, txtKI.text)
                            } else {
                                messageDialog.visible = true
                            }
                        }
                    }
                }
            ]
        }
    }
}
