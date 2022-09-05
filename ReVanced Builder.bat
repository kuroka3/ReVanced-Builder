@echo off

:: BatchGotAdmin
:-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Starting Builder...
    echo Please allow UAC.
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

echo rd /s /q "%appdata%\revancedtmp" > Cleaner.bat
md %appdata%\revancedtmp
cd %appdata%\revancedtmp
md %cd%\revanced
cd %cd%\revanced
md Build
md tmp
echo download revanced-cli...
if not exist %cd%\Build\revanced-cli.jar powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1015913335675428944/revanced-cli.jar', '%cd%\Build\revanced-cli.jar')"
cls
echo download revanced-cli...ok
echo download revanced-patches...
if not exist %cd%\Build\revanced-patches.jar powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1015913337852276736/revanced-patches.jar', '%cd%\Build\revanced-patches.jar')"
cls
echo download revanced-cli...ok
echo download revanced-patches...ok
echo download youtube...
if not exist %cd%\Build\youtube.apk powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/xemulat/MyFilesForDDL/releases/download/youtube/youtube.apk', '%cd%\Build\youtube.apk')"
cls
echo download revanced-cli...ok
echo download revanced-patches...ok
echo download youtube...ok
echo download app-unsigned...
if not exist %cd%\Build\app-unsigned.apk powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/revanced/revanced-integrations/releases/download/v0.36.5/app-release-unsigned.apk', '%cd%\Build\app-unsigned.apk')"
cls
echo download revanced-cli...ok
echo download revanced-patches...ok
echo download youtube...ok
echo download app-unsigned...ok

if exist %cd%\list.txt goto ifjdk

echo hdr-auto-brightness : HDR 재생 시 시스템 밝기 유지 (권장)> list.txt
echo. >> list.txt
echo video-ads : YouTube Premium 없이 동영상 광고 제거 (권장)>> list.txt
echo. >> list.txt
echo general-ads : YouTube Premium 없이 홈 화면 광고 제거 (권장)>> list.txt
echo. >> list.txt
echo old-quality-layout : 해상도 설정창을 구 버전으로 변경 (권장)>> list.txt
echo. >> list.txt
echo downloads : 음악 및 동영상 다운로드 가능>> list.txt
echo. >> list.txt
echo swipe-controls : 스와이프로 밝기/볼륨 조절>> list.txt
echo. >> list.txt
echo seekbar-tapping : 동영상 플레이어에서 탐색 표시줄 탭 확성화>> list.txt
echo. >> list.txt
echo minimized-playback : 백그라운드 재생 및 PiP>> list.txt
echo. >> list.txt
echo amoled : 완전한 블랙 테마>> list.txt
echo. >> list.txt
echo disable-create-button : 홈 화면 하단 중앙 크리에이터 버튼 삭제>> list.txt
echo. >> list.txt
echo return-youtube-dislike : 싫어요 수 보기>> list.txt
echo. >> list.txt
echo hide-autoplay-button : 자동재생 버튼 삭제>> list.txt
echo. >> list.txt
echo premium-heading : YouTube Premium으로 로고 변경>> list.txt
echo. >> list.txt
echo disable-fullscreen-panels : 전체화면 영상창 댓글/정보 패널 삭제>> list.txt
echo. >> list.txt
echo hide-shorts-button : Shorts 버튼 삭제>> list.txt
echo. >> list.txt
echo sponsorblock : 유료광고 포함영상 광고부분 자동스킵>> list.txt
echo. >> list.txt
echo enable-wide-searchbar : 검색바를 넓게 변경>> list.txt
echo. >> list.txt
echo force-vp9-codec : VP9코덱 강제 설정>> list.txt
echo. >> list.txt
echo always-autorepeat : 동영상 연속 재생을 기본으로 설정>> list.txt
echo. >> list.txt
echo enable-debugging : 앱 디버깅 활성화>> list.txt
echo. >> list.txt
echo custom-playback-speed : 커스텀 재생속도 활성화>> list.txt
echo. >> list.txt
echo hide-infocard-suggestions : 동영상 정보 카드 삭제>> list.txt

:ifjdk
cls
echo ZULU JDK를 설치 하셨나요?
echo.
choice /n /m "(Y/N) "
if %ERRORLEVEL%==2 goto JDK
if %ERRORLEVEL%==1 goto main

:JDK
cls
echo download unzip.exe
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1015940752599162930/unzip.exe', '%cd%\unzip.exe')"
echo download ZULU JDK 17
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.azul.com/zulu/bin/zulu17.36.19-ca-jdk17.0.4.1-win_i686.zip', '%cd%\tmp\z17.zip')"
echo Unzip z17.zip
%cd%\unzip %cd%\tmp\z17.zip
ren %cd%\zulu17.36.19-ca-jdk17.0.4.1-win_i686 z17
md %appdata%\JDK
move z17 %appdata%\JDK
set path_str=%Path%
setx -m Path "%appdata%\JDK\z17\bin;%path_str%"

goto main

:main
start list.txt
cls
echo 기능 선택
echo.
echo 방금 열린 메모장 파일에서 기능을 골라 입력해주세요.
echo *기능 앞에는 -i 를 붙여주세요.
echo ex) -i video-ads -i general-ads
echo.
set /p list=
goto write

:write
cd Build
cls
echo @echo off > build.bat
echo java -jar revanced-cli.jar -a youtube.apk -c  -o revanced.apk -b revanced-patches.jar -m app-unsigned.apk -i hide-cast-button -i microg-support -i custom-branding %list% >> build.bat
echo move %%cd%%\revanced.apk %~dp0 >> build.bat
echo exit >> build.bat

goto run

:run
cls
start build.bat