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

echo hdr-auto-brightness : HDR ��� �� �ý��� ��� ���� (����)> list.txt
echo. >> list.txt
echo video-ads : YouTube Premium ���� ������ ���� ���� (����)>> list.txt
echo. >> list.txt
echo general-ads : YouTube Premium ���� Ȩ ȭ�� ���� ���� (����)>> list.txt
echo. >> list.txt
echo old-quality-layout : �ػ� ����â�� �� �������� ���� (����)>> list.txt
echo. >> list.txt
echo downloads : ���� �� ������ �ٿ�ε� ����>> list.txt
echo. >> list.txt
echo swipe-controls : ���������� ���/���� ����>> list.txt
echo. >> list.txt
echo seekbar-tapping : ������ �÷��̾�� Ž�� ǥ���� �� Ȯ��ȭ>> list.txt
echo. >> list.txt
echo minimized-playback : ��׶��� ��� �� PiP>> list.txt
echo. >> list.txt
echo amoled : ������ �� �׸�>> list.txt
echo. >> list.txt
echo disable-create-button : Ȩ ȭ�� �ϴ� �߾� ũ�������� ��ư ����>> list.txt
echo. >> list.txt
echo return-youtube-dislike : �Ⱦ�� �� ����>> list.txt
echo. >> list.txt
echo hide-autoplay-button : �ڵ���� ��ư ����>> list.txt
echo. >> list.txt
echo premium-heading : YouTube Premium���� �ΰ� ����>> list.txt
echo. >> list.txt
echo disable-fullscreen-panels : ��üȭ�� ����â ���/���� �г� ����>> list.txt
echo. >> list.txt
echo hide-shorts-button : Shorts ��ư ����>> list.txt
echo. >> list.txt
echo sponsorblock : ���ᱤ�� ���Կ��� ����κ� �ڵ���ŵ>> list.txt
echo. >> list.txt
echo enable-wide-searchbar : �˻��ٸ� �а� ����>> list.txt
echo. >> list.txt
echo force-vp9-codec : VP9�ڵ� ���� ����>> list.txt
echo. >> list.txt
echo always-autorepeat : ������ ���� ����� �⺻���� ����>> list.txt
echo. >> list.txt
echo enable-debugging : �� ����� Ȱ��ȭ>> list.txt
echo. >> list.txt
echo custom-playback-speed : Ŀ���� ����ӵ� Ȱ��ȭ>> list.txt
echo. >> list.txt
echo hide-infocard-suggestions : ������ ���� ī�� ����>> list.txt

:ifjdk
cls
echo ZULU JDK�� ��ġ �ϼ̳���?
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
echo ��� ����
echo.
echo ��� ���� �޸��� ���Ͽ��� ����� ��� �Է����ּ���.
echo *��� �տ��� -i �� �ٿ��ּ���.
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