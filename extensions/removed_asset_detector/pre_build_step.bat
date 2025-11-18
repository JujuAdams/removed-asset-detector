se export=False

if "%YYtargetFile%" == "" set export=True
if "%YYEXTOPT_removed_asset_detector_force_export%" == "True" set export=True

if "%export%" == "True" (
    copy "%YYMACROS_project_full_filename%" "%YYprojectDir%/datafiles/removed_asset_detector.json"
) else (
    break > "%YYprojectDir%/datafiles/removed_asset_detector.json"
)