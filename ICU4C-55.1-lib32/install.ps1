param($installPath, $toolsPath, $package, $project)

$solutionDir = $project.FullName | Split-Path -Parent | Split-Path -Parent

# Copy $toolsPath/ICU4C to ~/ICU4C
Copy-Item "$toolsPath\ICU4C" "$solutionDir" -Recurse -Force

# TODO:
# Add "$(SolutionDir)\ICU4C\lib;" to project.LibraryDirectories
# Add "$(SolutionDir)\ICU4C\include;" to project.AdditionalIncludeDirectories
# Add "icudt.lib;icuin.lib;icuio.lib;icule.lib;iculx.lib;icutu.lib;icuuc.lib;" to project.AdditionalDependencies