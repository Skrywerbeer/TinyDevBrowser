import QtQuick
import QtWebView
import QtQuick.Layouts


Window {
    id: root

    property bool onTop: false;

    height: 600;
    width: 400;
    visible: true;

    ColumnLayout {
        anchors.fill: parent;
        RowLayout {
            Layout.fillWidth: true;

            Controls {
                Layout.preferredHeight: 32;
                Layout.preferredWidth: 64

                onRefresh: view.reload();
                onOnTop: {
                    console.log(root.flags);
                    root.onTop = !root.onTop;
                    if (root.onTop)
                        root.flags = Qt.Window | Qt.WindowStaysOnTopHint;
                    else
                        root.flags = Qt.Window;
                }
            }
            AddressBar {
                id: addressBar;
                loadProgress: view.loadProgress;
                Layout.fillWidth: true;
                Layout.preferredHeight: 32;
                onUrlFinished: view.url = newUrl;
            }
        }
        Rectangle {
            border.width: 1;
            border.color: "black"
            Layout.fillHeight: true;
            Layout.fillWidth: true;

            WebView {
                id: view;

                anchors.fill: parent;

                onUrlChanged: addressBar.url = url;
            }
        }
    }

}
