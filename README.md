This tool is useful for making memes, or in my case, turning still images into a great source for datamoshing.

![img3](https://i.imgur.com/FNtYtUo.png)

# Requirements:
[AutoHotkey](https://www.autohotkey.com/download/ahk-install.exe)                                       
Get FFmpeg & FFplay from: https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-latest-win32-static.zip                          
Get ImageMagick from somwhere like:                                                                   
`ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.9-8-portable-Q16-x86.zip`
                                                                   
https://web.archive.org/web/20201012195158/https://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.0.9-8-portable-Q16-x86.zip
                                                                   
https://web.archive.org/web/20201012195222/https://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.0.9-8-portable-Q16-x64.zip

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
Use the IM button if you want to make an ImageMagick GIF (without dithering).

Oh and I just added random mode now, so you can either make it use random values in between a given set of numbers and still use a radial (or circle) pattern, or use the radio buttons on the Random Menu to set it to `Truly Random Mode`.
![img2](https://i.imgur.com/lrgPzfG.gif)


# Masks:
You can use a custom mask to define which area you want to vibrate, instead of the entire image.                                          
                                                                                                                       
Custom Mask:                            
![img2](https://i.imgur.com/OIekf6w.png)

Original:                             
![img2](https://i.imgur.com/unRcJyr.png)

Final GIF: not the best example but I think you get the point, damn she look cold tho.
![img2](https://i.imgur.com/P1MRCCZ.gif)


# Datamoshing?
oh, yeah you can also use the AVI option (and loop forever if u need) to turn the gif into an AVI that you can use as a source.             
This is the type of results you can get:
![img2](https://i.imgur.com/2ILgk4k.jpg)                                                                
Or These:                                                                                                               
https://streamable.com/t4vwe                                                                                             
https://streamable.com/nlr6b                                                                             
https://streamable.com/eu98v                                

You can find out more about Datamoshing: [here](http://glitchet.com/resources)                                                                                  
My favorite script to Datamosh with is: [here](https://github.com/itsKaspar/tomato)

