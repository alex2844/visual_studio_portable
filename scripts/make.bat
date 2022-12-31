@echo off

set "pwd=%cd%"
cd %~dp0..\
set "var_target=%cd%\"
set "var_vs_dir=%var_target%Microsoft Visual Studio\"
set "var_wk_dir=%var_target%Windows Kits\"
for /f "tokens=* delims= " %%a in ('dir /b /a:d "%var_vs_dir%"') do (
	if exist "%var_vs_dir%\%%a\Community" (
		set "var_vs_ver=%%a"
	)
)
for /f "tokens=* delims= " %%a in ('dir /b /a:d "%var_wk_dir%"') do (
	if exist "%var_wk_dir%\%%a\Include" (
		set "WindowsSdkDir=%var_wk_dir%%%a\"
	)
)
set "var_msvc_tools=%var_vs_dir%%var_vs_ver%\Community\VC\Tools\MSVC\"
for /f "tokens=* delims= " %%a in ('dir /b /a:d "%var_msvc_tools%"') do (
	set "VCToolsVersion=%%a"
)
for /f "tokens=* delims= " %%a in ('dir /b /a:d "%WindowsSdkDir%\Include\"') do (
	set "WindowsSDKVersion=%%a"
)
cd %pwd%
set "VCToolsInstallDir=%var_msvc_tools%%VCToolsVersion%\"
set "VCToolsRedistDir=%var_vs_dir%%var_vs_ver%\Community\VC\Redist\MSVC\%VCToolsVersion%\"
set "var_sdk_dir=%%WindowsSdkDir:\=\\%%"
set "CommandPromptType=Native"
set "DevEnvDir=%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\"
set "ExtensionSdkDir=%var_target%Microsoft SDKs\Windows Kits\10\ExtensionSDKs"
set "Framework40Version=v4.0"
set "FrameworkDir=C:\Windows\Microsoft.NET\Framework64\"
set "FrameworkDir64=C:\Windows\Microsoft.NET\Framework64\"
set "FrameworkVersion=v4.0.30319"
set "FrameworkVersion64=v4.0.30319"
set "INCLUDE=%VCToolsInstallDir%ATLMFC\include;%VCToolsInstallDir%include;%WindowsSdkDir%include\%WindowsSDKVersion%\ucrt;%WindowsSdkDir%include\%WindowsSDKVersion%\\shared;%WindowsSdkDir%include\%WindowsSDKVersion%\\um;%WindowsSdkDir%include\%WindowsSDKVersion%\\winrt;%WindowsSdkDir%include\%WindowsSDKVersion%\\cppwinrt"
set "LIB=%VCToolsInstallDir%ATLMFC\lib\x64;%VCToolsInstallDir%lib\x64;%WindowsSdkDir%lib\%WindowsSDKVersion%\ucrt\x64;%WindowsSdkDir%lib\%WindowsSDKVersion%\\um\x64"
set "LIBPATH=%VCToolsInstallDir%ATLMFC\lib\x64;%VCToolsInstallDir%lib\x64;%VCToolsInstallDir%lib\x86\store\references;%WindowsSdkDir%UnionMetadata\%WindowsSDKVersion%;%WindowsSdkDir%References\%WindowsSDKVersion%;C:\Windows\Microsoft.NET\Framework64\v4.0.30319"
set "Path=%VCToolsInstallDir%bin\HostX64\x64;%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\VC\VCPackages;%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\CommonExtensions\Microsoft\TestWindow;%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer;%var_vs_dir%%var_vs_ver%\Community\MSBuild\Current\bin\Roslyn;%WindowsSdkDir%bin\%WindowsSDKVersion%\\x64;%WindowsSdkDir%bin\\x64;%var_vs_dir%%var_vs_ver%\Community\\MSBuild\Current\Bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319;%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\;%var_vs_dir%%var_vs_ver%\Community\Common7\Tools\;%PATH%;%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\VC\Linux\bin\ConnectionManagerExe"
set "Platform=x64"
set "UCRTVersion=%WindowsSDKVersion%"
set "UniversalCRTSdkDir=%WindowsSdkDir%"
set "VCIDEInstallDir=%var_vs_dir%%var_vs_ver%\Community\Common7\IDE\VC\"
set "VCINSTALLDIR=%var_vs_dir%%var_vs_ver%\Community\VC\"
set "VisualStudioVersion=17.0"
set "VS170COMNTOOLS=%var_vs_dir%%var_vs_ver%\Community\Common7\Tools\"
set "VSCMD_ARG_app_plat=Desktop"
set "VSCMD_ARG_HOST_ARCH=x64"
set "VSCMD_ARG_TGT_ARCH=x64"
set "VSCMD_VER=17.2.1"
set "VSINSTALLDIR=%var_vs_dir%%var_vs_ver%\Community\"
set "WindowsLibPath=%WindowsSdkDir%UnionMetadata\%WindowsSDKVersion%;%WindowsSdkDir%References\%WindowsSDKVersion%"
set "WindowsSdkBinPath=%WindowsSdkDir%bin\"
set "WindowsSDKLibVersion=%WindowsSDKVersion%\"
set "WindowsSdkVerBinPath=%WindowsSdkDir%bin\%WindowsSDKVersion%\"
set "__DOTNET_ADD_64BIT=1"
set "__DOTNET_PREFERRED_BITNESS=64"
set "__VSCMD_PREINIT_PATH=%PATH%"

reg import %var_target%scripts\env.reg
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Microsoft SDKs\Windows\v10.0" /v InstallationFolder /t REG_SZ /d "%var_sdk_dir%" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Kits\Installed Roots" /v KitsRoot10 /t REG_SZ /d "%var_sdk_dir%" /f

msbuild %*
