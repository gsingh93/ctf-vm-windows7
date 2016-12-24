# choco install -y procmon
# choco install -y procexp
# choco install -y windbg
# choco install -y wireshark
# choco install -y googlechrome
# choco install -y notepadplusplus
# choco install -y visualstudiocommunity2013

# TODO: x64dbg, office

function Get-ComFolderItem() {
    [CMDLetBinding()]
    param(
        [Parameter(Mandatory=$true)] $Path
    )

    $ShellApp = New-Object -ComObject 'Shell.Application'
    $Item = Get-Item $Path -ErrorAction Stop

    if ($Item -is [System.IO.FileInfo]) {
        $ComFolderItem = $ShellApp.Namespace($Item.Directory.FullName).ParseName($Item.Name)
    } elseif ($Item -is [System.IO.DirectoryInfo]) {
        $ComFolderItem = $ShellApp.Namespace($Item.Parent.FullName).ParseName($Item.Name)
    } else {
        throw "Path is not a file nor a directory"
    }

    return $ComFolderItem
}

function Install-TaskBarPinnedItem() {
    [CMDLetBinding()]
    param(
        [Parameter(Mandatory=$true)] [System.IO.FileInfo] $Item
    )

    $Pinned = Get-ComFolderItem -Path $Item
    $Pinned.invokeverb('taskbarpin')
}

function Uninstall-TaskBarPinnedItem() {
    [CMDLetBinding()]
    param(
        [Parameter(Mandatory=$true)] [System.IO.FileInfo] $Item
    )

    $Pinned = Get-ComFolderItem -Path $Item
    $Pinned.invokeverb('taskbarunpin')
}

$UnpinItems = @(
    "${env:ProgramFiles(x86)}\Windows Media Player\wmplayer.exe",
    "${env:ProgramFiles(x86)}\Internet Explorer\iexplore.exe"
)
foreach($Item in $UnpinItems) {
    $Path = Get-Command $Item | Select-Object -First 1 -ExpandProperty Definition
    Uninstall-TaskBarPinnedItem -Item $Path
}

$PinnedItems = @(
    'powershell.exe',
    "${env:ProgramFiles}\Notepad++\notepad++.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
)
foreach($Item in $PinnedItems) {
    $Path = Get-Command $Item | Select-Object -First 1 -ExpandProperty Definition
    Install-TaskBarPinnedItem -Item $Path
}
