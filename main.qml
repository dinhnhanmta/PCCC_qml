import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls 2.0
import "FlatUI-Controls-QML-master"
import IVIControls 1.0
Window {
    id: window
    visible: true
    width: 1024
    height: 600

    Flickable {
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        StackView {
               id: stack
               initialItem: "Login.qml"
               anchors.fill: parent
           }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: Qt.inputMethod.visible ? window.height - inputPanel.height : window.height
        width: window.width
        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
        onActiveChanged: {
            var posWithinFlickable = mapToItem(stack, 0, height / 2);
            if (active){
                flickable.contentY = height / 2;
            } else {
                flickable.contentY = 0;
            }
        }
    }
}
