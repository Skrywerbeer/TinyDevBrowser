import QtQuick
import QtWebView
import QtQuick.Layouts

import tinyDevBrowser


Window {
    id: root

    property bool onTop: false;

    height: 600;
    width: 400;
    visible: true;
    flags: controls.alwaysOnTop ? (Qt.Window | Qt.WindowStaysOnTopHint) :
                                  (Qt.Window);

    FileChangeMonitor {
        id: monitor
        running: controls.autoRefresh;
        onFilesChanged: view.reload();
    }

    ColumnLayout {
        anchors.fill: parent;
        RowLayout {
            Layout.fillWidth: true;

            Controls {
                id: controls
                Layout.preferredHeight: 32;
                Layout.preferredWidth: 64
            }
            AddressBar {
                id: addressBar;
                loadProgress: view.loadProgress;
                Layout.fillWidth: true;
                Layout.preferredHeight: 32;
                onUrlChanged: () => {view.url = addressBar.url;}
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

                onUrlChanged: {
                    // TODO: do a better check of the passed url.
                    const SCHEME_END = 7;
                    let asStr = view.url.toString();
                    const endIndex = asStr.lastIndexOf("/")+1;
                    monitor.path = asStr.slice(SCHEME_END, endIndex);
                    addressBar.url = view.url;
                }
            }
        }
    }

}
