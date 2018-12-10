################################################################################
### Show & calculate times for events in clock tooltip
### Mindi @ Mindinet.org
### GNU General Public License v3.0
###
### Rewrited SQlite version.
################################################################################
import sqlite3
from datetime import datetime, time
import Events.settings as setup

# Start connection
db = sqlite3.connect(setup.database)
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


# Print prev x event
def Ended(mode="null",item="null"):
	today = datetime.now().strftime("%Y-%m-%d")
	eventdb.execute("SELECT * FROM events WHERE date < '%s' ORDER BY date" %(today))
	count = len(eventdb.fetchall())
	eventdb.execute("SELECT * FROM events WHERE date < '%s' ORDER BY date" %(today))
	for i, event in enumerate(eventdb):
		if mode == "Ended" and count-setup.endedcount+1 <= event[0] and count-item == i:
			return(event[2])
		elif mode == "EndedType" and count-setup.endedcount+1 <= event[0] and count-item == i:
			return(event[3])
		elif mode == "EndedLink" and count-setup.endedcount+1 <= event[0] and count-item == i:
			return(event[4])

# Print next x event
def Next(mode="null",item="null"):
	today = datetime.now().strftime("%Y-%m-%d")
	eventdb.execute("SELECT * FROM events WHERE date > '%s' ORDER BY date ASC" %(today))
	count = len(eventdb.fetchall())
	eventdb.execute("SELECT * FROM events WHERE date > '%s' ORDER BY date ASC" %(today))
	for i, event in enumerate(eventdb):
		date = datetime.strptime(event[1], '%Y-%m-%d %H:%M:%S')
		if mode == "Next" and setup.nextcount-1 <= event[0] and item-1 == i:
			return(event[2])
		elif mode == "NextTime" and setup.nextcount-1 <= event[0] and item-1 == i:
			return(Countdown(date))
		elif mode == "NextType" and setup.nextcount-1 <= event[0] and item-1 == i:
			return(event[3])
		elif mode == "NextLink" and setup.nextcount-1 <= event[0] and item-1 == i:
			return(event[4])

# Empty temp files
def ClearFiles(mode="null"):
	if mode == "Ended":
		file = open(setup.ended_file,'w')
		file.write('')
		file.close()
	elif mode == "Next":
		file = open(setup.next_file,'w')
		file.write('')
		file.close()

## Lets collect all info we need and write that for endresult similar to old events script

# Loop for ended events
EEC = 3
ClearFiles("Ended")
while (EEC >= 1):
	if Ended("Ended",EEC) != None:
		EEvent = Ended("Ended",EEC)
		EEventType = Ended("EndedType",EEC)
		EEString = '%s, %s' %(EEvent,EEventType)
		file = open(setup.ended_file,'a')
		file.write(EEString + '\n')
		file.close()		
	EEC = EEC - 1

# Loop for upcomming events
EC = 1
ClearFiles("Next")
while (EC < setup.nextcount+1):
	if Next("Next",EC) != None:
		Event = Next("Next",EC)
		EventF = Event[0]
		EventE = Event[1:len(Event)]
		EventTime = Next("NextTime",EC)
		EventType = Next("NextType",EC)
		EString = '%s%s%s%s, %s' %(setup.prefix, EventF, setup.subfix, EventE,EventType)
		file = open(setup.next_file,'a')
		file.write(EString + '\n')
		file.write(EventTime + '\n')
		file.close()
	EC = EC + 1

# End connection
db.close()
