import QtQuick 2.6
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0

Row {
    id: root

    property int undoNumber
    property string filename
    property bool finishedLoading

    signal undo()

    width: parent.width
    height: implicitHeight
    leftPadding: Theme.horizontalPageMargin
    rightPadding: Theme.horizontalPageMargin
    spacing: Theme.paddingMedium

    Item {
        id: undoContainer

        anchors.verticalCenter: parent.verticalCenter
        width: childrenRect.width
        height: childrenRect.height

        SecondaryButton {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.undoNumber >= 1 && root.finishedLoading
            icon.source: "../symbols/icon-l-undo.svg"
            text: root.undoNumber
            border.color: "transparent"

            onClicked: root.undo()
        }

        BusyIndicator {
            anchors.verticalCenter: parent.verticalCenter
            running: !root.finishedLoading
            size: BusyIndicatorSize.Medium
        }
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter

        width: {
            const containerWidth = undoContainer.visible ? undoContainer.width + root.spacing : 0
            return root.width - root.leftPadding - root.rightPadding - containerWidth
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Videoworks")
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeTiny
            color: Theme.secondaryColor
            truncationMode: TruncationMode.Elide
            text: root.filename
        }
    }
}
