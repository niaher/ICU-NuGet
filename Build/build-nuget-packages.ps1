param (
	[Parameter(Mandatory=$false)]
	[string]$Project
)

function Build-Packages
{
	param (
		[Parameter(Mandatory=$false)]
		[string]$Project
	)

	$projects = ("ICU4C-55.1-bin32\ICU4C-55.1-bin32.nuspec")

	# Remove previously built packages.
	Remove-Item *.nupkg

	# Get solution directory.
	$solutionDir = Split-Path $dte.Solution.FileName -Parent
	$currentDir = "$solutionDir\Build"

	# Get NuGet handle.
	$nuget = "$solutionDir\.nuget\NuGet.exe"

	foreach ($project in $projects | where {$_ -like "*$Project*"})
	{
		Write-Host "`r`nBuilding '$project' package..." -ForegroundColor 'green' -BackgroundColor 'black'

		# Make sure .nuspec file exists.
		cd $solutionDir
		&$nuget spec -Verbosity quiet
		cd $currentDir

		# Build package.
		&$nuget pack "$solutionDir\$project" `
			-OutputDirectory "$currentDir" `
			-Properties Configuration=Release
	}
}

Build-Packages -Project $Project