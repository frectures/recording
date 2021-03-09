# Schulungen aufzeichnen

> Die Schulung "Schulungen aufzeichnen" wird heute nicht zufällig aufgezeichnet?

![](kreisel.jpg)

## Warum interne Schulungen aufnehmen?

* Zum Nachholen für verhinderte Kollegen
* Selbständige Einarbeitung von Junioren
* Möglichkeit zur Selbstreflexion
* Vorbereitung zukünftiger Durchgänge
* Zukunftsmusik: Werbemittel für die WPS?

## Checkliste

[Northwest Airlines Flight 255](https://www.reddit.com/r/CatastrophicFailure/comments/97s74i)

1. Durchgängiges Bild sicherstellen
   - Stromversorgung überprüfen
   - Energie-Optionen anpassen
   - Bildschirmschoner deaktivieren
2. Inkognito bleiben
   - Browser-Chronik löschen
   - Outlook schließen
   - Desktop aufräumen
3. Audio & Video
   - Eingangspegel regulieren
   - Beamer anschließen
   - Anzeige duplizieren

## Best practices

* Mit dem Laptop reden, nicht mit der Leinwand
* Spontane Diagramme möglichst am Rechner malen
* Tafelbilder laut und ausführlich erläutern
* In großen Sälen: Fragen knapp wiederholen

## mplayer

### Installation

```
sudo apt install mplayer
```

### Webcam einblenden

```
mplayer tv:// -tv driver=v4l2:width=320:height=180 -vf mirror -vo xv -geometry 100%:100% -noborder -ontop
```

## SimpleScreenRecorder

### Installation

SimpleScreenRecorder liegt seit Mitte 2017 in den offiziellen Debian-Repositories:

* Debian
  * Ubuntu
    * Linux Mint
  * Linux Mint Debian Edition

```
sudo apt install simplescreenrecorder
```

Auf beiden Linux Mint Varianten empfiehlt es sich, proprietäre Codecs zu installieren:
```
sudo apt install mint-meta-codecs
```

Falls die Standard-Software des Betriebssystems das aufgezeichnete Video nicht abspielen kann, VLC installieren:
```
sudo apt install vlc
```

### Verwendung

![](0.png)

![](1.png)

![](2.png)

![](3.png)

## ffmpeg

```
sudo apt install ffmpeg
```

https://superuser.com/questions/138331

### Ende abschneiden

```
ffmpeg -i input.mkv -c copy -t 01:02:03.0 output.mkv
```

### Anfang und Ende abschneiden

```
ffmpeg -ss 00:01:23.0 -i input.mkv -c copy -to 01:02:03.0 output.mkv
```

Den Anfang sollte man möglichst an einem Keyframe abschneiden, um sich unnötigen Software-Ärger zu ersparen.

### Keyframes identifizieren

https://stackoverflow.com/questions/18085458

Die Zeitstempel von Keyframes kann `ffprobe` ermitteln:

```
ffprobe -loglevel error -skip_frame nokey -select_streams v:0 -show_entries frame=pkt_pts_time -of csv=print_section=0 input.mkv
```

### Zusammenfügen

https://stackoverflow.com/questions/42859528

```
ffmpeg -f concat -i inputs.txt -c copy output.mkv
```
inputs.txt
```
file a.mkv
file b.mkv
file c.mkv
```

### Audio postprocessing

Die Tastatur-Anschläge verursachen ein unangenehmes Wummern, das man mit 4 Hochpassfiltern eliminiert:
```
ffmpeg -i input.mkv -c:v copy -af \
highpass=frequency=80,\
highpass=frequency=80,\
highpass=frequency=80,\
highpass=frequency=80 output.mp4
```

Zusammenfügen und Audio postprocessing kombiniert:
```
ffmpeg -f concat -i inputs.txt -c:v copy -af \
highpass=frequency=80,\
highpass=frequency=80,\
highpass=frequency=80,\
highpass=frequency=80 output.mp4
```

## YouTube

YouTube unterscheidet drei Sichtbarkeitsstufen:

* Öffentlich
* Nicht gelistet
* Privat

Interne Schulungen sollte man ungelistet hochladen und den Video-Link an die Schulungsteilnehmer rumschicken.
Ohne diesen Link ist das Video auf YouTube nicht auffindbar.
