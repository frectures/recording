ffmpeg -y -i video.mkv -i clean.wav -c:v copy -c:a aac -af acompressor=threshold=0.25:ratio=4:attack=3:release=100:makeup=2 output.mp4
