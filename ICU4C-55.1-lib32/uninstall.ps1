param($installPath, $toolsPath, $package, $project)

$solutionDir = $project.FullName | Split-Path -Parent | Split-Path -Parent

Remove-Item "$solutionDir\ICU4C" -Recurse -Force

$path = $project.FullName
$xmldoc = New-Object System.Xml.XmlDocument
$xmldoc.Load($path)

# Remove "$(SolutionDir)\ICU4C\lib;" from project.LibraryDirectories
$nodes = $xmldoc.GetElementsByTagName("LibraryPath")
$nodes | foreach { $_.InnerText = $_.InnerText.Replace(';$(SolutionDir)\ICU4C\lib;', '') }

# Add "$(SolutionDir)\ICU4C\include;" to project.AdditionalIncludeDirectories
$nodes = $xmldoc.GetElementsByTagName("AdditionalIncludeDirectories")
$nodes | foreach { $_.InnerText = $_.InnerText.Replace(';$(SolutionDir)\ICU4C\include;', '') }

# Add "icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;" to project.AdditionalDependencies
$nodes = $xmldoc.GetElementsByTagName("AdditionalDependencies")
$nodes | foreach { $_.InnerText = $_.InnerText.Replace(';icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;', '') }

$xmldoc.Save($path)