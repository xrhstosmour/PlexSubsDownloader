# PlexSubsDownloader
This linux service, was created due to Plex's problem with Greek subtitles. In my personal configuration when a new folder is beeing created inside Plex Media Server library, the service sleeps for 30 seconds till the procedure completes and then gets all the files of the directory. For every file, with video extension, searches for subtitiles at the [opensubtitles.org](https://www.opensubtitles.org/). 

The project is based on:
* [inotify-tools/inotify-tools](https://github.com/inotify-tools/inotify-tools) inotify-tools is a C library and a set of command-line programs providing a simple interface to inotify. https://github.com/inotify-tools/inotify-tools/wiki.
* [emericg/OpenSubtitlesDownload](https://github.com/emericg/OpenSubtitlesDownload) Automatically find and download the right subtitles for your favorite videos! https://emeric.io/OpenSubtitlesDownload.

For the Plex Media Server, documentation can be found [here](https://wiki.archlinux.org/index.php/plex).

For the linux service, documentation can be found [here](https://arashmilani.com/post?id=86).

## Prerequisites
The only prerequisite for the app execution is a linux server with installed and configured Plex Media Server and a registration at the [opensubtitles.org](https://www.opensubtitles.org/).

## Configuration
autoDownloadSubs.sh file for the path settings:
1. Change variable [path](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/autoDownloadSubs.sh#L3) to the watching directory you prefer. For our occasion this is, the Plex Media Server library.
2. Change variable [pythonScriptPath](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/autoDownloadSubs.sh#L4) to the path you are going to store the [OpenSubtitlesDownload.py](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py) script.

OpenSubtitlesDownload.py file for the path settings:
1. Change [osd_username](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py#L63) and [osd_password](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py#L64) with the credentials you used for the opensubtitles.org registration.
2. Change [opt_languages](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py#L73) with the 3 digit ISO 639-2 language codes you want to use for your subtitles. For Greek language code ``ell`` should be used.
3. At [Language extension settings](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py#L77-L78) file has been modified in order to support Plex's subtitles configuration. 

## Installation:
1. First get all the scripts to your server and configure them as above. 
2. Move the [autoSubs.service](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/autoSubs.service) file to the service folder on your linux machine. For instance if you are using arch-linux this should be ``/etc/systemd/system``.
3. Move the [OpenSubtitlesDownload.py](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/OpenSubtitlesDownload.py) script to the [pythonScriptPath](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/autoDownloadSubs.sh#L4) you defined on previous steps.
4. Move the [autoDownloadSubs.sh](https://github.com/xrhstosmour/PlexSubsDownloader/blob/master/Scripts/autoDownloadSubs.sh) script to the bin folder of your user at your linux machine. For instance if you are using arch-linux this should be ``/usr/bin/``.
5. Make the script executable by typing ``sudo chmod 755 /usr/bin/autoDownloadSubs.sh``.
6. Start the service by typing ``sudo systemctl start autoSubs.service``.
7. Enable the service by typing ``sudo systemctl enable autoSubs.service``.
