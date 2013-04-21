#!/bin/bash
if [ -z $USER ]; then
  default_host="$USER-upcoming-cloud-warrior"
else
  default_host="mroth-upcoming-cloud-warrior"
fi

echo -n "Enter your name for credit or just press enter for default [$default_host]: "
read name

if [ -z $name ]; then
  name=$default_host
fi
echo "Okay, we'll use ${name} as your identifier."

heroku apps:create --buildpack https://github.com/ArchiveTeam/heroku-buildpack-archiveteam-warrior.git
heroku config:set WARRIOR_PROJECT=https://github.com/ArchiveTeam/yahoo-upcoming-grab
heroku config:set WARRIOR_DOWNLOADER=$name
git push heroku master
heroku ps:scale seesaw=1
echo "All done!  You can view the progress by running 'heroku logs --tail'"
