@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   一键部署到 Gitee Pages
echo ========================================
echo.

cd /d "%~dp0"

:: 重新生成 index.html（可选，如有改动取消注释）
:: cd ..
:: python force_build.py
:: cp data\output\font\index.html deploy\index.html
:: cd deploy

:: 检查是否有改动
git add -A
git diff --cached --quiet
if %errorlevel%==0 (
    echo [INFO] 没有改动，跳过提交。
) else (
    set /p msg="提交说明（回车默认 update）: "
    if "%msg%"=="" set msg=update
    git commit -m "%msg%"
)

:: 推送到 Gitee
echo.
echo 推送到 Gitee...
git push origin main
if %errorlevel%==0 (
    echo [OK] Gitee: https://dancing-shadows.gitee.io/xianyu-fonts/
) else (
    echo [FAIL] Gitee 推送失败
)

echo.
echo ========================================
echo   部署完成！
echo   Gitee: https://dancing-shadows.gitee.io/xianyu-fonts/
echo ========================================
echo.
pause
