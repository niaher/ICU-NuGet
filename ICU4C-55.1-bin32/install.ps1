param($installPath, $toolsPath, $package, $project)

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