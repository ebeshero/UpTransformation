# How to update the schedule 

1. Be sure to have the latest version of Calabash installed, from: <https://github.com/ndw/xmlcalabash1/releases> 
1. Make all edits in `_includes/schedule/schedule.xml`
1. Inside `_includes/schedule`, call Calabash to run `schedule.xpr` XProc pipeline. 
    * Pro tip: make an alias in your  `~/.bash_profile` for running Calabash so you don't need to type out its path every time you use the command. For example, if it installed in your Applications directory: `alias calabash="/Applications/xmlcalabash-1.1.27-99/calabash"`

    * Then, with the alias in place, run `calabash schedule.xpr`

1. Check the time stamps on the files and open `schedule_local.html` to ensure HTML validity.