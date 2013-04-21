#!/bin/bash
heroku apps:create --buildpack https://github.com/ArchiveTeam/heroku-buildpack-archiveteam-warrior.git
heroku config:set WARRIOR_PROJECT=https://github.com/ArchiveTeam/yahoo-upcoming-grab
heroku config:set WARRIOR_PROJECTRIOR_DOWNLOADER=mroth-upcoming-cloud-warrior
git push heroku master
heroku ps:scale seesaw=1
echo "All done!  You can view the progress by running 'heroku logs --tail'"

