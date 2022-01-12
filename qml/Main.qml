import QtQuick 2.9
import Ubuntu.Components 1.3
import QtQuick.Window 2.2
import Morph.Web 0.1
import "UCSComponents"
import QtWebEngine 1.7
import Qt.labs.settings 1.0
import QtSystemInfo 5.5
import Ubuntu.Components.ListItems 1.3 as ListItemm
import Ubuntu.Content 1.3

MainView {
  id:window
  objectName: "mainView"
  theme.name: "Ubuntu.Components.Themes.SuruDark"
  applicationName: "simplereader.collaproductions"
  backgroundColor : "#ffffff"

  PageStack {
    id: mainPageStack
    anchors.fill: parent
    Component.onCompleted: mainPageStack.push(pageMain)

    Page {
      id: pageMain
      anchors.fill: parent

      WebView {
        id: webview
        anchors{ fill: parent}
        enableSelectOverride: true
        settings.fullScreenSupportEnabled: true
        property var currentWebview: webview
        settings.pluginsEnabled: true
        settings.dnsPrefetchEnabled: true
        settings.spatialNavigationEnabled: true
        settings.javascriptCanOpenWindows: false

        onFullScreenRequested: function(request) {
          nav.visible = !nav.visible
          request.accept();
        }

        onFileDialogRequested: function(request) {
          request.accepted = true;
          var importPage = mainPageStack.push(Qt.resolvedUrl("ImportPage.qml"),{"contentType": ContentType.All, "handler": ContentHandler.Source})
          importPage.imported.connect(function(fileUrl) {
            console.log(String(fileUrl).replace("file://", ""));
            request.dialogAccept(String(fileUrl).replace("file://", ""));
            mainPageStack.push(pageMain)
          })
        }

        profile:  WebEngineProfile{
          id: webContext
          persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
          property alias dataPath: webContext.persistentStoragePath
          dataPath: dataLocation
        }

        anchors{
          fill:parent
        }
    
        zoomFactor: 2.8
        url: Qt.resolvedUrl('index.html')

      }

      Connections {
        target: Qt.inputMethod
        onVisibleChanged: nav.visible = !nav.visible
      }

      Connections {
        target: webview
        onIsFullScreenChanged: {
          window.setFullscreen()
          if (currentWebview.isFullScreen) {
            nav.state = "hidden"
          }
          else {
            nav.state = "shown"
          }
        }
      }

      Connections {
        target: webview
        onIsFullScreenChanged: window.setFullscreen(webview.isFullScreen)
      }
  
      function setFullscreen(fullscreen) {
        if (!window.forceFullscreen) {
          if (fullscreen) {
            if (window.visibility != Window.FullScreen) {
              internal.currentWindowState = window.visibility
              window.visibility = 5
            }
            } else {
              window.visibility = internal.currentWindowState
              //window.currentWebview.fullscreen = false
              //window.currentWebview.fullscreen = false
            }
        }
      }

      Connections {
        target: UriHandler
        onOpened: {
          if (uris.length > 0) {
            console.log('Incoming call from UriHandler ' + uris[0]);
            webview.url = uris[0];
          }
        }
      }

    }

  }

  ScreenSaver {
    id: screenSaver
    screenSaverEnabled: !(Qt.application.active) || !webview.recentlyAudible
  }
}
