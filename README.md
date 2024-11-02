# portable-obs-cleaner
ポータブルOBSの不要なファイルを削除してzipアーカイブを作成する。

## 使い方
```
> ./portable-obs-cleaner.ps1 [<Portable OBS Sdutio Directory>] [-Verbose]
```
[PowerShellの実行ポリシー](https://learn.microsoft.com/ja-jp/PowerShell/module/microsoft.PowerShell.core/about/about_execution_policies?view=PowerShell-7.4)の保護によって実行できない場合は`PowerShell -ExecutionPolicy Bypass -File ./portable-obs-cleaner.ps1`とかやる。

第一引数にはポータブルOBSのディレクトリを指定する。
指定しなかった場合はフォルダ選択ダイアログから選択する。

実行結果の例
```
> powershell -ExecutionPolicy Bypass -File ./portable-obs-cleaner.ps1 E:\TWC2024JP-OBS-Player
portable_mode.txt が存在しないので作成します。
ついでにポータブルモード起動用batファイルを作成しますか？
[Y] Yes  [N] No  [?] ヘルプ (既定値は "Y"):
Portable-OBS.bat を作成しました。
*.pdb を削除しています……
不要なコンフィグディレクトリを削除しています……
iniファイルの環境依存項目を削除しています……
シーンコレクションの絶対パスを相対パスに置換しています……
zip圧縮しています……: E:\TWC2024JP-OBS-Player-2024-11-02.zip
圧縮が完了しました。

何かキーを押してください……
```

`-Verbose`オプションを有効にすると、実行中の詳細情報が表示される。
```
> powershell -ExecutionPolicy Bypass -File ./portable-obs-cleaner.ps1 E:\TWC2024JP-OBS-Player -Verbose
詳細: $obsDir: E:\TWC2024JP-OBS-Player
portable_mode.txt が存在しないので作成します。
ついでにポータブルモード起動用batファイルを作成しますか？
[Y] Yes  [N] No  [?] ヘルプ (既定値は "Y"):
Portable-OBS.bat を作成しました。
*.pdb を削除しています……
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\libobs-d3d11.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\libobs-opengl.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\libobs-winrt.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-amf-test.pdb
...
```

## 何をやってるの
- pdbファイルの削除
- 不要なコンフィグディレクトリの削除
  - config/obs-studio/plugin_config/obs-browser
  - config/obs-studio/crashes
  - config/obs-studio/profiler_data
  - config/obs-studio/logs
- iniファイルの環境依存項目の削除
  - config/obs-studio/global.ini
    - geometry: ウィンドウ位置情報
  - config/obs-studio/basic/profiles/*/basic.ini
    - FilePath: 出力モード基本の録画ファイルパス
    - RecFilePath: 出力モード詳細の録画ファイルパス
    - FFFilePath: カスタム出力(FFmpeg)の録画ファイルパス
- シーンコレクションの絶対パスを相対パスに置換※不完全
  - config/obs-studio/basic/scenes/*.json
  - ファイルの置き場所はポータブルOBSディレクトリ以下にしとかないと、ポータブル化＆相対化パスに変換する意味がないですよ。
- zip圧縮
  - ファイル名の末尾に日付を付ける。

## 動作確認環境
- Windows 10 Home 64bit + PowerShell 5.1.1
- Windows 11 Pro 64bit + PowerShell 7.4.6

## 参考
https://github.com/fGeorjje/portable-obs-strip
