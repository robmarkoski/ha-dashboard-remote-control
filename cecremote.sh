#!/bin/bash

while read oneline
do
    keyline=$(echo $oneline | grep " key ")
    #echo $keyline --- debugAllLines
    if [ -n "$keyline" ]; then
        strkey=$(grep -oP '(?<=sed: ).*?(?= \()' <<< "$keyline") #bla bla key pres-->sed: >>previous channel<< (<--123)
        strstat=$(grep -oP '(?<=key ).*?(?=:)' <<< "$keyline") #bla bla -->key >>pressed<<:<-- previous channel (123)
        strpressed=$(echo $strstat | grep "pressed")
        strreleased=$(echo $strstat | grep "released")
        if [ -n "$strpressed" ]; then
            strid=$(grep -oP '(\[ ).*?(\])' <<< "$keyline") # get the id from the debug line to ingnore dupe detection.
            # echo "STRKEY"
            # echo $strkey
            if [ "$strid" != "$strlastid" ]; then
                case "$strkey" in
                    "previous channel")
                        xdotool key "Return" #Enter
                        ;;

                    "up")
                        xdotool key "Shift+Tab" # Move Backward Through Tab Index
                        ;;
                    "down")
                        xdotool key "Tab" # Move Forward Through Tab Index
                        ;;
                    "left")
                        xdotool key "Shift+Tab" # Move Backward Through Tab Index
                        ;;
                    "right")
                        xdotool key "Tab" # Move Forward Through Tab Index
                        ;;
                    "select")
                        xdotool key "Return" # Select Item
                        ;;
                    "return")
                        xdotool key "Alt+Left" # Go Back a Page
                        ;;
                    "exit")
                        echo Key Pressed: EXIT # Maybe Habe this reload home dashboard?
                        ;;
                        # Future Functions
                    # "F2")
                    #     chromium-browser "https://www.youtube.com" &
                    #     ;;
                    # "F3")
                    #     chromium-browser "https://www.google.com" &
                    #     ;;
                    # "F4")
                    #     echo Key Pressed: YELLOW C
                    #     ;;
                    # "F1")
                    #     chromium-browser --incognito "https://www.google.com" &
                    #    ;;
                    # "rewind")
                    #     echo Key Pressed: REWIND
                    #     ;;
                    # "pause")
                    #     echo Key Pressed: PAUSE
                    #     ;;
                    # "Fast forward")
                    #     echo Key Pressed: FAST FORWARD
                    #     ;;
                    # "play")
                    #     echo Key Pressed: PLAY
                    #     ;;
                    # "stop")
                    #     echo Key Pressed: STOP
                    #    ;;
                    # Future Functions
                    # "channel up")
                    #     xdotool click 4 #mouse scroll up
                    #     ;;
                    # "channel down")
                    #     xdotool click 5 #mouse scroll down
                    #     ;;
                    # "channels list")
                    #     xdotool click 3 #right mouse button click"
                    #     ;;
                    *)
                        echo Unrecognized Key Pressed: $strkey ; CEC Line: $keyline
                        ;;
                        
                esac
            #else
                #echo Ignoring key $strkey with duplicate id $strid
            fi
            # store the id of the keypress to check for duplicate press count.
            strlastid=$strid
        fi
    fi
done
