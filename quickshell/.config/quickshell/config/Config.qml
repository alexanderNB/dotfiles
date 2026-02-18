pragma Singleton

import QtQuick
import QtCore
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    function epochSecondsToHuman(sec) {
        if (sec < 10)
            return "None";

        const date = new Date(sec * 1000);
        return formatDateTime(date);
    }

    function romanize(num) {
        if (isNaN(num))
            return NaN;
        var digits = String(+num).split(""), key = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM", "", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC", "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"], roman = "", i = 3;
        while (i--)
            roman = (key[+digits.pop() + (i * 10)] || "") + roman;
        return Array(+digits.join("") + 1).join("M") + roman;
    }

    function formatDateTimeSplit(dateTime) {
        return [Qt.formatDateTime(dateTime, root.splitDateFormat[0]), Qt.formatDateTime(dateTime, root.splitDateFormat[1])];
    }

    function secondsToRelative(sec) {
        if (sec < 60)
            return "A minute ago";
        if (sec < 3600)
            return "" + parseInt(sec / 60) + " minute" + (parseInt(sec / 60) == 1 ? "" : "s") + " ago";
        if (sec < 3600 * 24)
            return "" + parseInt(sec / 3600) + " hour" + (parseInt(sec / 3600) == 1 ? "" : "s") + " ago";
        return "" + parseInt(sec / (3600 * 24)) + " day" + (parseInt(sec / (3600 * 24)) == 1 ? "" : "s") + " ago";
    }

    function applyBaseOpacity(col) {
        if (settings.panels.transparent)
            return Qt.rgba(col.r, col.g, col.b, settings.panels.baseOpacity);
        return col;
    }

    function applySecondaryOpacity(col) {
        if (settings.panels.transparent)
            return Qt.rgba(col.r, col.g, col.b, 0.35);
        return col;
    }

    property var font: ({
            main: "JetBrainsMono Nerd Font",
            symbol: "Material Symbols Outlined"
        })

    property var fontSize: ({
            tiny: 16,
            small: 18,
            normal: 20,
            large: 22,
            huge: 24,
            tinySymbol: 23,
            smallSymbol: 25,
            normalSymbol: 27,
            largeSymbol: 29,
            hugeSymbol: 31
        })

    property var bar: ({
            lowBattery: 20,
            height: 80,
            color: root.colors.bg_dark,
            centerFontSize: root.fontSize.normal,
            sideFontSize: root.fontSize.normal,
            centerTopMargin: 10,
            sideTopMargin: 5,
            sideSideMargin: 10,
            seperatorSize: 12
        })

    property string dateFormat: "d MMM yyyy hh:mm"
    property var splitDateFormat: ["d MMM yyyy", "hh:mm:ss"]

    property var anim_CURVE_SMOOTH_SLIDE: [0.23, 1, 0.32, 1, 1, 1]
    property var anim_CURVE_ALMOST_LINEAR: [0.5, 0.5, 0.75, 1, 1, 1]

    property int anim_FAST: 130
    property int anim_MEDIUM: 240
    property int anim_SLOW: 400

    // function getSplitConfigDateFormat() {
    //     if (settings.misc.dateFormat == 0)
    //         return ["d MMM yyyy", "hh:mm:ss"];
    //     if (settings.misc.dateFormat == 1)
    //         return ["dd/MM/yyyy", "hh:mm:ss"];
    //     if (settings.misc.dateFormat == 2)
    //         return ["dd/MM/yyyy", "hh:mm:ss AP"];
    //     if (settings.misc.dateFormat == 3)
    //         return ["MM/dd/yyyy", "hh:mm:ss AP"];
    //     if (settings.misc.dateFormat == 4)
    //         return ["ddd, d MMM yyyy", "hh:mm:ss AP"];
    // }
    //
    // function getConfigDateFormat() {
    //     if (settings.misc.dateFormat == 0)
    //         return "d MMM yyyy hh:mm";
    //     if (settings.misc.dateFormat == 1)
    //         return "dd/MM/yyyy hh:mm";
    //     if (settings.misc.dateFormat == 2)
    //         return "dd/MM/yyyy hh:mm AP";
    //     if (settings.misc.dateFormat == 3)
    //         return "MM/dd/yyyy hh:mm AP";
    //     if (settings.misc.dateFormat == 4)
    //         return "ddd, d MMM yyyy hh:mm AP";
    // }

    property int osdTimeoutDuration: 700
    property int notificationTimeoutDuration: 5000

    property var colors: ({
            bg: "#1a1b26",
            bg_dark: "#16161e",
            bg_dark1: "#0C0E14",
            bg_highlight: "#292e42",
            blue: "#7aa2f7",
            blue0: "#3d59a1",
            blue1: "#2ac3de",
            blue2: "#0db9d7",
            blue5: "#89ddff",
            blue6: "#b4f9f8",
            blue7: "#394b70",
            comment: "#565f89",
            cyan: "#7dcfff",
            dark3: "#545c7e",
            dark5: "#737aa2",
            fg: "#c0caf5",
            fg_dark: "#a9b1d6",
            fg_gutter: "#3b4261",
            green: "#9ece6a",
            green1: "#73daca",
            green2: "#41a6b5",
            magenta: "#bb9af7",
            magenta2: "#ff007c",
            orange: "#ff9e64",
            purple: "#9d7cd8",
            red: "#f7768e",
            red1: "#db4b4b",
            teal: "#1abc9c",
            terminal_black: "#414868",
            yellow: "#e0af68"
        })
}
