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

Eingabe in Video und Audio auftrennen, dabei Frequenzen bis 80 Hz und ab 5 kHz dämpfen:
```
ffmpeg -i input.mkv -map 0:v -c:v copy video.mkv -map 0:a -af \
highpass=frequency=80,lowpass=frequency=5000 noisy.wav
```
Das Samson Meteor schlägt bei Harmonischen von 1 kHz aus, diese sollte man ebenfalls dämpfen:
```
ffmpeg -i input.mkv -map 0:v -c:v copy video.mkv -map 0:a -af \
equalizer=frequency=1000:width_type=h:width=10:gain=-12,\
equalizer=frequency=2000:width_type=h:width=10:gain=-12,\
equalizer=frequency=3000:width_type=h:width=10:gain=-10,\
equalizer=frequency=4000:width_type=h:width=10:gain=-8,\
equalizer=frequency=5000:width_type=h:width=10:gain=-6,\
highpass=frequency=80,lowpass=frequency=5000 noisy.wav
```
![](meteor.png)

Rauschen entfernen:
* `noisy.wav` in Audacity öffnen
* Ein paar Sekunden rauschender Stille markieren
* Effekt / Rausch-Verminderung...
  * Rauschprofil ermitteln
* Alles markieren
* Effekt / Rausch-Verminderung...
  * Rauschverminderung (db): 24
  * Empfindlichkeit: 6,00
  * Frequenz-Glättung (Bänder): 3
  * Rauschen: (*) Vermindern
  * OK
* Datei / Exportieren / Als WAV exportieren
  * Name: `clean.wav`
  * Speichern
  * OK

Bereinigtes Audio komprimieren und mit Video zusammenführen:
```
ffmpeg -i video.mkv -i clean.wav -c:v copy -c:a aac output.mp4
```

## YouTube

YouTube unterscheidet drei Sichtbarkeitsstufen:

* Öffentlich
* Nicht gelistet
* Privat

Interne Schulungen sollte man ungelistet hochladen und den Video-Link an die Schulungsteilnehmer rumschicken.
Ohne diesen Link ist das Video auf YouTube nicht auffindbar.
