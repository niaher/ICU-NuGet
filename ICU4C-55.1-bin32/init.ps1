param($installPath, $toolsPath, $package, $project)

# Download zip with binaries from icu-project.org.
$zipPath = "$toolsPath\ICU4C.zip"

if (!(Test-Path $zipPath))
{
	$zipUrl = 'http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip';

	Write-Host "Downloading $zipUrl. This might take a few minutes."

	Invoke-WebRequest $zipUrl -OutFile $zipPath

	# Define where the zip will be extracted
	$destinationPath = "$toolsPath\ICU4C"
	New-Item -ItemType Directory -Force -Path $destinationPath

	# Extract zip
	$shell_app = new-object -com shell.application
	$zipFile = $shell_app.namespace("$zipPath\icu\bin\")
	$destination = $shell_app.namespace($destinationPath)
	$destination.Copyhere($zipFile.items(), 0x10)
}