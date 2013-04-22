# Upcoming Cloud Warrior

Quick instructions to to get the Upcoming.org Archive Project running on triple Heroku instances in the cloud!  For the why, see [this post from Andy](http://waxy.org/2013/04/how_you_can_save_upcoming/).

This basically just uses the [archive team heroku buildpack](https://github.com/ArchiveTeam/heroku-buildpack-archiveteam-warrior) and offers some tweaks but I'm hoping the instructions here make this easier to follow for a new heroku user.

Performance wise I bumped the concurrency way up while reducing the max items so that the dynos restart more frequently, such that the IP address will cycle more often to avoid Yahoo! Error 999 rate limits.

## Setup and running

### 1. Heroku setup (if you don't already have it)

 1. Sign up for a [free Heroku account](https://id.heroku.com/signup).
 1. Install [heroku-toolbelt](https://toolbelt.heroku.com/).

### 2a. Project setup and running (automatic)

First, clone this repository to somewhere on your computer:

	git clone https://github.com/mroth/upcoming-cloud-warrior.git
	
Change into that directory (`cd upcoming-cloud-warrior`), and then run the following commands:

	./setup.sh
	
Wait a while, and everything should be running for you!

### 2b. Project setup and running (manual)
First, clone this repository to somewhere on your computer:

	git clone http://github.com/mroth/upcoming-cloud-warrior.git

Change into that directory (`cd upcoming-cloud-warrior`), and then run the following commands:

	heroku apps:create --buildpack https://github.com/ArchiveTeam/heroku-buildpack-archiveteam-warrior.git
	heroku config:set WARRIOR_PROJECT=https://github.com/ArchiveTeam/yahoo-upcoming-grab
	heroku config:set WARRIOR_DOWNLOADER=mroth-upcoming-cloud-warrior
	heroku config:set WARRIOR_CONCURRENT=8 WARRIOR_MAX_ITEMS=64
	git push heroku master

Replace your username in the last field if you want direct credit (or keep mine if you prefer to credit these instructions).

To get things going do the following:

	heroku ps:scale seesaw=1
	
And things should start running.  You can watch the results by doing `heroku logs --tail` or checking out the [online project status](http://tracker.archiveteam.org/upcoming/).



## Doubling (or tripling) the archive rate
Bonus points, for example you can do the following to run a second dyno:

	heroku ps:scale seesaw=2

*Limited time offer!:* This will consume 2x the free dyno rate, so you will end up getting charged if you let it keep running for more than a half month…  _But_ since there are only <10 days left in the Upcoming.org archive, as long as you stop it at the end you should not get charged for anything as you will have still consumed less than 720 dyno hours.

Note I believe you may need to give Heroku your credit card information before you can spin up extra instances (but they shouldn't bill you if you are careful, see the following.) Here's how Heroku does it's billing, in their own words:

>Heroku automatically credits each app with 750 free dyno-hours per month, which are clearly identified on your invoice. This allotment can be used for any type of dyno. (i.e. web, worker, console). Your free dyno-hours will allow you to run 1 dyno for an entire month free of charge–although you may choose to run 2 dynos for 1/2 of a month instead.
	
So if you are feeling particularly ambitious, you could actually run 3 instances for the remaining 10 days before the Upcoming shutdown.  How to do that?  Yep, you guessed it, `heroku ps:scale seesaw=3`.

## Cleanup when the project is over

Do `heroku ps:scale seesaw=0` to stop all warriors.

## Special thanks
To Heroku for offering a fantastic service I use for many of my other projects.  If anyone at Heroku feels this is an illegitmite usage of your services please contact me and I'll be happy to shut it down and take these instructions offline!
