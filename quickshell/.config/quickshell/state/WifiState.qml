pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

import "../config" as C

Singleton {
    id: root

    property bool wifiEnabled: false

    // ssid, security, active, bars
    property var wifiStations: []
    property string lastWifiScanResult: ""

    property var pendingNmcliCommands: []
    property bool pendingNmcliScan: false

    property bool wifiScanning: true

    function disconnect(ssid) {
        // FIXME: this will break with named stations I think...
        pendingNmcliCommands = [["nmcli", "c", "down", ssid], ...pendingNmcliCommands];
    }

    function connect(ssid) {
        pendingNmcliCommands = [["nmcli", "device", "wifi", "connect", ssid, "--ask"], ...pendingNmcliCommands];
    }

    function setWifiEnabled(on) {
        if (on == wifiEnabled)
            return;

        wifiEnabled = on;
        pendingNmcliCommands = [["nmcli", "radio", "wifi", on ? "on" : "off"], ...pendingNmcliCommands];
        pendingNmcliScan = true;

        wifiStations = [];
    }

    function refreshWifi() {
        console.log("Wifi refresh running twice");
        if (nmcliListProc.running)
            return;

        if (!wifiEnabled) {
            wifiStations = [];
            return;
        }

        nmcliListProc.running = true;
        wifiScanning = true;
    }

    function splitEscaped(str, sep = ':', esc = '\\') {
        const out = [];
        let current = '';
        let escaped = false;

        for (const ch of str) {
            if (escaped) {
                current += ch;
                escaped = false;
            } else if (ch == esc)
                escaped = true;
            else if (ch == sep) {
                out.push(current);
                current = '';
            } else
                current += ch;
        }
        out.push(current);
        return out;
    }

    Process {
        id: updateNmcliProc
        running: false

        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                ; // doesn't get called most of the time due to no stdout
            }
        }
    }

    Process {
        id: nmcliListProc
        running: true

        command: ["nmcli", "--terse", "dev", "wifi", "list"]

        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                wifiScanning = false;

                // FIXME: this will still change quite often due to signal. Maybe only compare the things we get.
                if (lastWifiScanResult == data)
                    return;

                lastWifiScanResult = data;

                const lines = data.split("\n");
                wifiStations = [];
                let activeStation = null;
                for (let line of lines) {
                    const lineParsed = splitEscaped(line);

                    if (lineParsed.length < 9)
                        continue;

                    let s = {};

                    s.active = lineParsed[0] == "*";
                    s.ssid = lineParsed[2];
                    s.security = lineParsed[8];
                    s.bars = 4 - (lineParsed[7].match(/\_/g) || []).length;
                    s.bssid = lineParsed[1];

                    if (s.ssid == "")
                        continue;

                    let wifiStationNames = wifiStations.map(x => x.ssid);
                    if (s.active)
                        activeStation = s;
                    if (wifiStationNames.includes(s.ssid)) {
                        let index = wifiStationNames.indexOf(s.ssid);
                        if (s.active) {
                            wifiStations[index] = s;
                        }
                    } else {
                        wifiStations = [...wifiStations, s];
                    }
                }
            }
        }
    }

    Timer {
        id: nmcliListTimer
        running: wifiEnabled
        onTriggered: {
            if (!nmcliListProc.running)
                nmcliListProc.running = true;
        }
    }

    Timer {
        id: updateNmcliTimer
        repeat: true
        running: pendingNmcliCommands.length > 0
        interval: 100

        onTriggered: {
            if (updateNmcliProc.running)
                return;

            updateNmcliProc.command = pendingNmcliCommands[0];
            updateNmcliProc.running = true;

            pendingNmcliCommands = pendingNmcliCommands.slice(1);

            if (pendingNmcliCommands.length == 0 && pendingNmcliScan) {
                pendingNmcliScan = false;
                refreshWifi();
            }
        }
    }

    Process {
        id: checkWifiEnabledState
        running: true
        command: ["nmcli", "radio", "wifi"]

        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                wifiEnabled = data.indexOf("enabled") != -1;
            }
        }
    }
}
