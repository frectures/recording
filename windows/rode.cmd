ffmpeg -y -i video.mkv -i clean.wav -c:v copy -c:a aac -af acompressor=threshold=0.125:ratio=4:attack=3:release=100:makeup=4 output.mp4
