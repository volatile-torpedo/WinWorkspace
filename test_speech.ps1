# Create a SpeechSynthesizer object
Add-Type –AssemblyName System.Speech
$SpeechSynthesizer = New-Object –TypeName System.Speech.Synthesis.SpeechSynthesizer

# Speak the current time
$SpeechSynthesizer.Speak("The current time is $(Get-Date)")