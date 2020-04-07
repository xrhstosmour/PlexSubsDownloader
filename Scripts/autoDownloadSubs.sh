#!/bin/sh
# Paths for monitoring and executing the python script.
path="path/for/plex/library"
pythonScriptPath='path/for/OpenSubtitlesDownload/script/'

# -m to monitor the dir indefinitely and -e create is for creation mode.
inotifywait -m -e create --format '%w%f' "${path}" | while read newFile; do
    if [[ -d ${newFile} ]]; then
        echo "Folder $(basename -- "${newFile}") created!"

        # Sleep 30 seconds so as to let all the files from transmission to be moved.
        sleep 30

        # Set IFS in order to avoid problem with spaces in folders or files.
        IFS=$'\n'
        
        # Get all the files inside the folder adn store them to an array.
        files=($(find ${newFile//:/\/ } -type f))

        # Loop over it and search for subtitles.
        for folderFile in ${files[@]}; do
            # file command is problematic with video types, so we are going to search through extensions.
            if [[ "${folderFile##*.}" == "mkv" || "${folderFile##*.}" == "wmv" || "${folderFile##*.}" == "mp4" || "${folderFile##*.}" == "avi" ]]; then
                ${pythonScriptPath}OpenSubtitlesDownload.py --cli --auto "${folderFile}"
            fi
        done
    fi
done
