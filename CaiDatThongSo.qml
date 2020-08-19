import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import QtQml 2.0
Item {
    width: 1024
    height: 600
    visible: true
    Rectangle{
        anchors.fill: parent
        color: "lightblue"
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
        onClicked: stack.pop("CaiDatThongSo.qml")
        }
        }


    Clock{
        x: 341
        y: 101
        width: 361
        height: 166
        z: 1
        }
    Text {
        x: 119
        y: 74
        text: qsTr("UART MODBUS")
        font.pointSize: 16
    }
        Text {
            x: 44
            y: 120
            text: qsTr("Port")
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
        Dropdown {
            id: dropdownMasterPort
            model:  ListModel {
                id: listPort
                 ListElement {item: "";separator:false}
            }
            x: 138
            y: 108
            z: 5
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
            x: 138
            y: 164
            z: 4
            objectName: "dropdownMasterBaudrate"
        }

        Dropdown {
            id: dropdownMasterParity
            model: ListModel {
                    ListElement {item: "None";}
                    ListElement {item: "Even"; separator: true}
                    ListElement {item: "Odd"; separator: true}
                }
            x: 138
            y: 337
            z: 1
            objectName: "dropdownMasterParity"
        }

        Dropdown {
            id: dropdownMasterStop
            model: ListModel {
                    ListElement {item: "1";}
                    ListElement {item: "2"; separator: true}
                }
            x: 138
            y: 278
            z: 2
            objectName: "dropdownMasterStop"
        }

        Dropdown {
            id: dropdownMasterDatabits
            model: ListModel {
                    ListElement {item: "8";}
                    ListElement {item: "7"; separator: true}
                    ListElement {item: "6"; separator: true}
                    ListElement {item: "5"; separator: true}
                }
            x: 138
            y: 221
            z: 3
            objectName: "dropdownMasterDatabits"
        }

        Text {
            x: 44
            y: 176
            text: qsTr("Baudrate")
        }

        Text {
            x: 44
            y: 233
            text: qsTr("Data Bits")
        }

        Text {
            x: 47
            y: 349
            text: qsTr("Parity")
        }

        Text {
            x: 47
            y: 290
            text: qsTr("Stop bits")
        }

        Dropdown {
            id: dropdownMasterFlow
            model: ListModel {
                    ListElement {item: "None";}
                    ListElement {item: "RTS/CTS"; separator: true}
                    ListElement {item: "XON/XOFF"; separator: true}
                }
            x: 138
            y: 403
            z: 0
            objectName: "dropdownMasterFlow"
        }

        Text {
            x: 47
            y: 415
            text: qsTr("Flow Control")
        }


        Input {
            id: inverterID
            x: 490
            y: 337
            objectName: "inverterAddress"
        }

        Input {
            id: vavleID
            x: 490
            y: 403
            objectName: "inverterBaudrate"
        }

        Text {
            x: 433
            y: 293
            text: qsTr("CÀI ĐẶT ĐỊA CHỈ")
            font.pointSize: 16
        }

        Text {
            x: 347
            y: 349
            text: qsTr("ĐỊA CHỈ BIẾN TẦN")
        }

        Text {
            x: 347
            y: 415
            text: qsTr("ĐỊA CHỈ VAN")
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 30
            text: qsTr("CÀI ĐẶT THÔNG SỐ HỆ THỐNG")
            anchors.horizontalCenterOffset: 9
            font.pointSize: 24
            font.bold: true
        }

        Text {
            x: 796
            y: 74
            text: qsTr("UART MODBUS ICP")
            font.pointSize: 16
        }

        Dropdown {
            id: dropdownMasterPort1
            x: 804
            y: 109
            model: ListModel {
                id: listPort1
                ListElement {
                    separator: false
                    item: ""
                }
            }
            z: 5
            objectName: "dropdownMasterPort"
        }

        Dropdown {
            id: dropdownMasterBaudrate1
            x: 804
            y: 165
            model: ListModel {
                ListElement {
                    item: "9600"
                }

                ListElement {
                    separator: true
                    item: "19200"
                }

                ListElement {
                    separator: true
                    item: "38400"
                }

                ListElement {
                    separator: true
                    item: "115200"
                }
            }
            dropdownTextColor: "black"
            z: 4
            objectName: "dropdownMasterBaudrate"
        }

        Dropdown {
            id: dropdownMasterParity1
            x: 804
            y: 337
            model: ListModel {
                ListElement {
                    item: "None"
                }

                ListElement {
                    separator: true
                    item: "Even"
                }

                ListElement {
                    separator: true
                    item: "Odd"
                }
            }
            z: 1
            objectName: "dropdownMasterParity"
        }

        Dropdown {
            id: dropdownMasterStop1
            x: 804
            y: 280
            model: ListModel {
                ListElement {
                    item: "1"
                }

                ListElement {
                    separator: true
                    item: "2"
                }
            }
            z: 2
            objectName: "dropdownMasterStop"
        }

        Text {
            x: 706
            y: 177
            text: qsTr("Baudrate")
        }

        Text {
            x: 708
            y: 233
            text: qsTr("Data Bits")
        }

        Text {
            x: 710
            y: 345
            text: qsTr("Parity")
        }

        Text {
            x: 708
            y: 120
            text: qsTr("Port")
        }

        Dropdown {
            id: dropdownMasterDatabits1
            x: 804
            y: 221
            model: ListModel {
                ListElement {
                    item: "8"
                }

                ListElement {
                    separator: true
                    item: "7"
                }

                ListElement {
                    separator: true
                    item: "6"
                }

                ListElement {
                    separator: true
                    item: "5"
                }
            }
            z: 3
            objectName: "dropdownMasterDatabits"
        }

        Text {
            x: 710
            y: 292
            text: qsTr("Stop bits")
        }

        Dropdown {
            id: dropdownMasterFlow1
            x: 804
            y: 398
            model: ListModel {
                ListElement {
                    item: "None"
                }

                ListElement {
                    separator: true
                    item: "RTS/CTS"
                }

                ListElement {
                    separator: true
                    item: "XON/XOFF"
                }
            }
            z: 0
            objectName: "dropdownMasterFlow"
        }

        Text {
            x: 711
            y: 410
            text: qsTr("Flow Control")
        }


    PrimaryButton {
        x: 84
        y: 471
        width: 150
        height: 46
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
        x: 254
        y: 471
        width: 150
        height: 46
        text: "Ngắt kết nối"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Modbus.stopConnection()
            }
        }
    }

    PrimaryButton {
        x: 693
        y: 478
        width: 150
        height: 46
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
        x: 862
        y: 478
        width: 150
        height: 46
        text: "Ngắt kết nối"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Cambien.closeSerialPort()
            }
        }
    }



}
