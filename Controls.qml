import QtQuick
import QtQuick.Layouts

Row {
    id: root

    property alias autoRefresh: refresh.active;
    property alias alwaysOnTop: onTop.active;

    spacing: 4;

    ControlButton {
        id: refresh

        height: root.height;
        width: height;
        icon: "qrc:/icons/refresh.svg"

        onToggle: {
        }
    }
    ControlButton {
        id: onTop

        property bool activated: false;

        height: root.height;
        width: height;
        icon: "qrc:/icons/onTop.svg"

        onToggle: {
        }
    }

}
