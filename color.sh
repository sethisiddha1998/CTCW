#!/bin/bash

cd ~/Repos/CTCW/

# 利用中国传统色创建纯色壁纸,脚本待完成。
# Create solid color wallpapers with Chinese troditional colors. (unfinished)
rm -r Hex
rm -r Name
rm -r Solid
mkdir {Hex,Name,Solid}

cat Colors | while read line
do      
        typeset -u hex
        hex=`echo $line|cut -d"," -f1`
        name=`echo $line|cut -d"," -f2`
        lname=`LANG=zh_CN.utf-8;echo "$name"|wc -L`
        echo "|$name| : $lname"
        pinyin=`echo $line|cut -d"," -f3`
        file=$pinyin".png"
        echo "|$file|"
        hexT=${hex:0:7}
        (( hexR=0x${hex:1:2} ))
        (( hexR=0x${hex:3:4} ))
        (( hexR=0x${hex:5:6} ))
        
        
        fll="#ffffff"
        if [[ $hexR -ge 130 ]] || [[ $hexG -ge 130 ]] || [[  $hexB -ge 130 ]];then
                fll="#000000"
        fi
        nameT=$name
        nameT=''
        for (( i=0;i<$lname/2;i=i+1 ));do
            nameT=$nameT${name:i:1}\\n
        done
        nameT="﹁\n"$nameT"﹂"
        echo "nameT : $nameT"
        convert -size 1920x1080 xc:$hexT Solid/$file
        convert Solid/$file -fill $fll -font "SourceHanSerif-Regular.ttc"\
                -pointsize 100 \
                -annotate +1740+100 $nameT\
                -interline-spacing 100\
                 -interword-spacing 1\
                Name/$file
	echo "添加名字"
        convert Name/$file -fill $fll -font "monof55.ttf"\
                -pointsize 60 \
                -annotate +1500+150 $hex\
                Hex/$file
done
