import QtQuick

import "qrc:/js/tokens.js" as Token

Rectangle {
    id: root

    property int loadProgress: 0;
    property string url: ""
    property alias displayedUrl: addressInput.text;

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

        onFocusChanged: {
            if (focus) {
                addressInput.text = root.url;
            }
            else {
                root.url = addressInput.text;
                if (addressInput.contentWidth > addressInput.width) {
//                    addressInput.text = "Too long";
                    let [scheme, tokens] = Token.tokenify(root.url);
                    console.log([scheme, tokens])
                    addressInput.text = scheme + "/.../" + tokens[tokens.length-1];
                }
            }
        }
        onEditingFinished: {focus = false;}
//        Keys.onEnterPressed: {
//            addressInput.focus = false;
//        }
    }

}
