import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: keyboard_nav
    width: 400
    height: 400

    focus: true

    property int selectedTileIndex: 0 // Tracks the selected tile (0, 1, or 2)

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Row {
            id: tileRow
            spacing: 10
            anchors.centerIn: parent

            Repeater {
                model: 3 // Create 3 tiles dynamically

                Rectangle {
                    id: tile
                    width: 100
                    height: 100
                    border.color: "black"
                    border.width: 2
                    color: selectedTileIndex === index ? "#88cc88" : "#cccccc"

                    property real originalX: 0 // Save original X position
                    property real originalY: 0 // Save original Y position

                    Component.onCompleted: {
                        // Save the initial positions of each tile
                        originalX = x;
                        originalY = y;
                    }

                    // Dragging functionality
                    Drag.active: mouseArea.drag.active
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        drag.target: parent

                        onReleased: {
                            if (!drag.active) {
                                // Snap the rectangle back to its original position
                                parent.x = parent.originalX;
                                parent.y = parent.originalY;
                            }
                        }
                    }
                }
            }
        }
    }

    // Keyboard navigation logic
    Keys.onPressed: {
        if (event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
            if (event.key === Qt.Key_Left) {
                selectedTileIndex = (selectedTileIndex - 1 + tileRow.children.length) % tileRow.children.length;
            } else if (event.key === Qt.Key_Right) {
                selectedTileIndex = (selectedTileIndex + 1) % tileRow.children.length;
            }
        }
    }
}
