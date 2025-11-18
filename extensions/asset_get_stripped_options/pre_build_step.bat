if "%YYtargetFile%" == "" (
    echo "copying new file"
    copy "%YYMACROS_project_full_filename%" "%YYprojectDir%/datafiles/asset_get_stripped.json"
) else (
    break > "%YYprojectDir%/datafiles/asset_get_stripped.json"
)