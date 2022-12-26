import QtQuick

Rectangle {
    id: root;

    property alias icon: btnIcon.source;
    property bool active: false;

    signal toggle();

    border {width: 2; color: Qt.lighter("#fea75f");}
    state: "inactive";

    Image {
        id: btnIcon
        anchors.fill: parent;
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {root.active = !root.active; root.toggle();}
    }

    states: [
        State {
            name: "active"
            PropertyChanges {target: root; border.color: "gray";}
            when: root.active;
        },
        State {
            name: "inactive"
            when: !root.active;
        }

    ]
    transitions: [


    ]

}
