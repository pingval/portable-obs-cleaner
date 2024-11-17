[CmdletBinding()]
Param([string]$obsDir)
$VerbosePreference="Continue"

Set-Variable -name CONST -option Constant -Value @{
  batFilename = 'Portable-OBS.bat'
  batContent = '@echo Running OBS Studio in Portable Mode...
@cd bin\64bit
@start obs64.exe -p
@echo This window will be closed after 5 seconds.
@timeout 5'
  ConfigDirs = @('config/obs-studio/plugin_config/obs-browser'
                 'config/obs-studio/crashes'
                 'config/obs-studio/profiler_data'
                 'config/obs-studio/logs')
  bin64bitDir = 'bin/64bit'
  global_ini = 'config/obs-studio/global.ini'
  global_ini_Regex = '^geometry=.*'
  profile_ini = 'config/obs-studio/basic/profiles/*/basic.ini'
  profile_ini_Regex = '^RecFilePath=.*|^FilePath=.*|^FFFilePath=.*'
  scene_json = 'config/obs-studio/basic/scenes/*.json'
  scene_json_Regex = '"(file|path|local_file|value)":"([A-Z]:[/\\].*?)"' # パスに'"'が含まれているとうまく動かない
  zipSuffixDateFormat = '-yyyy-MM-dd'
}

# コマンドライン引数がない場合、フォルダ選択ダイアログを開く
if (!$obsDir) {
  Add-Type -AssemblyName System.Windows.Forms

  $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{ 
    SelectedPath = [Environment]::CurrentDirectory
    Description = '圧縮したいポータブルOBSのディレクトリを選択してください。'
  }
  if ($FolderBrowser.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Exit
  }
  $obsDir = $FolderBrowser.SelectedPath
}
# OBSディレクトリの存在判定
if (!($obsDir | Test-Path -Pathtype Container)) {
  Write-Host '指定されたパスがディレクトリではありません。'
  Exit
}
# OBSディレクトリの絶対パス化
$obsDir = $obsDir | Resolve-Path
try {
  $obsDir | Push-Location
  Write-Verbose('$obsDir: ' + $obsDir)

  # bin/64bit があるかどうかでOBSディレクトリ判定
  if (!($obsDir | Join-Path -ChildPath $CONST['bin64bitDir'] | Test-Path -Pathtype Container)) {
    Write-Host '指定されたパスの中に ', $CONST['bin64bitDir'], ' ディレクトリが存在しません。'
    Exit
  }
  # portable_mode.txt がなければ作る
  $portable_mode_txt = $obsDir | Join-Path -ChildPath 'portable_mode.txt'
  if (!($portable_mode_txt | Test-Path)) {
    Write-Host 'portable_mode.txt が存在しないので作成します。'
    Set-Content '' -Path $portable_mode_txt
    # ついでにbatファイルを作成する？
    $bat = $obsDir | Join-Path -ChildPath $CONST['batFilename']
    if (!($bat | Test-Path)) {
      $result = $Host.UI.PromptForChoice('', 'ついでにポータブルモード起動用batファイルを作成しますか？', @('&Yes', '&No'), 0)
      if ($result -eq 0) {
        Set-Content $CONST['batContent'] -Path $bat -Encoding 'UTF8'
        Write-Host $CONST['batFilename'], 'を作成しました。'
      }
    }
  }

  # ファイル削除
  Write-Host '*.pdb を削除しています……'
  $pdbs = (Get-ChildItem '*.pdb' -Recurse).Fullname
  foreach ($pdb in $pdbs) {
    Remove-Item $pdb -Force
    Write-Verbose $pdb
  }
  
  Write-Host '不要なコンフィグディレクトリを削除しています……'
  foreach ($dir in $CONST['ConfigDirs']) {
    if (Test-Path $dir) {
      $dir = $dir | Resolve-Path
      Remove-Item $dir -Recurse -Force
      Write-Verbose $dir
    }
  }

  Write-Host 'iniファイルの環境依存項目を削除しています……'
  Write-Verbose($CONST['global_ini'] | Resolve-Path)
  (Get-Content -Encoding 'UTF8' $CONST['global_ini']) | foreach {
    $after = $_ -replace $CONST['global_ini_Regex'],''
    if ($_ -ne $after) { Write-Verbose('  ' + $_ + ' => ' + $after) }
    $after
  } | Set-Content -Encoding 'UTF8' $CONST['global_ini']
  $inis = (Get-ChildItem -Recurse $CONST['profile_ini']).Fullname
  foreach($ini in $inis) {
    Write-Verbose $ini
    (Get-Content -Encoding 'UTF8' $ini) | foreach {
      $after = $_ -replace $CONST['profile_ini_Regex'],''
      if ($_ -ne $after) { Write-Verbose('  ' + $_ + ' => ' + $after) }
      $after
    } | Set-Content -Encoding 'UTF8' $ini
  }

  Write-Host 'シーンコレクションの絶対パスを相対パスに置換しています……'
  $jsons = (Get-ChildItem -Recurse $CONST['scene_json']).Fullname
  foreach($json in $jsons) {
    Write-Verbose $json
    (Get-Content -Encoding 'UTF8' $json) | foreach {
      try {
        # exeからの相対パスを求めるため、カレントディレクトリを bin/64bit に変更
        $obsDir | Join-Path -ChildPath $CONST['bin64bitDir'] | Push-Location
        [regex]::Replace($_, $CONST['scene_json_Regex'], {
          # パスが存在している場合のみ置換
          if ($args.groups[2].value | Test-Path) {
            $path = $args.groups[2].value | Resolve-Path -Relative
            $path = $path -replace '\\', '/'
            $after = '"'+ $args.groups[1].value + '":"' + $path  + '"'
            Write-Verbose('  ' + $args.groups[0].value + ' => ' + $after)
            $after
          } else {
            $args[0].value
          }
        })
      } finally {
        Pop-Location
      }
    } | Set-Content -Encoding 'UTF8' $json
  }

  $parent = $obsDir | Split-Path -Parent
  $leaf = $obsDir | Split-Path -Leaf
  $zip = $parent | Join-Path -ChildPath ($leaf + (Get-Date -Format $CONST['zipSuffixDateFormat']) + '.zip')
  Write-Host "zip圧縮しています……: ${zip}"
  if (Test-Path $zip) {
    $result = $Host.UI.PromptForChoice('上書き確認', "zipアーカイブが既に存在しています。上書きしますか？", @('&Yes', '&No'), 0)
    if ($result -ne 0) {
      Write-Host 'zipアーカイブを上書きしませんでした。'
      Exit
    }
    Remove-Item $zip -Force
  }
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [IO.Compression.ZipFile]::CreateFromDirectory($obsDir, $zip, [System.IO.Compression.CompressionLevel]::Optimal, $true)
  Write-Host '圧縮が完了しました。'
} finally {
  Pop-Location
  Write-Host ''
  Write-Host '何かキーを押してください……'
  [Console]::ReadKey($true) | Out-Null
}
