# portable-obs-cleaner
ポータブルOBSの不要なファイルを削除してzipアーカイブを作成するスクリプト。
batファイルだと書ききれなさそうなのでPowerShellで書きました。

丁寧に設定したポータブルOBSがこのスクリプトによって壊れても責任は取れないので実行前にバックアップをとっておくことを推奨します。

## 使い方
```
> ./portable-obs-cleaner.ps1 [<Portable OBS Sdutio Directory>]
```
[PowerShellの実行ポリシー](https://learn.microsoft.com/ja-jp/PowerShell/module/microsoft.PowerShell.core/about/about_execution_policies?view=PowerShell-7.4)の保護によって実行できない場合は`PowerShell -ExecutionPolicy Bypass -File ./portable-obs-cleaner.ps1`とかやる。

第一引数にはポータブルOBSのディレクトリを指定する。
指定しなかった場合はフォルダ選択ダイアログから選択する。

実行結果の例
```
> powershell -ExecutionPolicy Bypass -File ./portable-obs-cleaner.ps1 E:\TWC2024JP-OBS-Player
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
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-ffmpeg-mux.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-frontend-api.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-nvenc-test.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-qsv-test.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs-scripting.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\obs64.pdb
詳細: E:\TWC2024JP-OBS-Player\bin\64bit\w32-pthreads.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\get-graphics-offsets32.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\get-graphics-offsets64.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\graphics-hook32.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\graphics-hook64.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\inject-helper32.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-capture\inject-helper64.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-dshow\obs-virtualcam-module32.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-plugins\win-dshow\obs-virtualcam-module64.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-scripting\64bit\obslua.pdb
詳細: E:\TWC2024JP-OBS-Player\data\obs-scripting\64bit\_obspython.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\32bit\source-clone.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\aja-output-ui.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\aja.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\coreaudio-encoder.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\decklink-captions.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\decklink-output-ui.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\decklink.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\frontend-tools.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\image-source.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-browser-page.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-browser.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-ffmpeg.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-filters.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-outputs.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-qsv11.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-text.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-transitions.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-vst.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-webrtc.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-websocket.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\obs-x264.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\rtmp-services.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\source-clone.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\text-freetype2.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\vlc-video.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\win-capture.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\win-dshow.pdb
詳細: E:\TWC2024JP-OBS-Player\obs-plugins\64bit\win-wasapi.pdb
不要なコンフィグディレクトリを削除しています……
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\plugin_config\obs-browser
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\crashes
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\profiler_data
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\logs
iniファイルの環境依存項目を削除しています……
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\global.ini
詳細:   geometry=AdnQywADAAAAAAP7AAAApAAACXAAAATdAAAD+wAAAMMAAAlwAAAE3QAAAAAAAAAACgAAAAP7AAAAwwAACXAAAATd =>
詳細:   geometry=AdnQywADAAAAAAABAAAAIAAAAlgAAAGvAAAAAQAAACAAAAJYAAABrwAAAAAAAAAACgAAAAABAAAAIAAAAlgAAAGv =>
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\profiles\TWC_1280x960_th14\basic.ini
詳細:   FilePath=C:\\Users\\root\\Videos =>
詳細:   RecFilePath=C:\\Users\\root\\Videos =>
詳細:   FFFilePath=C:\\Users\\root\\Videos =>
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\profiles\TWC_640x480\basic.ini
詳細:   FilePath=C:\\Users\\root\\Videos =>
詳細:   RecFilePath=E:/peca/past =>
詳細:   FFFilePath=C:\\Users\\root\\Videos =>
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\profiles\録画用\basic.ini
詳細:   FilePath=C:\\Users\\root\\Videos =>
詳細:   RecFilePath=I:/ =>
詳細:   FFFilePath=C:\\Users\\root\\Videos =>
シーンコレクションの絶対パスを相対パスに置換しています……
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\scenes\TWC_1280x960_th14.json
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\scenes\TWC_640x480.json
詳細:   "file":"E:/research/twc2024/edblocker.png" => "file":"../../../research/twc2024/edblocker.png"
詳細:   "path":"E:/TWC2024/★自分用★TWC2024JP-OBS-Player/data/obs-plugins/frontend-tools/scripts/obstweet.lua" =>
"path":"../../../TWC2024/★自分用★TWC2024JP-OBS-Player/data/obs-plugins/frontend-tools/scripts/obstweet.lua"
詳細: E:\TWC2024JP-OBS-Player\config\obs-studio\basic\scenes\録画用.json
zip圧縮しています……: E:\TWC2024JP-OBS-Player-2024-11-17.zip
圧縮が完了しました。

何かキーを押してください……
```

## 何をやってるの
- pdbファイルの削除
- なければ`./portable_mode.txt`
  - 起動用の`./Portable-OBS.bat`の作成
- 不要なコンフィグディレクトリの削除
  - `config/obs-studio/plugin_config/obs-browser`
  - `config/obs-studio/crashes`
  - `config/obs-studio/profiler_data`
  - `config/obs-studio/logs`
- iniファイルの環境依存項目の削除
  - `config/obs-studio/global.ini`
    - `geometry`: ウィンドウ位置情報
  - `config/obs-studio/basic/profiles/*/basic.ini`
    - `FilePath`: 出力モード基本の録画ファイルパス
    - `RecFilePath`: 出力モード詳細の録画ファイルパス
    - `FFFilePath`: カスタム出力(FFmpeg)の録画ファイルパス
- シーンコレクションの絶対パスを相対パスに置換**※不完全**
  - `config/obs-studio/basic/scenes/*.json`
  - ファイルの置き場所はポータブルOBSディレクトリ以下にしとかないと、ポータブル化＆相対パスに変換する意味がないですよ。
- zip圧縮
  - ファイル名の末尾に日付を付ける。

## 動作確認環境
- Windows 10 Home 64bit + PowerShell 5.1.1
- Windows 11 Pro 64bit + PowerShell 7.4.6

## 参考
https://github.com/fGeorjje/portable-obs-strip
