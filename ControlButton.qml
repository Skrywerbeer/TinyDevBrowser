import QtQuick

Rectangle {
    id: root;

    property alias icon: btnIcon.source;

    signal clicked;

    border {width: 2; color: Qt.lighter("#fea75f");}
    state: "inactive";

    Image {
        id: btnIcon
        anchors.fill: parent;
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: root.clicked();
    }

    states: [
        State {
            name: "active"
            PropertyChanges {target: root; border.color: "gray";}
            when: mouseArea.pressed;
        },
        State {
            name: "inactive"
//            PropertyChanges {target: root; border.color: 1;}
        }

    ]
    transitions: [


    ]

}
