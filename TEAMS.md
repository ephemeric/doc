==> Upgrading 1 outdated package:
microsoft-teams 23306.3408.2576.5406 -> 23335.208.2601.834
==> Upgrading microsoft-teams
==> Downloading https://statics.teams.cdn.office.net/production-osx/23335.208.2601.834/MicrosoftTeams.pkg
####################################################################################################### 100.0%
All formula dependencies satisfied.
==> Removing launchctl service com.microsoft.teams.TeamsUpdaterDaemon
Password:
==> Uninstalling packages with sudo; the password may be necessary:
com.microsoft.MSTeamsAudioDevice
com.microsoft.package.Microsoft_AutoUpdate.app
com.microsoft.teams2
==> Removing files:
/Applications/Microsoft Teams (work or school).app
/Library/Application Support/Microsoft/TeamsUpdaterDaemon
/Library/Logs/Microsoft/Teams
/Library/Logs/Microsoft/MSTeams
/Library/Preferences/com.microsoft.teams.plist
==> Running installer for microsoft-teams with sudo; the password may be necessary.
installer: Package name is Microsoft Teams (work or school)
installer: choices changes file '/private/tmp/choices20240205-98425-bvdwln.xml' applied
installer: Installing at base path /
installer: The install was successful.
==> Purging files for version 23306.3408.2576.5406 of Cask microsoft-teams
microsoft-teams was successfully upgraded!
