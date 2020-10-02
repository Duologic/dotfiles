user_pref("accessibility.browsewithcaret_shortcut.enabled", false);
user_pref("accessibility.force_disabled", 1);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.ssb.enabled", true);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("findbar.highlightAll", true);
user_pref("media.hardwaremediakeys.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("signon.rememberSignons", false);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// ChromeOS UA to trick Slack (and possibly Spotify)
user_pref("general.useragent.override", "Mozilla/5.0 (X11; CrOS x86_64 13099.85.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.110 Safari/537.36");
// Tricks most URLs (also http/https) to be handed off to the OS so the default Firefox profile can open them instead
user_pref("network.protocol-handler.expose-all", false);
