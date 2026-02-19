import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import "../../state" as S
import "../../bar" as B
import "../../config" as C
import "../../commonwidgets" as CW
import "mpris" as M

MouseArea {
    id: root
    property MprisPlayer player: S.MprisState.player
    property string trackArtUrl: player?.trackArtUrl ?? ""
    property bool artIsRemote: !trackArtUrl.startsWith("file://")
    property string remoteArtUrl: artIsRemote ? trackArtUrl : ""
    property string artHash: ""
    property string cachedArtUrl: ""
    property string displayArtUrl: artIsRemote ? cachedArtUrl : trackArtUrl
    property string artCacheDir: `${Quickshell.cacheDir}/mprisArt`
    property string cachePath: `${artCacheDir}/${artHash}`

    // function mix(color1, color2, ratio = 0.5) {
    //     const col1 = Qt.color(color1);
    //     const col2 = Qt.color(color2);
    //     return Qt.rgba(ratio * col1.r + (1 - ratio) * col2.r, ratio * col1.g + (1 - ratio) * col2.g, ratio * col1.b + (1 - ratio) * col2.b, ratio * col1.a + (1 - ratio) * col2.a);
    // }
    // function colorWithHslHueOf(baseColor, hueColor) {
    //     const bc = Qt.color(baseColor);
    //     const hc = Qt.color(hueColor);
    //     return Qt.hsla(hc.hslHue, bc.hslSaturation, bc.hslLightness, bc.a);
    // }

    // property QtObject colors: QtObject {
    //     property color primary: C.Config.colors.blue
    //     property color on_primary: C.Config.colors.bg_dark
    //     property color secondary_container: C.Config.colors.red
    //     property color on_surface: C.Config.colors.green
    //     property color surface_container: C.Config.colors.fg
    // }

    visible: player != null
    implicitHeight: 130
    acceptedButtons: Qt.BackButton | Qt.ForwardButton

    onPressed: event => {
        const player = S.MprisState.player;
        if (!player)
            return;

        if (event.button == Qt.BackButton) {
            if (player.canGoPrevious)
                player.previous();
        } else if (event.button == Qt.ForwardButton) {
            if (player.canGoNext)
                player.next();
        }
    }

    onRemoteArtUrlChanged: {
        if (remoteArtUrl == "")
            return;

        const newHash = Qt.md5(remoteArtUrl);
        if (newHash === root.artHash)
            return;

        root.artHash = newHash;
        artCacheProc.exec(["bash", Quickshell.configPath("leftmenu/mpris/downloadCover.sh"), root.remoteArtUrl, root.artCacheDir, root.cachePath]);
    }

    Process { // Cover art downloader
        id: artCacheProc
        onExited: root.cachedArtUrl = root.cachePath
    }

    ColorQuantizer {
        id: quant
        source: Qt.resolvedUrl(root.displayArtUrl)
        rescaleSize: 100
    }

    // ClippingRectangle {
    //     id: bgRect
    //     contentUnderBorder: true
    //     radius: 20
    //     color: root.tintedColors.surface_container
    //     height: 100
    //
    //     Image {
    //         id: bg
    //         source: root.displayArtUrl
    //         asynchronous: true
    //
    //         anchors {
    //             verticalCenter: parent.verticalCenter
    //             left: parent.left
    //             right: parent.right
    //             leftMargin: -20
    //             rightMargin: -20
    //         }
    //
    //         height: width
    //
    //         sourceSize.width: root.width
    //         sourceSize.height: root.width
    //
    //         layer.enabled: true
    //         layer.effect: MultiEffect {
    //             blurEnabled: true
    //             blurMax: 100
    //             blur: 1
    //         }
    //     }
    //
    //     Rectangle {
    //         anchors.fill: bg
    //         opacity: 0.6
    //         color: {
    //             const tint = root.tint;
    //             const newSat = Math.max(tint.hsvSaturation, 0.2);
    //             const newVal = Math.min(tint.hsvValue, 0.7 - Math.max(0, 0.6 - newSat));
    //             return Qt.hsva(tint.hsvHue, newSat, newVal, 1.0);
    //         }
    //     }
    // }

    RowLayout {
        id: controlsLayout
        anchors {
            fill: parent
            margins: 12
        }

        Item {
            id: coverItem
            Layout.fillHeight: true
            implicitWidth: height
            Layout.rightMargin: parent.anchors.margins

            ClippingWrapperRectangle {
                id: image
                anchors.centerIn: parent
                radius: 6
                visible: artItem.width > 0 && artItem.height > 0

                Item {
                    id: artItem
                    anchors.centerIn: parent
                    implicitHeight: coverImage.paintedHeight
                    implicitWidth: coverImage.paintedHeight

                    CW.FontIcon {
                        anchors.centerIn: parent
                        text: "art_track"
                        iconSize: 48
                    }

                    Image {
                        id: coverImage
                        anchors.centerIn: parent
                        source: root.displayArtUrl
                        asynchronous: true
                        // implicitSize: coverItem.width
                        sourceSize {
                            width: coverItem.width
                            height: coverItem.width
                        }

                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillHeight: true
            spacing: 0

            RowLayout {
                spacing: 5

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 6

                    CW.StyledText {
                        Layout.fillWidth: true
                        color: C.Config.colors.fg
                        elide: Text.ElideRight
                        text: root.player?.trackTitle || "Unknown Track"
                        font.weight: Font.Medium
                        font.pointSize: C.Config.fontSize.large
                    }

                    CW.StyledText {
                        // TODO: Check if this visible should be here
                        // visible: root.player?.trackArtist
                        Layout.fillWidth: true
                        color: C.Config.colors.fg
                        text: root.player?.trackArtist || "Unknown Artist"
                        elide: Text.ElideRight
                    }

                    CW.StyledText {
                        // TODO: Check if this visible should be here
                        // visible: root.player?.trackAlbum
                        Layout.topMargin: -4
                        Layout.fillWidth: true
                        color: C.Config.colors.fg
                        text: root.player?.trackAlbum || "Unknown Album"
                        elide: Text.ElideRight
                    }
                }

                WrapperMouseArea {
                    id: pauseplayMa
                    Layout.alignment: Qt.AlignTop
                    hoverEnabled: true
                    implicitWidth: playPauseButton.implicitHeight
                    implicitHeight: playPauseButton.implicitHeight
                    onPressed: {
                        if (root.player == null)
                            return;

                        root.player.togglePlaying();
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: pauseplayMa.containsMouse ? Qt.darker(C.Config.colors.blue, 1.4) : C.Config.colors.blue

                        radius: 6

                        CW.FontIcon {
                            id: playPauseButton
                            text: (root.player?.isPlaying ?? false) ? "pause" : "play_arrow"
                            color: C.Config.colors.fg
                            anchors.centerIn: parent
                            font.pointSize: C.Config.fontSize.smallSymbol
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: C.Config.anim_MEDIUM
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: C.Config.anim_CURVE_SMOOTH_SLIDE
                            }
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }

            RowLayout {
                spacing: 8

                M.MprisPlayIcon {
                    text: "skip_previous"
                    onPressed: {
                        if (root.player == null)
                            return;

                        if (root.player.positionSupported && root.player.position > 10)
                            root.player.seek(-root.player.position);
                        else
                            root.player.previous();
                    }
                }

                CW.StyledProgressBar {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 4
                    colHighlight: C.Config.colors.red
                    colTrough: C.Config.colors.bg

                    value: root.player?.positionSupported ? (root.player.position / root.player.length) : 0

                    Timer {
                        running: root.player && root.player.playbackState == MprisPlaybackState.Playing
                        interval: 1000
                        repeat: true
                        onTriggered: {
                            root.player.positionChanged();
                        }
                    }
                }

                M.MprisPlayIcon {
                    text: "skip_next"
                    onPressed: {
                        if (root.player == null)
                            return;

                        root.player.next();
                    }
                }
            }
        }
    }
}
