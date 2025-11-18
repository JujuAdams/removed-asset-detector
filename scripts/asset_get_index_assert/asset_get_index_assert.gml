// Feather disable all

/// This function gets the handle for a game asset from its name. If the asset is not found, this
/// function will use `asset_get_removed()` to check if the target asset was removed from the
/// game during compile. If so, this function will raise an error alerting you to the problem.
/// If this function cannot find an asset and that asset isn't in your project (i.e. you're looking
/// for an asset that doesn't exist anywhere) then this function will not error and will instead
/// return `-1`.
/// 
/// The asset name should be passed to this function as a string e.g. you should call
/// `asset_get_index_assert("obj_example")` for an object named `obj_example`.
/// 
/// Please note:
/// 
/// - By default, this function will never raise an error if you have compiled your game and are
///   running it outside the IDE. In this situation, this function will not check to see if an
///   asset has been removed and will return `-1` for an asset it cannot find. If you would like
///   to enable errors, please tick the `Force Export` option in `removed_asset_detector`.
/// 
/// - The HTML5 runtime is not supported and this function will never raise an error when using
///   the HTML5 runtime.
/// 
/// - In IDE v2024.11.0.179 / Runtime v2024.11.0.226: room assets, script assets and particle
///   system assets do not appear to get removed by the compiler.
///     
/// - In IDE v2024.14.0.207  Runtime v2024.14.0.251: room assets and script assets do not
///   appear to get removed by the compiler.
/// 
/// - You will need to keep `removed_asset_detector.json` in your project's datafiles folder. This
///   is the most reliable way of including external data with your game. If you're using Git (or
///   other source control software) then please do not .gitignore this file. Any merge conflicts
///   for this file can be ignored.
/// 
/// @param {String} assetName

function asset_get_index_assert(_assetName)
{
    var _asset = asset_get_index(_assetName);
    
    if ((real(_asset) < 0) && asset_get_removed(_assetName))
    {
        show_error($" \nAsset \"{_assetName}\" has been removed from your game during compile.\nPlease refer to GameMaker documentation for instructions on resolving this problem.\n(Search for \"Automatically remove unused asssets when compiling\")\n ", true);
    }
    
    return _asset;
}