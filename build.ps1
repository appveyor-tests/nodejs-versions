
Write-Host "Default"
$default_node = (node --version)
$default_node
if(-not $default_node.startsWith($env:expected_default_node)) { throw "Default Node.js version should be $($env:expected_default_node).x" }
  
Write-Host "LTS"
Install-Product node 'LTS'
$lts_node = (node --version)
$lts_node
if(-not $lts_node.startsWith($env:expected_lts_node)) { throw "LTS Node.js version should be $($env:expected_lts_node).x" }
  
Write-Host "Current"
Install-Product node 'Current'
$current_node = (node --version)
$current_node
if(-not $current_node.startsWith($env:expected_current_node)) { throw "Current Node.js version should be $($env:expected_current_node).x" }
  
Write-Host "Stable"
Install-Product node 'Stable'
$stable_node = (node --version)
$stable_node
if(-not $stable_node.startsWith($env:expected_stable_node)) { throw "Stable Node.js version should be $($env:expected_stable_node).x" }
  
Write-Host "Latest 9.x:"
Install-Product node 9
node --version
  
Write-Host "Latest 8.x:"
Install-Product node 8
node --version
  
Write-Host "Latest 6.x:"
Install-Product node 6
node --version
  
Write-Host "Latest 7.x:"
Install-Product node 7
node --version  
  
Write-Host "Latest 4.x:"
Install-Product node 4
node --version  

$versions = @("12.6.0", "11.15.0", "10.16.0", "9.11.2", "8.16.0", "7.10.1", "6.16.0", "4.9.1", "0.12.18")
foreach ($version in $versions){
  Install-Product node $version
  $nv = node -v
  $File = $version + ".txt"
  $out = $env:appveyor_build_folder + $File
  $nv | Out-File $File
  if ($nv -eq ("v" + $version)){
    Write-Host "Correct version"
  }
  else{
    exit 1
  }
  Start-Sleep -s 1
}
if($LastExitCode -ne 0) { $host.SetShouldExit($LastExitCode) }
