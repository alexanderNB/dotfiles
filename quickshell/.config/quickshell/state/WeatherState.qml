pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

import "../config" as C

Singleton {
    id: root

    property string location: "?"
    property string icon: "sunny"
    property string temp: "26°"

    property string lastLocation: ""
    property string fallbackLocation: "Copenhagen"

    Process {
        id: cityProc
        running: true
        command: ["sh", "-c", "curl -s ipinfo.io/city"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                root.lastLocation = data;
            }
        }
        onRunningChanged: {
            if (!running) {
                weatherProc.running = true;
            }
        }
    }

    Process {
        id: weatherProc
        running: false
        command: ["sh", "-c", "curl -s \"wttr.in/" + (lastLocation != "" ? lastLocation : fallbackLocation) + "?format=%c|%t|%C|%f|%m|%p|%l\""]

        stdout: SplitParser {
            splitMarker: ""
            onRead: data => {
                const RETS = data.split("|");
                console.log("got weather");

                location = "Unknown";

                if (RETS.length < 5)
                    return;

                location = RETS[6];
                temp = RETS[1][0] == "+" ? RETS[1].substr(1) : RETS[1];

                RETS[2] = RETS[2].toLowerCase();

                if (RETS[2] == "clear" || RETS[2] == "sunny")
                    icon = "sunny";
                else if (RETS[2] == "partly cloudy")
                    icon = "partly_cloudy_day";
                else if (RETS[2] == "cloudy" || RETS[2] == "overcast")
                    icon = "cloud";
                else if (RETS[2] == "mist" || RETS[2] == "fog" || RETS[2] == "freezing fog")
                    icon = "Foggy";
                else if (RETS[2].indexOf("rain") != -1 || RETS[2].indexOf("drizzle") != -1)
                    icon = "rainy";
                else if (RETS[2].indexOf("snow") != -1)
                    icon = "weather_snowy";
                else if (RETS[2].indexOf("hunder") != -1)
                    icon = "thunderstorm";
                else if (RETS[2] == "ice pellets")
                    icon = "weather_hail";
                else {
                    console.log("Weather is " + RETS[2] + ", which we don't know an icon for.");
                    icon = "question_mark";
                }
            }
        }
    }

    Timer {
        repeat: true
        running: true
        interval: 1000 * 60 * 10 // 10 mins

        onTriggered: {
            if (!cityProc.running)
                cityProc.running = true;
        }
    }
}
