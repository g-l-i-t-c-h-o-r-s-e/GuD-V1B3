# This tool is useful for making memes, or in my case, turning still images into a great source for datamoshing.

![img3](https://i.imgur.com/dzcncwD.png)

# Requirements:
Get FFmpeg & FFplay from: https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-latest-win32-static.zip                          
Get ImageMagick from somwhere like:                                                                   
ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.9-8-portable-Q16-x86.zip

For now, you need to set the first few variables in the script to point at the folder that contains FFmpeg, FFplay and convert.          
Specifically:
```
IM :=
FFmpeg :=
FFplay :=
```

# Examples:
![img1](https://i.imgur.com/hVcyxxL.gif)
Just a regular image vibrated, with 3 frames.

![img2](https://i.imgur.com/PNE84w7.gif)
As you can see, transparency is also supported.

# Masks:
You can use a custom mask to define which area you want to vibrate, instead of the entire image.                                          
                                                                                                                       
Custom Mask:                            
![img2](https://i.imgur.com/OIekf6w.png)

Original:                             
![img2](https://i.imgur.com/unRcJyr.png)

Final GIF: not the best exmaple but I think you get the point.
![img2](https://i.imgur.com/P1MRCCZ.gif)



