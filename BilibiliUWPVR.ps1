Param (
    [alias('sourcePath')]
    [string]$bilibilidownload,
    [alias('destinationPath')]
    [string]$destination = "."
)

function findChildDirectory([string]$parentPath) {
  if(Test-Path $parentPath){
      return (Get-ChildItem $parentPath | where {$_.Mode -match '^d' -AND $_.Exists}).FullName
  }else{
      Write-Information "$parentPath 不存在!"
  }
}

function paserJson([string]$filename) {
    if(Test-Path $filename){
        return (Get-Content $filename -Encoding 'UTF8') | ConvertFrom-Json
    }else{
        Write-Information "$filename 不存在!"
    }
 }
 
 function findBilibiliDownladPath(){
     param(
         [string]$parentPath = "$HOME\AppData\Local\Packages",
         [string]$testPath
     )
     $allItem = findChildDirectory($parentPath);
     foreach ($childItem in $allItem) {
         $testPath = "$childItem\LocalCache\BilibiliDownload"
         if(Test-Path $testPath){
             return $testPath
         }
     } 
     return ''
 }

 function findVideoInfo([string]$path) {
     if(Test-Path $path){
         $infoFile = Get-ChildItem $path | where {$_.Name -match '^*.info'}
         return paserJson($infoFile.FullName)
     }
 }

 chcp 65001

 $bilibilidownload = findBilibiliDownladPath

 $childDir = findChildDirectory($bilibilidownload)

 foreach($videoDir in  $childDir){
     $title = (paserJson((Get-ChildItem $videoDir | where{($_.Extension -eq '.dvi')}).FullName)).Title
     $title
     $videoDesPath = "$destination\$title"
     if(-not(Test-Path $videoDesPath)){
         New-Item $videoDesPath -ItemType Directory
     }
     $videoPartDir = findChildDirectory($videoDir)
     [int]$copyIndex = 0
     [int]$copyNums = $videoPartDir.Count
     foreach($videoPartDirItem in $videoPartDir){
         $copyIndex += 1
         [int]$current = ($copyIndex / $copyNums) * 100
         Write-Progress -Activity "Starting..." -PercentComplete 100 -CurrentOperation "$current% Copyed " -Status "Copying..."
        $videoInfo = findVideoInfo($videoPartDirItem)
        $videoPartName = $videoInfo.PartName
        $videoPartNO = $videoInfo.PartNo
        $video = (Get-ChildItem $videoPartDirItem | where{($_.Extension -eq '.mp4') -or ($_.Extension -eq '.flv')})
        [string]$videoSourPath = $video.FullName
        [string]$videoBaseName = $video.BaseName
        [string]$partName = ($video.Name).Replace("$videoBaseName", "$videoPartNO-$videoPartName")
        $partName = "$videoDesPath\$partName"
        Write-Output "$videoSourPath >> $partName"
        if(-not(Test-Path $partName)){
            Copy-Item $videoSourPath $partName
        }
     }
 }

 
