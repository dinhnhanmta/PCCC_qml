import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import QtQml 2.0
Item {
    width: 1024
    height: 800
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
            text: qsTr("     Trang thai \n     ket noi")
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
        }


    Clock{
        x: 340
        y: 141
        width: 361
        height: 166
        z: 1
        }
    Text {
        x: 113
        y: 118
        text: qsTr("UART MODBUS")
        font.pointSize: 16
    }
        Text {
            x: 38
            y: 185
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
                        else dropdownMasterPort.text = Master.q_port[0];
                         worker.sendMessage(msg);
                    }
                }
        Dropdown {
            id: dropdownMasterPort
            model:  ListModel {
                id: listPort
                 ListElement {item: "";separator:false}
            }
            x: 131
            y: 173
            z: 5
            objectName: "dropdownMasterPort"
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
            x: 131
            y: 253
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
            x: 131
            y: 493
            z: 1
            objectName: "dropdownMasterParity"
        }

        Dropdown {
            id: dropdownMasterStop
            model: ListModel {
                    ListElement {item: "1";}
                    ListElement {item: "2"; separator: true}
                }
            x: 131
            y: 413
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
            x: 131
            y: 334
            z: 3
            objectName: "dropdownMasterDatabits"
        }

        Text {
            x: 38
            y: 265
            text: qsTr("Baudrate")
        }

        Text {
            x: 38
            y: 345
            text: qsTr("Data Bits")
        }

        Text {
            x: 38
            y: 495
            text: qsTr("Parity")
        }

        Text {
            x: 38
            y: 425
            text: qsTr("Stop bits")
        }

        Dropdown {
            id: dropdownMasterFlow
            model: ListModel {
                    ListElement {item: "None";}
                    ListElement {item: "RTS/CTS"; separator: true}
                    ListElement {item: "XON/XOFF"; separator: true}
                }
            x: 131
            y: 574
            z: 0
            objectName: "dropdownMasterFlow"
        }

        Text {
            x: 38
            y: 585
            text: qsTr("Flow Control")
        }


        Input {
            id: inverterAddress
            initText: "8192"
            x: 490
            y: 392
            objectName: "inverterAddress"
        }

        Input {
            id: inverterBaudrate
            initText: "8193"
            x: 490
            y: 495
            objectName: "inverterBaudrate"
        }





        Text {
            x: 446
            y: 337
            text: qsTr("CÀI ĐẶT ĐỊA CHỈ")
            font.pointSize: 16
        }

        Text {
            x: 347
            y: 403
            text: qsTr("ĐỊA CHỈ BIẾN TẦN")
        }

        Text {
            x: 347
            y: 506
            text: qsTr("ĐỊA CHỈ VAN")
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 65
            text: qsTr("CÀI ĐẶT THÔNG SỐ HỆ THỐNG")
            font.pointSize: 24
            font.bold: true
        }

        Text {
            x: 777
            y: 118
            text: qsTr("UART MODBUS ICP")
            font.pointSize: 16
        }

        Dropdown {
            id: dropdownMasterPort1
            x: 795
            y: 173
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
            x: 795
            y: 253
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
            x: 795
            y: 492
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
            x: 795
            y: 412
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
            x: 702
            y: 264
            text: qsTr("Baudrate")
        }

        Text {
            x: 702
            y: 344
            text: qsTr("Data Bits")
        }

        Text {
            x: 702
            y: 495
            text: qsTr("Parity")
        }

        Text {
            x: 702
            y: 184
            text: qsTr("Port")
        }

        Dropdown {
            id: dropdownMasterDatabits1
            x: 795
            y: 333
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
            x: 702
            y: 424
            text: qsTr("Stop bits")
        }

        Dropdown {
            id: dropdownMasterFlow1
            x: 795
            y: 573
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
            x: 702
            y: 585
            text: qsTr("Flow Control")
        }


    PrimaryButton {
        x: 54
        y: 648
        width: 150
        height: 60
        text: "Kết nối"
        color: "lightgreen"
    }

    DangerButton {
        x: 227
        y: 648
        width: 150
        height: 60
        text: "Ngắt kết nối"
    }

    PrimaryButton {
        x: 683
        y: 648
        width: 150
        height: 60
        text: "Kết nối"
        color: "lightgreen"
    }

    DangerButton {
        x: 856
        y: 648
        width: 150
        height: 60
        text: "Ngắt kết nối"
    }


    scale: 0.7

}
