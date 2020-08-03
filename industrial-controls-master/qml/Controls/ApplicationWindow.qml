import QtQuick 2.6
import QtQuick.Controls 2.2 as Controls

Controls.ApplicationWindow {
    id: window

    visible: true
    Button {


    }

    BottomBar {
        id: bottomBar
        x: 167
        y: 188
    }

    Card {
        id: card
        x: 138
        y: 188
        width: 196
        height: 42
    }

    Button {
        id: button
        x: 388
        y: 155
        width: 100
        height: 200
        textColor: "red"
        backgroundColor: "yellow"
    }}
