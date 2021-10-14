ffmpeg -y -i $1 -map 0:v -c:v copy video.mkv -map 0:a -c:a copy noisy.wav
