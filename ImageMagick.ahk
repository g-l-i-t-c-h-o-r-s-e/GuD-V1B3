#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;ATTENTION!!!
;Get FFmpeg & FFplay from: https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-latest-win32-static.zip
;Get ImageMagick from somwhere like: ftp://ftp.imagemagick.org/pub/ImageMagick/binaries/ImageMagick-7.0.9-8-portable-Q16-x86.zip
;KTHXBYE

IM := "C:\Users\aches\Downloads\ImageMagick-7.0.9-8-portable-Q16-x86\convert.exe"
FFmpeg := "C:\Users\aches\Documents\AHKSCRIPTS\Datamosh-Den\ffmpeg.exe"
FFplay := "C:\Users\aches\Documents\AHKSCRIPTS\Datamosh-Den\ffplay.exe"
WhichOne := "CommenceShakening"


Gui, Color, DDCEE9
Gui, Add, Button, x24 y109 w50 h47 gSelectImage, Input File
Gui Add, Text, x19 y5 w69 h31, % "Background          Color"
Gui Add, Edit, x16 y31 w67 h21 +Center vBackgroundColor, Transparent
Gui Add, Edit, x117 y32 w50 h21 vIterAmount +Center, 6
Gui Add, Text, x120 y6 w44 h26, % "  Frame     Amount"
Gui Add, Text, x24 y59 w52 h14, Spread - X
Gui Add, Text, x116 y59 w56 h14, Spread - Y
Gui Add, Edit, x24 y73 w50 h21 vSpreadX +Center, 3
Gui Add, Edit, x116 y73 w50 h21 vSpreadY +Center, 3
Gui, Add, Button,x119 y108 w50 h24 gLoopIt, Shake it!
Gui Add, Button, x119 y132 w50 h24 gPreMask, Masked!
Gui Show, w200 h162, % "                 GuD-V1B3 - v1.6"
Gui, -sysmenu
Return


SelectImage:
FileSelectFile, InputFile,,,Select Source For Shakening......................................
sleep, 10
InputFile := chr(0x22) . InputFile . chr(0x22)
Return

PreShake:
if (InputFile = "") {
	msgbox, select an input file yo
	Return
}

WhichOne := "CommenceShakening"
goto, LoopIt
Return

PreMask:
if (InputFile = "") {
	msgbox, select an input file yo
	Return
}

WhichOne := "CommenceMaskedShakening"
FileSelectFile, InputFileMask,,,Select The Image Mask......................................
sleep, 10
InputFileMask := chr(0x22) . InputFileMask . chr(0x22)
goto, LoopIt
Return



LoopIt:

gosub, CloseGifMenu
Gui, Submit, NoHide

FileRemoveDir, %FrameDir%, 1
sleep, 10
FrameDir := A_ScriptDir . "\FRAMES"
FileCreateDir, %FrameDir%
sleep, 10
ViewAll := ComSpec . " /c " . " ffplay -i " . FrameDir . "\frame_%04d.png -loop 0"


kms := 0
while kms < IterAmount
{
	kms +=1 ;loop counter
	
	fileVal +=1
	Pack := "0000"
	zeropad := (SubStr(Pack, 1, StrLen(Pack) - StrLen(fileVal)) . fileVal) ;ZeroPadding for filenames
	
	gosub, %WhichOne%
	
	if (A_Index = IterAmount) { ;Stop loop after IterAmount is reached.
		;msgbox, Its Done!
		runwait, %ViewAll%
		
		fileVal := "" ;clear val
		zeropad := "" ;clear val
		kms := "" ;clear val
		
		gosub, FFGIFMenu
		Return
	}
}
Return


CommenceShakening:
Gui, Submit, NoHide
k += 1
m := Mod(k, 4)
s := Floor(m) 

;This is where the shake magic happens.
sleep, 10
cus_presets := ["+" . SpreadX . "+" . SpreadY
                , "+" . SpreadX . "-" . SpreadY
                , "-" . SpreadX . "-" . SpreadY
			 , "-" . SpreadX . "+" . SpreadY]

CustomPreset := cus_presets[s+1]

ShakeCommand := " -page " . CustomPreset .  " -background " . BackgroundColor . " -flatten "
IMCommand := ComSpec . " /c " . IM . " -verbose " . InputFile . " " . ShakeCommand . " " . FrameDir . "\frame_" . zeropad ".png"

;msgbox, %IMCommand%
;IMOutput := ComObjCreate("WScript.Shell").Exec(IMCommand).StdOut.ReadAll()
runwait, %IMCommand%
Return


CommenceMaskedShakening:
Gui, Submit, NoHide
k += 1
m := Mod(k, 4)
s := Floor(m) 

;This is where the shake magic happens.
sleep, 10
cus_presets := ["+" . SpreadX . "+" . SpreadY
                , "+" . SpreadX . "-" . SpreadY
                , "-" . SpreadX . "-" . SpreadY
			 , "-" . SpreadX . "+" . SpreadY]
CustomPreset := cus_presets[s+1]

ShakeCommand := " -page " . CustomPreset .  " -background Transparent -flatten "
IMCommand :=  ComSpec . " /c " . IM . " -verbose " . InputFile . " -mask " InputFileMask " -write mpr:temp1 ( mpr:temp1 " . ShakeCommand . " -write mpr:temp2 ) -composite " . FrameDir . "\frame_" . zeropad ".png"

