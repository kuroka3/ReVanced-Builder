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

set ver=1.2

echo Checking update...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://pastebin.com/raw/sMv0GcZ4', '%tmp%\ver.txt')"
set /p latest=<%tmp%\ver.txt
if not %latest%==%ver% goto update

set kencd=%cd%

set hdr-auto-brightness=e
set video-ads=e
set general-ads=e
set old-quality-layout=e
set downloads=e
set swipe-controls=e
set seekbar-tapping=e
set minimized-playback=e
set amoled=e
set disable-create-button=e
set return-youtube-dislike=e
set hide-autoplay-button=e
set premium-heading=e
set disable-fullscreen-panels=e
set hide-shorts-button=e
set sponsorblock=e
set enable-wide-searchbar=e
set force-vp9-codec=e
set always-autorepeat=e
set enable-debugging=e
set custom-playback-speed=e
set hide-infocard-suggestions=e

echo @echo off>Cleaner.bat
echo cd %cd%>>cleaner.bat
echo rd /s /q "%appdata%\revancedtmp" >> Cleaner.bat
echo del "%kencd%\Cleaner.bat" >> Cleaner.bat
echo exit >> Cleaner.bat
md %appdata%\revancedtmp
cd %appdata%\revancedtmp
md %cd%\revanced
cd %cd%\revanced
md Build
md tmp
cls
echo Checking update...ok
echo Download revanced-cli...
if not exist %cd%\Build\revanced-cli.jar powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1015913335675428944/revanced-cli.jar', '%cd%\Build\revanced-cli.jar')"
cls
echo Checking update...ok
echo Download revanced-cli...ok
echo Download revanced-patches...
if not exist %cd%\Build\revanced-patches.jar powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1015913337852276736/revanced-patches.jar', '%cd%\Build\revanced-patches.jar')"
cls
echo Checking update...ok
echo Download revanced-cli...ok
echo Download revanced-patches...ok
echo Download youtube...
if not exist %cd%\Build\youtube.apk powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/xemulat/MyFilesForDDL/releases/download/youtube/youtube.apk', '%cd%\Build\youtube.apk')"
cls
echo Checking update...ok
echo Download revanced-cli...ok
echo Download revanced-patches...ok
echo Download youtube...ok
echo Download app-unsigned...
if not exist %cd%\Build\app-unsigned.apk powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/revanced/revanced-integrations/releases/download/v0.36.5/app-release-unsigned.apk', '%cd%\Build\app-unsigned.apk')"
cls
echo Checking update...ok
echo Download revanced-cli...ok
echo Download revanced-patches...ok
echo Download youtube...ok
echo Download app-unsigned...ok
echo Download cmdclr...
if not exist %cd%\cmdclr.exe powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/1012934189919768637/1016355226527223920/cmdclr.exe', '%cd%\cmdclr.exe')"
cls
echo Checking update...ok
echo Download revanced-cli...ok
echo Download revanced-patches...ok
echo Download youtube...ok
echo Download app-unsigned...ok
echo Download cmdclr...ok

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
cls
%cd%\cmdclr.exe 07
if %hdr-auto-brightness%==i %cd%\cmdclr.exe 0a 
echo hdr-auto-brightness : HDR 재생 시 시스템 밝기 유지 (권장)
echo.
%cd%\cmdclr.exe 07
if %video-ads%==i %cd%\cmdclr.exe 0a 
echo video-ads : YouTube Premium 없이 동영상 광고 제거 (권장)
echo.
%cd%\cmdclr.exe 07
if %general-ads%==i %cd%\cmdclr.exe 0a
echo general-ads : YouTube Premium 없이 홈 화면 광고 제거 (권장)
echo.
%cd%\cmdclr.exe 07
if %old-quality-layout%==i %cd%\cmdclr.exe 0a 
echo old-quality-layout : 해상도 설정창을 구 버전으로 변경 (권장)
echo.
%cd%\cmdclr.exe 07
if %downloads%==i %cd%\cmdclr.exe 0a 
echo downloads : 음악 및 동영상 다운로드 가능
echo.
%cd%\cmdclr.exe 07
if %swipe-controls%==i %cd%\cmdclr.exe 0a 
echo swipe-controls : 스와이프로 밝기/볼륨 조절
echo.
%cd%\cmdclr.exe 07
if %seekbar-tapping%==i %cd%\cmdclr.exe 0a 
echo seekbar-tapping : 동영상 플레이어에서 탐색 표시줄 탭 확성화
echo.
%cd%\cmdclr.exe 07
if %minimized-playback%==i %cd%\cmdclr.exe 0a 
echo minimized-playback : 백그라운드 재생 및 PiP
echo.
%cd%\cmdclr.exe 07
if %amoled%==i %cd%\cmdclr.exe 0a 
echo amoled : 완전한 블랙 테마
echo.
%cd%\cmdclr.exe 07
if %disable-create-button%==i %cd%\cmdclr.exe 0a 
echo disable-create-button : 홈 화면 하단 중앙 크리에이터 버튼 삭제
echo.
%cd%\cmdclr.exe 07
if %return-youtube-dislike%==i %cd%\cmdclr.exe 0a 
echo return-youtube-dislike : 싫어요 수 보기
echo.
%cd%\cmdclr.exe 07
if %hide-autoplay-button%==i %cd%\cmdclr.exe 0a 
echo hide-autoplay-button : 자동재생 버튼 삭제
echo.
%cd%\cmdclr.exe 07
if %premium-heading%==i %cd%\cmdclr.exe 0a 
echo premium-heading : YouTube Premium으로 로고 변경
echo.
%cd%\cmdclr.exe 07
if %disable-fullscreen-panels%==i %cd%\cmdclr.exe 0a 
echo disable-fullscreen-panels : 전체화면 영상창 댓글/정보 패널 삭제
echo.
%cd%\cmdclr.exe 07
if %hide-shorts-button%==i %cd%\cmdclr.exe 0a 
echo hide-shorts-button : Shorts 버튼 삭제
echo.
%cd%\cmdclr.exe 07
if %sponsorblock%==i %cd%\cmdclr.exe 0a 
echo sponsorblock : 유료광고 포함영상 광고부분 자동스킵
echo.
%cd%\cmdclr.exe 07
if %enable-wide-searchbar%==i %cd%\cmdclr.exe 0a 
echo enable-wide-searchbar : 검색바를 넓게 변경
echo.
%cd%\cmdclr.exe 07
if %force-vp9-codec%==i %cd%\cmdclr.exe 0a 
echo force-vp9-codec : VP9코덱 강제 설정
echo.
%cd%\cmdclr.exe 07
if %always-autorepeat%==i %cd%\cmdclr.exe 0a 
echo always-autorepeat : 동영상 연속 재생을 기본으로 설정
echo.
%cd%\cmdclr.exe 07
if %enable-debugging%==i %cd%\cmdclr.exe 0a 
echo enable-debugging : 앱 디버깅 활성화
echo.
%cd%\cmdclr.exe 07
if %custom-playback-speed%==i %cd%\cmdclr.exe 0a 
echo custom-playback-speed : 커스텀 재생속도 활성화
echo.
%cd%\cmdclr.exe 07
if %hide-infocard-suggestions%==i %cd%\cmdclr.exe 0a 
echo hide-infocard-suggestions : 동영상 정보 카드 삭제
echo.

