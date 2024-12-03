import QtQuick 2.15
import QtQuick.Controls 2.15
import "logic.js" as Logic

Rectangle {
    width: 800
    height: 400
    color: "#f0f0f0"
    focus: true

    property int num1: 0
    property int num2: 0
    property var options: []
    property int selectedTileIndex: -1
    property int selectedRow: 0


    Component.onCompleted: {
        let question = Logic.generateQuestion();
        num1 = question.num1;
        num2 = question.num2;
        options = question.options;
        forceActiveFocus();
    }


    Item {
        id: row1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        height: 100

        Repeater {
            model: 3
            delegate: Rectangle {
                width: 100
                height: 100
                x: index * 120
                color: "lightblue"
                border.color: "black"
                border.width: 2
                radius: 10

                Text {
                    anchors.centerIn: parent
                    text: index === 2 ? "?" : (index === 0 ? num1 : num2)
                    font.bold: true
                }
            }
        }
    }


    Item {
        id: row2
        anchors.top: row1.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        height: 100

        Repeater {
            model: options
            delegate: Rectangle {
                width: 100
                height: 100
                x: index * 120
                color: (selectedRow === 1 && index === selectedTileIndex) ? "orange" : "green"
                border.color: "black"
                border.width: 2
                radius: 10

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedRow = 1;
                        selectedTileIndex = index;
                        //forceActiveFocus();
                    }
                }
            }
        }
    }


    Keys.onPressed: {
        if (event.key === Qt.Key_Tab) {

            selectedRow = (selectedRow + 1) % 2;
            selectedTileIndex = 0; // reset to first tile
        } else if (event.key === Qt.Key_Left) {
            // navigate left
            selectedTileIndex = (selectedTileIndex - 1 + 3) % 3;
        } else if (event.key === Qt.Key_Right) {
            // nvigate right
            selectedTileIndex = (selectedTileIndex + 1) % 3;
        } else if (event.key === Qt.Key_Space && selectedRow === 1) {
            // update the ? in Row 1
            row1.children[2].children[0].text = options[selectedTileIndex];
        }
    }
}
