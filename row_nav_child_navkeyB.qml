import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 400
    height: 400
    color: "#f0f0f0"
    focus: true


    property int selectedTileIndex: -1
    property int selectedRow: 0

    // Row 1
    Item {
        id: row1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 50
        height: 100

        // Tiles in Row 1
        Repeater {
            model: 3
            delegate: Rectangle {
                width: 100
                height: 100
                x: (index * 120)+20
                color: (selectedRow === 0 && index === selectedTileIndex) ? "orange" : "green"
                border.color: "black"
                border.width: 2
                radius: 10

                Text {
                    anchors.centerIn: parent
                    text: "Tile " + (index + 1)
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedRow = 0;
                        selectedTileIndex = index;
                    }
                }
            }
        }
    }

    // Row 2
    Item {
        id: row2
        anchors.top: row1.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 50
        height: 100

        // Tiles in Row 2
        Repeater {
            model: 3
            delegate: Rectangle {
                width: 100
                height: 100
                x: (index * 120)+20
                color: (selectedRow === 1 && index === selectedTileIndex) ? "orange" : "green"
                border.color: "black"
                border.width: 2
                radius: 10

                Text {
                    anchors.centerIn: parent
                    text: "Tile " + (index + 4) // Tile number continues from Row 1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedRow = 1;
                        selectedTileIndex = index;
                    }
                }
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Tab) {

            selectedRow = (selectedRow + 1) % 2;
            selectedTileIndex = 0;
        } else if (event.key === Qt.Key_Left) {
            //navigate left
            selectedTileIndex = (selectedTileIndex - 1 + 3) % 3;
        } else if (event.key === Qt.Key_Right) {
            // navigate right within the row
            selectedTileIndex = (selectedTileIndex + 1) % 3;
        }
    }

    Component.onCompleted: forceActiveFocus()
}
