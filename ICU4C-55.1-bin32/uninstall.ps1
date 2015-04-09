param($installPath, $toolsPath, $package, $project)

$solutionDir = $project.FullName | Split-Path -Parent | Split-Path -Parent

$dlls = (
	"icudt55.dll", 
	"icuin55.dll",
	"icuio55.dll", 
	"icule55.dll",
	"iculx55.dll", 
	"icutu55.dll",
	"icuuc55.dll")

foreach ($dll in $dlls) {
	$project.ProjectItems.Item("$dll").Remove()
}