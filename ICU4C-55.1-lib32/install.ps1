param($installPath, $toolsPath, $package, $project)

function AddValue([string]$current, [string]$addition) {
	if ($current.Contains($addition) -eq $FALSE) {
		return "$current$addition";
	}

	return $current;
}

$solutionDir = $project.FullName | Split-Path -Parent | Split-Path -Parent

# Copy $toolsPath/ICU4C to ~/ICU4C
Copy-Item "$toolsPath\ICU4C" "$solutionDir" -Recurse -Force

$path = $project.FullName
$xmldoc = New-Object System.Xml.XmlDocument
$xmldoc.Load($path)

# Add "$(SolutionDir)\ICU4C\lib;" to project.LibraryDirectories
$nodes = $xmldoc.GetElementsByTagName("LibraryPath")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ';$(SolutionDir)\ICU4C\lib;' }

# Add "$(SolutionDir)\ICU4C\include;" to project.AdditionalIncludeDirectories
$nodes = $xmldoc.GetElementsByTagName("AdditionalIncludeDirectories")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ';$(SolutionDir)\ICU4C\include;' }

# Add "icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;" to project.AdditionalDependencies
$nodes = $xmldoc.GetElementsByTagName("AdditionalDependencies")
$nodes | foreach { $_.InnerText = AddValue $_.InnerText ';icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;' }

$xmldoc.Save($path)