import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import QtQml 2.0
Item {
    antialiasing: true
    anchors.fill: parent
    Component.onCompleted: screenLabel.text = qsTr("CÀI ĐẶT THÔNG SỐ HỆ THỐNG")

    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: "lightblue"

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: parent.width - 50
            Column {
                width: parent.width/3
                spacing: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("MODBUS CONFIGURATION")
                    font.pointSize: 16
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Port")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterPort
                        text: Modbus.portname
                        dropdownTextColor: "black"
                        model:  ListModel {
                            id: listPort
                            ListElement {item: "";separator:false}
                        }
                        z: 5
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Baudrate")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterBaudrate
                        text: Modbus.baudrate
                        dropdownTextColor: "black"
                        model: ListModel {
                                ListElement {item: "9600";}
                                ListElement {item: "19200"; separator: true}
                                ListElement {item: "38400"; separator: true}
                                ListElement {item: "115200"; separator: true}
                        }
                        z: 4
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Databits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterDatabits
                        text: Modbus.databits
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "8";}
                            ListElement {item: "7"; separator: true}
                            ListElement {item: "6"; separator: true}
                            ListElement {item: "5"; separator: true}
                        }
                        z: 3
                        objectName: "dropdownMasterDatabits"
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterStop
                        text: Modbus.stopbits
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "1";}
                            ListElement {item: "2"; separator: true}
                        }
                        z: 2
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterParity
                        text: Modbus.parity
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "None";}
                            ListElement {item: "Even"; separator: true}
                            ListElement {item: "Odd"; separator: true}
                        }
                        z: 1
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Parity")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterFlow
                        text: Modbus.flow
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "None";}
                            ListElement {item: "RTS/CTS"; separator: true}
                            ListElement {item: "XON/XOFF"; separator: true}
                        }
                    }
                }
                Row {
                    width: parent.width - 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 25
                    PrimaryButton {
                        width: parent.width/2
                        height: 64
                        text: "Kết nối"
                        color: "lightgreen"
                        radius: 4
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Modbus.portname = dropdownMasterPort.text
                                Modbus.baudrate = parseInt(dropdownMasterBaudrate.text)
                                Modbus.databits = parseInt(dropdownMasterDatabits.text)
                                Modbus.flow = dropdownMasterFlow.text
                                Modbus.parity = dropdownMasterParity.text
                                Modbus.stopbits = parseInt(dropdownMasterStop.text)
                                Modbus.startConnection();
                                Bientan.q_ID = parseInt(inverterID.text)
                                Vavle.q_ID = parseInt(vavleID.text)
                            }
                        }
                    }

                    DangerButton {
                        width: parent.width/2
                        height: 64
                        text: "Ngắt kết nối"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Modbus.stopConnection()
                            }
                        }
                    }
                }
            }
            Column {
                id: column
                width: 250
                spacing: 25
                Clock {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 361
                    height: 166
                }
                Row {
                    id: row
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.right: parent.right
                    width: parent.width
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.right: parent.right
                    width: parent.width
                }
            }
            Column {
                width: parent.width/3
                spacing: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("UART CẢM BIẾN")
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 16
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Port")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterPort1
                        text: Cambien.portname
                        dropdownTextColor: "black"
                        model:  ListModel {
                            id: listPort1
                            ListElement {item: "";separator:false}
                        }
                        z: 5
                    }
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Baudrate")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterBaudrate1
                        text: Cambien.baudrate
                        z: 4
                        dropdownTextColor: "black"
                        model: ListModel {
                                ListElement {item: "9600";}
                                ListElement {item: "19200"; separator: true}
                                ListElement {item: "38400"; separator: true}
                                ListElement {item: "115200"; separator: true}
                            }
                    }
                    z: 4
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Databits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterDatabits1
                        text: Cambien.databits
                        z: 3
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "8";}
                            ListElement {item: "7"; separator: true}
                            ListElement {item: "6"; separator: true}
                            ListElement {item: "5"; separator: true}
                        }
                    }
                    z: 3
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterStop1
                        text: Cambien.stopbits
                        z: 2
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "1";}
                            ListElement {item: "2"; separator: true}
                        }
                    }
                    z: 2
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Parity")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterParity1
                        text: Cambien.parity
                        z: 1
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "None";}
                            ListElement {item: "Even"; separator: true}
                            ListElement {item: "Odd"; separator: true}
                        }
                    }
                    z: 2
                }
                Row {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        width: parent.width/2
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterFlow1
                        text: Cambien.flow
                        dropdownTextColor: "black"
                        model: ListModel {
                            ListElement {item: "None";}
                            ListElement {item: "RTS/CTS"; separator: true}
                            ListElement {item: "XON/XOFF"; separator: true}
                        }
                    }
                    z: 1
                }
                Row {
                    width: parent.width - 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 25
                    PrimaryButton {
                        width: parent.width/2
                        height: 64
                        text: "Kết nối"
                        color: "lightgreen"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Cambien.portname = dropdownMasterPort1.text
                                Cambien.baudrate = parseInt(dropdownMasterBaudrate1.text)
                                Cambien.databits = parseInt(dropdownMasterDatabits1.text)
                                Cambien.flow = dropdownMasterFlow1.text
                                Cambien.parity = dropdownMasterParity1.text
                                Cambien.stopbits = parseInt(dropdownMasterStop1.text)
                                Cambien.openSerialPort();
                            }
                        }
                    }

                    DangerButton {
                        width: parent.width/2
                        height: 64
                        text: "Ngắt kết nối"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Cambien.closeSerialPort()
                            }
                        }
                    }
                }
            }
        }
    }

    WorkerScript {
       id: worker
       source: "addPort.mjs"
       onMessage: myText.text = messageObject.reply
    }

    Timer {
        id: timer
        interval: 1000; repeat: true
        running: true
        triggeredOnStart: true

        onTriggered: {
            Master.getPortAvalable();
            var msg = {'port':[],'model': listPort};
            if (Master.q_number_port == 0){
                dropdownMasterPort.text="";
                dropdownMasterPort1.text="";
            } else {
                dropdownMasterPort.text = Master.q_port[0]
                dropdownMasterPort1.text = Master.q_port[0]

                for (var i = 0; i < Master.q_number_port; i++){
                    msg["port"].push(Master.q_port[i])
                    if (Master.q_port[i] === Cambien.portname){
                        dropdownMasterPort1.text = Cambien.portname
                    }
                    if (Master.q_port[i] === Modbus.portname){
                        dropdownMasterPort.text = Modbus.portname
                    }
                }

                timer.stop()
            }

            worker.sendMessage(msg);
            msg['model'] =  listPort1;
            worker.sendMessage(msg);
        }
    }
}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_width:640}
}
 ##^##*/