echo 기능 선택
echo.
echo 위의 리스트에서 기능을 골라 입력해주세요.
echo 활성화된 항목은 초록색으로 표시됩니다.
echo ex) video-ads
echo *완료: EXIT입력
echo.
set /p list=
if %list%==exit goto write
if %list%==hdr-auto-brightness goto hdr-auto-brightness
if %list%==video-ads goto video-ads
if %list%==general-ads goto general-ads
if %list%==old-quality-layout goto old-quality-layout
if %list%==downloads goto downloads
if %list%==swipe-controls goto swipe-controls
if %list%==seekbar-tapping goto seekbar-tapping
if %list%==minimized-playback goto minimized-playback
if %list%==amoled goto amoled
if %list%==disable-create-button goto disable-create-button
if %list%==return-youtube-dislike goto return-youtube-dislike
if %list%==hide-autoplay-button goto hide-autoplay-button
if %list%==premium-heading goto premium-heading
if %list%==disable-fullscreen-panels goto disable-fullscreen-panels
if %list%==hide-shorts-button goto hide-shorts-button
if %list%==sponsorblock goto sponsorblock
if %list%==enable-wide-searchbar goto enable-wide-searchbar
if %list%==force-vp9-codec goto force-vp9-codec
if %list%==always-autorepeat goto always-autorepeat
if %list%==enable-debugging goto enable-debugging
if %list%==custom-playback-speed goto custom-playback-speed
if %list%==hide-infocard-suggestions goto hide-infocard-suggestions

:hdr-auto-brightness
if %hdr-auto-brightness%==e (
    set hdr-auto-brightness=i
    goto main
)
if %hdr-auto-brightness%==i (
    set hdr-auto-brightness=e
    goto main
)

:video-ads
if %video-ads%==e (
    set video-ads=i
    goto main
)
if %video-ads%==i (
    set video-ads=e
    goto main
)

:general-ads
if %general-ads%==e (
    set general-ads=i
    goto main
)
if %general-ads%==i (
    set general-ads=e
    goto main
)

:old-quality-layout
if %old-quality-layout%==e (
    set old-quality-layout=i
    goto main
)
if %old-quality-layout%==i (
    set old-quality-layout=e
    goto main
)

:downloads
if %downloads%==e (
    set downloads=i
    goto main
)
if %downloads%==i (
    set downloads=e
    goto main
)

