param($installPath, $toolsPath, $package, $project)

$zipUrl = 'http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-Win32-msvc10.zip';

Write-Host "Downloading $zipUrl. This might take a few minutes."

# Download zip with binaries from icu-project.org.
$zipPath = "$toolsPath\ICU4C.zip"
Invoke-WebRequest $zipUrl -OutFile $zipPath

# Define where the zip will be extracted
$destinationPath = "$toolsPath\ICU4C"
New-Item -ItemType Directory -Force -Path $destinationPath

# Extract zip
$shell_app = new-object -com shell.application
$zipFile = $shell_app.namespace("$zipPath\icu\bin\")
$destination = $shell_app.namespace($destinationPath)
$destination.Copyhere($zipFile.items(), 0x10)

$dlls = (
	"icudt55.dll", 
	"icuin55.dll",
	"icuio55.dll", 
	"icule55.dll",
	"iculx55.dll", 
	"icutu55.dll",
	"icuuc55.dll")

foreach ($dll in $dlls) {
	# Add dll "as link" to the project, because we don't want to have 
	# physical copy of the file inside the project directory.
	$project.ProjectItems.AddFromFile("$toolsPath\ICU4C\$dll")

	# Get added project item.
	$item = $project.ProjectItems.Item("$dll")
	
	# set 'Copy To Output Directory' to 'Copy always'	
	$copyToOutput = $item.Properties.Item("CopyToOutputDirectory")
	$copyToOutput.Value = 1
}