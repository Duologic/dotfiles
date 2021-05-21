user_pref("accessibility.browsewithcaret_shortcut.enabled", false);
user_pref("accessibility.force_disabled", 1);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.ssb.enabled", true);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("findbar.highlightAll", true);
user_pref("media.hardwaremediakeys.enabled", false);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("signon.rememberSignons", false);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// From https://support.mozilla.org/en-US/questions/1258193
//
// (A) browser.link.open_newwindow - for links in Firefox tabs
//
// This is the one that has a checkbox on the Preferences page:
//
//     3 = divert new window to a new tab (default)
//     2 = allow link to open a new window
//     1 = force new window into same tab
//
// (B) browser.link.open_newwindow.restriction - for links in Firefox tabs
//
// By default, if a page sets width, height, or toolbars for a popup, Firefox will let it be a separate window. To force those into a tab as well, you can change this preference to 0:
//
//     0 = apply the setting under (A) to ALL new windows (even script windows with features)
//     2 = apply the setting under (A) to normal windows, but NOT to script windows with features (default)
//     1 = override the setting under (A) and always use new windows
//
// (C) browser.link.open_newwindow.override.external - for links in other programs
//
//     -1 = apply the setting under (A) to external links (default)
//     3 = open external links in a new tab in the last active window
//     2 = open external links in a new window <= Try this one
//     1 = open external links in the last active tab replacing the current page
//user_pref("browser.link.open_newwindow", 1);                    // force new window into same tab (aka ignore _blank)
//user_pref("browser.link.open_newwindow.restriction", 2);        // ... but NOT to script windows with features
//user_pref("browser.link.open_newwindow.override.external", 3);  // retain original behavior for external links
