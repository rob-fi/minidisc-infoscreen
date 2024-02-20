#!/bin/bash

# This script is a piece of shit by cgi
# mostly written at Disobey 2024.
# Requires picocom be installed


# Poke the serial port

picocom -qrX -b 9600 -f h /dev/ttyUSB0


# Read existing data from text files

track=$( tail -1 track.txt )
track_p1=$( tail -2 track.txt | head -1 )
track_p2=$( tail -3 track.txt | head -1 )
track_p3=$( tail -4 track.txt | head -1 )

disc=$( tail -1 disc.txt )
disc_p1=$( tail -2 disc.txt | head -1 )
disc_p2=$( tail -3 disc.txt | head -1 )
disc_p3=$( tail -4 disc.txt | head -1 )


# Barf out the existing data with pretty boxes etc

padding='                                                        '

echo -e '\033\0143'

echo "┌─────────────────────────── Track ──────────────────────────────┐"
echo "│ Current:                                                       │"

PROC_NAME="${track:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${track_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└────────────────────────────────────────────────────────────────┘"

echo ""

echo "┌──────────────────────────── Disc ──────────────────────────────┐"
echo "│ Current:                                                       │"
PROC_NAME="${disc:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${disc_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└─────────────────────────────────── Hacky af script by cgi ─────┘"


# Begin main loop

while :
do

# Squirt the commands into the serial port and format the return messages, storing them into variables

# For track title
ser_track=$( echo -e "\r\n45900\r\n45901\r\n45902\r\n45903\r\n45904\r\n45905\r\n" | picocom -qrix 300 /dev/ttyUSB0 > /tmp/banana.txt && grep -a CD90 /tmp/banana.txt | strings | sed 's/CD90[0-9]//g' | tr -d '\n' )

# For disc title
ser_disc=$( echo -e "\r\n45700\r\n45701\r\n45702\r\n45703\r\n45704\r\n" | picocom -qrix 300 /dev/ttyUSB0 > /tmp/banana.txt && grep -a CD70 /tmp/banana.txt | strings | sed 's/CD70[0-9]//g' | tr -d '\n' )


# If the track changed since last check, barf out the whole screen with the new track information

if [ "$ser_track" != "$track" ] && [ "$ser_track" != "" ] && [ "$ser_track" != "$ser_disc" ]
then

track=$ser_track

echo "$track" >> track.txt

track_p1=$( tail -2 track.txt | head -1 )
track_p2=$( tail -3 track.txt | head -1 )
track_p3=$( tail -4 track.txt | head -1 )

padding='                                                        '

echo -e '\033\0143'

echo "┌─────────────────────────── Track ──────────────────────────────┐"
echo "│ Current:                                                       │"

PROC_NAME="${track:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${track_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└────────────────────────────────────────────────────────────────┘"

echo ""

echo "┌──────────────────────────── Disc ──────────────────────────────┐"
echo "│ Current:                                                       │"
PROC_NAME="${disc:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${disc_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└─────────────────────────────────── Hacky af script by cgi ─────┘"

echo "$(tail -4 track.txt)" > track.txt

fi


# If the disc changed since last check, barf out the whole screen with the new disc information


if [ "$ser_disc" != "$disc" ]  && [ "$ser_disc" != "" ]
then

disc=$ser_disc

echo "$disc" >> disc.txt

disc_p1=$( tail -2 disc.txt | head -1 )
disc_p2=$( tail -3 disc.txt | head -1 )
disc_p3=$( tail -4 disc.txt | head -1 )

padding='                                                        '

echo -e '\033\0143'

echo "┌─────────────────────────── Track ──────────────────────────────┐"
echo "│ Current:                                                       │"

PROC_NAME="${track:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${track_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${track_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└────────────────────────────────────────────────────────────────┘"

echo ""

echo "┌──────────────────────────── Disc ──────────────────────────────┐"
echo "│ Current:                                                       │"
PROC_NAME="${disc:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "│                                                                │"
echo "│ Previous:                                                      │"

PROC_NAME="${disc_p1:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p2:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"
PROC_NAME="${disc_p3:0:55}"
printf "%s %s  │\n" "│     $PROC_NAME" "${padding:${#PROC_NAME}}"

echo "└─────────────────────────────────── Hacky af script by cgi ─────┘"

echo "$(tail -4 disc.txt)" > disc.txt

fi




sleep 3

done

echo "Guru Meditation"
