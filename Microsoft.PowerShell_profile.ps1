Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -EditMode vi

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

New-Alias -Name vi -Value 'C:\Program Files (x86)\vim\vim82\vim.exe'
New-Alias -Name vim -Value 'C:\Program Files (x86)\vim\vim82\vim.exe'