:swipe-controls
if %swipe-controls%==e (
    set swipe-controls=i
    goto main
)
if %swipe-controls%==i (
    set swipe-controls=e
    goto main
)

:seekbar-tapping
if %seekbar-tapping%==e (
    set seekbar-tapping=i
    goto main
)
if %seekbar-tapping%==i (
    set seekbar-tapping=e
    goto main
)

:minimized-playback
if %minimized-playback%==e (
    set minimized-playback=i
    goto main
)
if %minimized-playback%==i (
    set minimized-playback=e
    goto main
)

:amoled
if %amoled%==e (
    set amoled=i
    goto main
)
if %amoled%==i (
    set amoled=e
    goto main
)

:disable-create-button
if %disable-create-button%==e (
    set disable-create-button=i
    goto main
)
if %disable-create-button%==i (
    set disable-create-button=e
    goto main
)

:return-youtube-dislike
if %return-youtube-dislike%==e (
    set return-youtube-dislike=i
    goto main
)
if %return-youtube-dislike%==i (
    set return-youtube-dislike=e
    goto main
)

:hide-autoplay-button
if %hide-autoplay-button%==e (
    set hide-autoplay-button=i
    goto main
)
if %hide-autoplay-button%==i (
    set hide-autoplay-button=e
    goto main
)

:premium-heading
if %premium-heading%==e (
    set premium-heading=i
    goto main
)
if %premium-heading%==i (
    set premium-heading=e
    goto main
)

:disable-fullscreen-panels
if %disable-fullscreen-panels%==e (
    set disable-fullscreen-panels=i
    goto main
)
if %disable-fullscreen-panels%==i (
    set disable-fullscreen-panels=e
    goto main
)

:hide-shorts-button
if %hide-shorts-button%==e (
    set hide-shorts-button=i
    goto main
)
if %hide-shorts-button%==i (
    set hide-shorts-button=e
    goto main
)

:sponsorblock
if %sponsorblock%==e (
    set sponsorblock=i
    goto main
)
if %sponsorblock%==i (
    set sponsorblock=e
    goto main
)

:enable-wide-searchbar
if %enable-wide-searchbar%==e (
    set enable-wide-searchbar=i
    goto main
)
if %enable-wide-searchbar%==i (
    set enable-wide-searchbar=e
    goto main
)

:force-vp9-codec
if %force-vp9-codec%==e (
    set force-vp9-codec=i
    goto main
)
if %force-vp9-codec%==i (
    set force-vp9-codec=e
    goto main
)

:always-autorepeat
if %always-autorepeat%==e (
    set always-autorepeat=i
    goto main
)
if %always-autorepeat%==i (
    set always-autorepeat=e
    goto main
)

:enable-debugging
if %enable-debugging%==e (
    set enable-debugging=i
    goto main
)
if %enable-debugging%==i (
    set enable-debugging=e
    goto main
)

:custom-playback-speed
if %custom-playback-speed%==e (
    set custom-playback-speed=i
    goto main
)
if %custom-playback-speed%==i (
    set custom-playback-speed=e
    goto main
)

:hide-infocard-suggestions
if %hide-infocard-suggestions%==e (
    set hide-infocard-suggestions=i
    goto main
)
if %hide-infocard-suggestions%==i (
    set hide-infocard-suggestions=e
    goto main
)

:write
cd Build
cls
echo @echo off > build.bat
echo java -jar revanced-cli.jar -a youtube.apk -c  -o revanced.apk -b revanced-patches.jar -m app-unsigned.apk -i hide-cast-button -i microg-support -i custom-branding -%hdr-auto-brightness% hdr-auto-brightness -%video-ads% video-ads -%general-ads% general-ads -%old-quality-layout% old-quality-layout -%downloads% downloads -%swipe-controls% swipe-controls -%seekbar-tapping% seekbar-tapping -%minimized-playback% minimized-playback -%amoled% amoled -%disable-create-button% disable-create-button -%return-youtube-dislike% return-youtube-dislike -%hide-autoplay-button% hide-autoplay-button -%premium-heading% premium-heading -%disable-fullscreen-panels% disable-fullscreen-panels -%hide-shorts-button% hide-shorts-button -%sponsorblock% sponsorblock -%enable-wide-searchbar% enable-wide-searchbar -%force-vp9-codec% force-vp9-codec -%always-autorepeat% always-autorepeat -%enable-debugging% enable-debugging -%custom-playback-speed% custom-playback-speed -%hide-infocard-suggestions% hide-infocard-suggestions>> build.bat
echo move %%cd%%\revanced.apk %kencd% >> build.bat
echo start %kencd%\Cleaner.bat>> build.bat
echo exit >> build.bat

goto run

:run
cls
start build.bat
exit

:update
cls
echo Outdated Version! : %ver%
echo Please update : %latest%
echo https://github.com/kuroka3/ReVanced-Builder/releases
echo.
pause > nul
exit