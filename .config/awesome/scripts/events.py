################################################################################
### Show & calculate times for events in clock tooltip
### Mindi @ Mindinet.org
### GNU General Public License v3.0
###
### Rewrited SQlite version.
################################################################################
import sqlite3
from datetime import datetime, time

# Optional colour prefix/subfix
C = ""
CEnd = ""
# File localtions
DatabaseFile = "/home/mindi/Documents/Events.db"
EndedFile = "/home/mindi/.config/awesome/scripts/db/EndedEvents.txt"
EventFile = "/home/mindi/.config/awesome/scripts/db/NextEvents.txt"

# Start connection
db = sqlite3.connect(DatabaseFile)
eventdb = db.cursor()

# Countdown to given date
def Countdown(Date="0"):
	timedelta = Date - datetime.now()
	seconds = timedelta.days * 24 * 3600 + timedelta.seconds
	minutes, seconds = divmod(seconds, 60)
	hours, minutes = divmod(minutes, 60)
	days, hours = divmod(hours, 24)
	if days == 0:
		if hours == 0:
			return "%dmin" %(minutes)
		else:
			return "%dh %dmin" %(hours, minutes)		
	elif days > 1:
		return "%ddays %dh" %(days, hours)	
	else:
		return "%dday %dh" %(days, hours)

# Create Table
def DBTable():
	eventdb.execute('''CREATE TABLE events (id INTEGER PRIMARY KEY, date TEXT, name TEXT, type TEXT, link TEXT)''')
	db.commit()
	return("Table Created")

# Write new event to db
def DBWrite(e_date, e_name, e_type, e_link):
	eventdb.execute('INSERT INTO events(date,name,type,link) VALUES (?,?,?,?)', (e_date, e_name, e_type, e_link))
	db.commit()
	return("New item added")

# Print next x events
def Events(mode="null",item="null"):
	if item == "null":
		return("No id given")
	else:
		eventdb.execute('SELECT * FROM events ORDER BY date ASC')
		count = 0
		for event in eventdb:
			date = datetime.strptime(event[1], '%Y-%m-%d %H:%M:%S')
			if "-" in Countdown(date) and mode == "Ended":
				if item-1 == count:
					return(event[2])
				count = count + 1
			elif "-" in Countdown(date) and mode == "EndedType":
				if item-1 == count:
					return(event[3])
				count = count + 1
			elif "-" in Countdown(date) and mode == "EndedLink":
				if item-1 == count:
					return(event[4])
				count = count + 1
			elif "-" not in Countdown(date) and mode == "Next":
				if item-1 == count:
					return(event[2])
				count = count + 1
			elif "-" not in Countdown(date) and mode == "NextTime":
				if item-1 == count:
					return(Countdown(date))
				count = count + 1
			elif "-" not in Countdown(date) and mode == "NextType":
				if item-1 == count:
					return(event[3])
				count = count + 1
			elif "-" not in Countdown(date) and mode == "NextLink":
				if item-1 == count:
					return(event[4])
				count = count + 1

# Empty temp files
def ClearFiles(mode="null"):
	if mode == "Ended":
		file = open(EndedFile,'w')
		file.write('')
		file.close()
	elif mode == "Event":
		file = open(EventFile,'w')
		file.write('')
		file.close()

## Lets collect all info we need and write that for endresult similar to old events script

# Loop for ended events
EEC = 1
ClearFiles("Ended")
while (EEC < 4):
	if Events("Next",EEC) != None:
		EEvent = Events("Ended",EEC)
		EEventType = Events("EndedType",EEC)
		EEString = '%s, %s' %(EEvent,EEventType)
		file = open(EndedFile,'a')
		file.write(EEString + '\n')
		file.close()
		
	EEC = EEC + 1

# Loop for upcomming events
EC = 1
ClearFiles("Event")
while (EC < 6):
	if Events("Next",EC) != None:
		Event = Events("Next",EC)
		EventF = Event[0]
		EventE = Event[1:len(Event)]
		EventTime = Events("NextTime",EC)
		EventType = Events("NextType",EC)
		EString = '%s%s%s%s, %s' %(C, EventF, CEnd, EventE,EventType)
		file = open(EventFile,'a')
		file.write(EString + '\n')
		file.write(EventTime + '\n')
		file.close()
		
	EC = EC + 1

# End connection
db.close()
