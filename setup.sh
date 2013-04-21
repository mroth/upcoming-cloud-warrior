#!/bin/bash
echo "Setting up a cloud warrior for you!"

if [ -z $USER ]; then
  default_host="$USER-upcoming-cloud-warrior"
else
  default_host="mroth-upcoming-cloud-warrior"
fi

echo "Enter your desired name for credit or just press enter for default."
read -p "[$default_host]: " name

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
