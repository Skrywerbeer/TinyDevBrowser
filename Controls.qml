import QtQuick
import QtQuick.Layouts

Row {
    id: root

    signal refresh();
    signal onTop();

    spacing: 4;

    ControlButton {
        id: refresh

        height: root.height;
        width: height;
        icon: "qrc:/icons/refresh.svg"

        onClicked: root.refresh();
    }
    ControlButton {
        id: onTop

        property bool activated: false;

        height: root.height;
        width: height;
        icon: "qrc:/icons/onTop.svg"

        onClicked: {
            root.onTop();
            onTop.activated = !onTop.activated;
            if (onTop.activated)
                onTop.state = "active"
            else
                onTop.state = "inactive"
        }
    }

}
