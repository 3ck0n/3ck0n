# 
# Audio Switch
# Switch through all audio channels which are used for playback by executing this script.
# 
# To switch your music between external speaker and your headset needs 3 clicks in Windows 11. 
# This script automatically changes the output audio to the next channel, just execute until 
# your favorite channel is used. 
#
# You can simply bind this script to a button or define a key shortcut to execute the script.


# Get audio output device used for playback
$audioDevices = Get-AudioDevice -list | Where-Object -Property Type -eq "Playback"

# Device channel currently used
$currentAudioDevice = Get-AudioDevice -Playback

# Identify the current channel in the devices list
$foundObj = $audioDevices | Where-Object { $_.Index -eq $currentAudioDevice.Index }
$foundIndex = $audioDevices.IndexOf($foundObj)

# Find index of next channel or start again at index 0
$nextIndex = ($foundIndex + 1) % $audioDevices.Count
$nextAudioDevice = $audioDevices[$nextIndex]

Write-Host "Switch Audio output to $($nextAudioDevice.Name)."

# Set the next audio device
Set-AudioDevice $nextAudioDevice.Index