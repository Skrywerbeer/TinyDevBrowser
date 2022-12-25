import QtQuick

Rectangle {
    id: root

    property int loadProgress: 0;
    property alias url: addressInput.text;
    signal urlFinished(newUrl: string);

    border {width: 4; color: Qt.lighter("#fea75f");}

    Rectangle {
        id: progressBar;
        height: parent.height-8;
        anchors.verticalCenter: parent.verticalCenter;
        width: (root.loadProgress/100)*parent.width;
        color: "#fea75f";
    }
    TextInput {
        // TODO: add autocomplete.
        // TODO: truncate long addresses.
        id: addressInput;
        anchors.fill: parent;
        padding: 5;
        font {pixelSize: 16; family: "monospace";}

        onEditingFinished: {
            root.urlFinished(addressInput.text);
        }
        Keys.onEnterPressed: {
            addressInput.focus = false;
        }
    }
}