runwait, %IMCommand%
Return



FFGIFMenu:
Gui Gif2:Destroy
Gui Gif:Color, DDCEE9
Gui Gif:Add, Button, x32 y106 w80 h23 gFFCreateGIF, Create GIF
Gui Gif:Add, Button, x32 y132 w80 h23 gFFCreateAVI, Create AVI
Gui Gif:Add, Edit, x51 y34 w43 h21 vFPS, 60
Gui Gif:Add, CheckBox, x7 y68 w130 h33 vLoopItPls, Loop Forever? (Press Q   to stop compression.)
Gui Gif:Add, Text, x27 y11 w92 h23 +0x200, Output Frame Rate
Gui Gif:Add, Button, x128 y0 w22 h20 gCloseGifMenu, X
Gui Gif:Add, Button, x0 y0 w22 h20 gIMGifMenu, IM
Gui Gif:Show, w150 h162, FFmpeg GIF
Gui Gif:-sysmenu
Return

;This is what I use so I can Datamosh the vibrating image.
FFCreateAVI:
GuiControlGet, LoopItPls
if (LoopItPls = 1) {
	LoopForever := "-loop 1"
}

if (LoopItPls = 0) {
	LoopForever := ""
}

;Crop out empty edges.
CropX := (SpreadX * 2 + 4)
CropY := (SpreadY * 2 + 4)
CropAmount := " -vf crop=in_w-" . CropX . ":in_h-" . CropY

GuiControlGet, FPS
FFCommand := ComSpec . " /c " . FFmpeg . " " . LoopForever . " -r " . FPS . " -i " . FrameDir . "\frame_%04d.png -r " . FPS . " " . CropAmount . " -f avi -c:v huffyuv " . FrameDir . "\output.avi -y"
ViewGIF := ComSpec . " /c " . FFplay . " -i " . FrameDir . "\output.avi -loop 0"

runwait, %FFCommand%
runwait, %ViewGIF%
Return

FFCreateGIF:
Gui, Submit, NoHide
GuiControlGet, LoopItPls
if (LoopItPls = 1) {
	LoopForever := "-loop 1"
}

if (LoopItPls = 0) {
	LoopForever := ""
}

;Crop out empty edges.
CropX := (SpreadX * 2 + 4)
CropY := (SpreadY * 2 + 4)
CropAmount := " -vf crop=in_w-" . CropX . ":in_h-" . CropY

GuiControlGet, FPS
FFCommand := ComSpec . " /c " . FFmpeg . " " . LoopForever . " -r " . FPS . " -i " . FrameDir . "\frame_%04d.png -r " . FPS . " " . CropAmount . " " . FrameDir . "\output.gif -y"
ViewGIF := ComSpec . " /c " . FFplay . " -i " . FrameDir . "\output.gif -loop 0"

runwait, %FFCommand%
runwait, %ViewGIF%
Return


IMGifMenu:
Gui Gif:Destroy
Gui Gif2:Color, DDCEE9
Gui Gif2:Add, Button, x32 y106 w80 h23 gIMCreateGIF, Create GIF
Gui Gif2:Add, Edit, x29 y34 w90 h21 vDelayAmount +Center, 39x1000
Gui Gif2:Add, CheckBox, x7 y68 w130 h33 vLoopItPls, Loop Forever? (Press Q   to stop compression.)
Gui Gif2:Add, Text, x27 y11 w92 h23 +0x200, Output Delay Rate
Gui Gif2:Add, Button, x128 y0 w22 h20 gCloseGifMenu, X
Gui Gif2:Add, Button, x0 y0 w22 h20 gFFGifMenu, FF
Gui Gif2:Show, w150 h147, ImageMagick GIF
Gui Gif2:-sysmenu
GuiControl, Gif2:Disable, LoopItPls
Return

IMCreateGIF:
Gui Gif2:Submit, NoHide
;Need to think of a method for this one.
;GuiControlGet, LoopItPls
;if (LoopItPls = 1) {
;	LoopForever := "-loop 1"
;}

;if (LoopItPls = 0) {
;	LoopForever := ""
;}

;Trims empty edges, +repage needed to fill in transparent spaces/edges.
ShaveX := (SpreadX * 2 + 1)
ShaveY := (SpreadY * 2 + 1)
ShaveAmount := " +repage -shave " . ShaveX . " " ShaveY

IMCommand := ComSpec . " /c " . IM . " " . LoopForever . " -verbose -delay " . DelayAmount . " -dispose previous " . FrameDir . "\frame_*.png -channel rgba -alpha on -loop 0 " . ShaveAmount . " " . FrameDir . "\output.gif"
ViewGIF := ComSpec . " /c " . FFplay . " -i " . FrameDir . "\output.gif -loop 0"

runwait, %IMCommand%
runwait, %ViewGIF%
Return



CloseGifMenu:
if(WinExist("FFmpeg GIF")) {
	Gui, Gif:Destroy
}

if(WinExist("ImageMagick GIF")) {
	Gui, Gif2:Destroy
}
Return

GuiEscape:
GuiClose:
ExitApp
