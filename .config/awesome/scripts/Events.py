################################################################################
### Show & calculate times for events in clock tooltip
### Mindi @ Mindinet.org
### GNU General Public License v3.0
###
### File: ~/Documents/EventList
### Note: This is old script and need a lot cleaning loops etc
################################################################################
import re,os,subprocess
from subprocess import Popen, PIPE
from datetime import datetime, time

# Coundown to given date
def CountdownToDate(Date="0"):
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

# Read event file
def EventList(EC=0,Mode="null"):
	with open('/home/mindi/Documents/EventList') as f:
		returntxt = f.read()
	f.closed
	Events = returntxt.splitlines()
	Event = Events[EC]

	if Mode == "Name":
		return Event[20:len(Event)]
	elif Mode == "Count":
		return len(Events)
	else:
		return Event[:19]

# Lets parser things more
def NextEventV2(Item=0,Mode="null"):
	count = 0
	while (count < EventList(0,"Count")):
		ETime = EventList(count)
		Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
		TimeCheck = (Date - datetime.now()).days * 24 * 3600 + (Date - datetime.now()).seconds
		
		if TimeCheck > 0 and Item == 0 and Mode == "Name":
			return(EventList(count,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 1 and Mode == "Name":
			return(EventList(count+1,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 2 and Mode == "Name":
			return(EventList(count+2,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 3 and Mode == "Name":
			return(EventList(count+3,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 4 and Mode == "Name":
			return(EventList(count+4,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 5 and Mode == "Name":
			return(EventList(count+5,"Name"))
			sys.exit()

		elif TimeCheck > 0 and Item == 0 and Mode == "Time":
			ETime = EventList(count)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 1 and Mode == "Time":
			ETime = EventList(count+1)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 2 and Mode == "Time":
			ETime = EventList(count+2)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 3 and Mode == "Time":
			ETime = EventList(count+3)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 4 and Mode == "Time":
			ETime = EventList(count+4)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 5 and Mode == "Time":
			ETime = EventList(count+5)
			Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
			return(CountdownToDate(Date))
			sys.exit()
		count = count + 1
		
def EndedEvent(Item=0,Mode="null"):
	count = 0
	while (count < EventList(0,"Count")):
		ETime = EventList(count)
		Date = datetime.strptime(ETime, '%Y-%m-%d %H:%M:%S')
		TimeCheck = (Date - datetime.now()).days * 24 * 3600 + (Date - datetime.now()).seconds
		if TimeCheck > 0 and Item == 2 and Mode == "Name":
			return(EventList(count-1,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 1 and Mode == "Name":
			return(EventList(count-2,"Name"))
			sys.exit()
			
		elif TimeCheck > 0 and Item == 0 and Mode == "Name":
			return(EventList(count-3,"Name"))
			sys.exit()
		count = count + 1

# Printing to file
E3Event1 = NextEventV2(0,"Time")
E3EventName1 = NextEventV2(0,"Name")
E3Event2 = NextEventV2(1,"Time")
E3EventName2 = NextEventV2(1,"Name")
E3Event3 = NextEventV2(2,"Time")
E3EventName3 = NextEventV2(2,"Name")
E3Event4 = NextEventV2(3,"Time")
E3EventName4 = NextEventV2(3,"Name")
E3Event5 = NextEventV2(4,"Time")
E3EventName5 = NextEventV2(4,"Name")
E3Event6 = NextEventV2(5,"Time")
E3EventName6 = NextEventV2(5,"Name")

E3EventEnd1 = EndedEvent(0,"Name")
E3EventEnd2 = EndedEvent(1,"Name")
E3EventEnd3 = EndedEvent(2,"Name")


if E3Event1 != None and E3Event2 != None and E3Event3 != None:
	E3EndedColor = ""
	E3Color = ""
	E3ColorEnd = ""
	
	E31L1 = E3EventName1[0]
	E32L1 = E3EventName1[1:len(E3EventName1)]
	E3String1 = '%s%s%s%s' %(E3Color, E31L1, E3ColorEnd, E32L1)
	
	E31L2 = E3EventName2[0]
	E32L2 = E3EventName2[1:len(E3EventName2)]
	E3String2 = '%s%s%s%s' %(E3Color, E31L2, E3ColorEnd, E32L2)
	
	E31L3 = E3EventName3[0]
	E32L3 = E3EventName3[1:len(E3EventName3)]
	E3String3 = '%s%s%s%s' %(E3Color, E31L3, E3ColorEnd, E32L3)
	
	E31L4 = E3EventName4[0]
	E32L4 = E3EventName4[1:len(E3EventName4)]
	E3String4 = '%s%s%s%s' %(E3Color, E31L4, E3ColorEnd, E32L4)
	
	E31L5 = E3EventName5[0]
	E32L5 = E3EventName5[1:len(E3EventName5)]
	E3String5 = '%s%s%s%s' %(E3Color, E31L5, E3ColorEnd, E32L5)
	
	E31L6 = E3EventName6[0]
	E32L6 = E3EventName6[1:len(E3EventName6)]
	E3String6 = '%s%s%s%s' %(E3Color, E31L6, E3ColorEnd, E32L6)
	
	file = open('/home/mindi/.config/awesome/scripts/db/EndedEvents.txt','w')
	file.write(E3EndedColor + E3EventEnd1  + E3ColorEnd + '\n')
	file.write(E3EndedColor + E3EventEnd2  + E3ColorEnd + '\n')
	file.write(E3EndedColor + E3EventEnd3  + E3ColorEnd + '\n')
	file.close()
	
	file = open('/home/mindi/.config/awesome/scripts/db/NextEvents.txt','w')
	file.write(E3String1 + '\n')
	file.write(E3Event1.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd).replace("min", E3Color + "min" + E3ColorEnd) + '\n')
	file.write(E3String2 + '\n')
	file.write(E3Event2.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd) + '\n')
	file.write(E3String3 + '\n')
	file.write(E3Event3.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd) + '\n')
	file.write(E3String4 + '\n')
	file.write(E3Event4.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd) + '\n')
	file.write(E3String5 + '\n')
	file.write(E3Event5.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd) + '\n')
	file.write(E3String6 + '\n')
	file.write(E3Event6.replace("h", E3Color + "h" + E3ColorEnd).replace("day ", E3Color + "day " + E3ColorEnd).replace("days ", E3Color + "days " + E3ColorEnd))
	file.close()
else:
	file = open('/home/mindi/.config/awesome/scripts/db/NextEvents.txt','w')
	file.write('No events \n')
	file.write('')
	file.close()
	
