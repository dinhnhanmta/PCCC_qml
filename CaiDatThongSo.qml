import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import QtQml 2.0
Item {
    antialiasing: true
    anchors.fill: parent
    Rectangle{
        id: rectangle
        anchors.fill: parent
        color: "lightblue"
        Image {
            source: "qrc:/Icon/account.png"
            scale: 0.8
            anchors.right: parent.right
            anchors.top: parent.top
        }

        Text {
            id: label
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("CÀI ĐẶT THÔNG SỐ HỆ THỐNG")
            font.pixelSize: 26
            font.bold: true
            color: "white"
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: label.bottom
            anchors.topMargin: 10
            width: parent.width - 50
            Column {
                width: parent.width/3
                spacing: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("UART MODBUS")
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
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterFlow
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
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Modbus.q_current_port = dropdownMasterPort.text
                                Modbus.q_baudrate = parseInt(dropdownMasterBaudrate.text)
                                Modbus.q_dataBits = parseInt(dropdownMasterDatabits.text)
                                Modbus.q_flow = dropdownMasterFlow.text
                                Modbus.q_parity = dropdownMasterParity.text
                                Modbus.q_stopBits = parseInt(dropdownMasterStop.text)
                                Modbus.startConnection();
                                //Modbus.readHoldingRegister(1,0,4)
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
                width: parent.width/3
                spacing: 25
                Clock {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 361
                    height: 166
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("CÀI ĐẶT ĐỊA CHỈ")
                    font.pointSize: 16
                }
                Row {
                    id: row
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.right: parent.right
                    width: parent.width
                    Text {
                        width: parent.width/2
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("ĐC BIẾN TẦN")
                    }
                    Input {
                        id: inverterID
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.right: parent.right
                    width: parent.width
                    Text {
                        width: parent.width/2
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("ĐC VAN")
                    }
                    Input {
                        anchors.verticalCenter: parent.verticalCenter
                        id: vavleID
                    }
                }
            }
            Column {
                width: parent.width/3
                spacing: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("UART MODBUS")
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
                        text: qsTr("Stopbits")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Dropdown {
                        id: dropdownMasterParity1
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
                                Cambien.q_portName = dropdownMasterPort1.text
                                Cambien.q_baudrate = parseInt(dropdownMasterBaudrate1.text)
                                Cambien.q_dataBits = parseInt(dropdownMasterDatabits1.text)
                                Cambien.q_flow = dropdownMasterFlow1.text
                                Cambien.q_parity = dropdownMasterParity1.text
                                Cambien.q_stopBits = parseInt(dropdownMasterStop1.text)
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

        DangerButton {
            text: "Modbus"
            color: "palegoldenrod"
            width: 200
            anchors.right: parent.right
            anchors.bottom:  parent.bottom
            Image {
                id: state_icon
                 source: Modbus.q_connectionState ? "qrc:/Icon/tick.png" : "qrc:/Icon/close.png"
                 anchors.right: parent.right
                 scale: 0.7
            }
        }
        DangerButton {
            text: "Quay lại"
            color: "palegoldenrod"
            width: 200
            anchors.left: parent.left
            anchors.bottom:  parent.bottom
            Image {
                 source: "qrc:/Icon/home2.png"
                 anchors.left: parent.left
                 scale: 0.7
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
            for (var i = 0; i < Master.q_number_port; i++)
            {
                msg["port"].push(Master.q_port[i])
            }
            if (i===0)  dropdownMasterPort.text="";
            else
            {
                dropdownMasterPort.text = Master.q_port[0]
                dropdownMasterPort1.text = Master.q_port[0]
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
