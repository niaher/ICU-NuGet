param($installPath, $toolsPath, $package, $project)

function AddValue([string]$current, [string]$addition) {
	if ($current.Contains($addition) -eq $FALSE) {
		return "$current$addition";
	}

	return $current;
}

$solutionDir = $project.FullName | Split-Path -Parent | Split-Path -Parent

# Get relative path to "$toolsPath\ICU4C"
Push-Location
Set-Location $solutionDir
$icu4cDir = (Resolve-Path -Relative "$toolsPath\ICU4C").Replace(".\", '$(SolutionDir)\')
Pop-Location

# Open project file as xml document
$path = $project.FullName
$xmldoc = New-Object System.Xml.XmlDocument
$xmldoc.Load($path)

# Add "$(SolutionDir)\ICU4C\lib;" to project.LibraryDirectories
$nodes = $xmldoc.GetElementsByTagName("LibraryPath")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ";$icu4cDir\lib;" }

# Add "$(SolutionDir)\ICU4C\include;" to project.AdditionalIncludeDirectories
$nodes = $xmldoc.GetElementsByTagName("AdditionalIncludeDirectories")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ";$icu4cDir\include;" }

# Add "icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;" to project.AdditionalDependencies
$nodes = $xmldoc.GetElementsByTagName("AdditionalDependencies")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ';icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;' }

$xmldoc.Save($path)