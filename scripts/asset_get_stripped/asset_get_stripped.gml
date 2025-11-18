/// Feather disable all

/// Returns if an asset name doesn't exist in the game specifically because the asset has been
/// stripped during compile due to the "Automatically remove unused assets when compiling" feature.
/// This function will return `true` only if the asset exists in the project file but not at
/// runtime. This means `asset_get_stripped()` will return `false` if the asset name is simply
/// misspelled.
/// 
/// The asset name should be passed to this function as a string e.g. you should call
/// `asset_get_stripped("obj_example")` for an object named `obj_example`.
/// 
/// Please note:
/// 
/// - To protect potentially sensitive data, this tool will not attach project file data to your
///   game when building an executable for release. This means the default behavior is for
///   `asset_get_stripped()` will always return `false` when running your game outside the IDE.
///   If you'd like to enable `asset_get_stripped()` for executable builds, please tick the
///   `Force Export` option in `asset_get_stripped_options`.
/// 
/// - The HTML5 runtime is not supported and this function will always return `false`.
/// 
/// - In IDE v2024.11.0.179 / Runtime v2024.11.0.226: room assets, script assets and particle
///   system assets do not appear to get stripped by the compiler.
///     
/// - In IDE v2024.14.0.207  Runtime v2024.14.0.251: room assets and script assets do not
///   appear to get stripped by the compiler.
/// 
/// - You will need to keep `asset_get_stripped.json` in your project's datafiles folder. This is
///   the most reliable way of including external data with your game. If you're using Git (or
///   other source control software) then please do not .gitignore this file. Any merge conflicts
///   for this file can be ignored.
/// 
/// @param {String} assetName

function asset_get_stripped(_assetName)
{
    static _projectResourceDict = (function()
    {
        var _dictionary = undefined;
        
        if ((os_type != os_operagx) && (os_browser != browser_not_a_browser))
        {
            //HTML5 isn't supported
            show_debug_message("Warning! `asset_get_stripped()` is not supported when using the HTML5 runtime");
        }
        else
        {
            try
            {
                var _buffer = buffer_load("asset_get_stripped.json");
                var _jsonString = buffer_read(_buffer, buffer_text);
                buffer_delete(_buffer);
                
                _dictionary = {};
                
                var _resourcesArray = json_parse(_jsonString)[$ "resources"];
                var _i = 0;
                repeat(array_length(_resourcesArray))
                {
                    _dictionary[$ _resourcesArray[_i].id.name] = true;
                    ++_i;
                }
            }
            catch(_error)
            {
                show_debug_message(json_stringify(_error, true));
                
                if (GM_build_type == "run")
                {
                    show_error(" \nProject JSON failed to load\n ", true);
                }
            }
        }
        
        return _dictionary;
    })();
    
    if ((not is_struct(_projectResourceDict)) || (asset_get_type(_assetName) != asset_unknown))
    {
        //Asset exists in the project; definitionally not stripped
        return false;
    }
    else
    {
        //If we find the asset name in the project JSON then the asset has been stripped
        return struct_exists(_projectResourceDict, _assetName);
    }
}

show_debug_message("Thank you for using `asset_get_stripped()` by Juju Adams! This version 1.0.0, 2025-11-17.");