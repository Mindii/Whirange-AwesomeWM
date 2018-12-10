################################################################################
### Events Settings
### Mindi @ Mindinet.org
### GNU General Public License v3.0
###
### Settings for events and modules for it.
################################################################################

### Basic settings
# Script version
version = "0.1.43"

# User Agent
agent = 'Events/' + version

### Database file
## DEV
#database = "Events.db"
## PROD
database = "/home/mindi/Documents/Events.db"

### Ended printout file
## DEV
#ended_file = "EndedEvents.txt"
## PROD
ended_file = "/home/mindi/.config/awesome/scripts/db/EndedEvents.txt"

### Next printout file
## DEV
#next_file = "NextEvents.txt"
## PROD
next_file  = "/home/mindi/.config/awesome/scripts/db/NextEvents.txt"

# How many ended event we print?
endedcount = 3
# How many upcomming event we print?
nextcount = 5

### Optional colour prefix/subfix
prefix = ""
subfix = ""

### TVDB
#apikey
tvdb_apikey = ''
#username
tvdb_username = ''
#userkey
tvdb_userkey = ''

#token
tvdb_token = ''
