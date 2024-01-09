from pathlib import Path
import csv

#####  Store your, name, email, student_id and class_number as STRINGS #####
#exercise = "Individual Assignment"
#name = 
#np_email = 
#student_id = 
#class_number = 

#--------------- PART 1: This part of the program is completed for you --------------#

# create a file path to csv file.
fp = Path.cwd()/"deliveryRecords.csv"
drivers = set()
# read the csv file.
with fp.open(mode="r", encoding="UTF-8", newline="") as file:
    reader = csv.reader(file)
    next(reader) # skip header

    # create an empty list for delivery record
    deliveryRecords=[] 

    # append delivery record into the deliveryRecords list
    for row in reader:
        #get the driver id, sales, distance, and event type for each record
        #and append to the deliveryRecords list
        deliveryRecords.append([row[0],row[1],row[2],row[3]])   

for i in deliveryRecords:
    drivers.add(i[0])
#drivers - number of unique drivers
drivers = sorted(drivers)
#print(drivers)


#---------------------------- PART 2: Insert your own code ---------------------------#
# 1. Calculate the earning per delivery job, total earning, total sales
earnsPerDel = 0 
totalEarnings = 0 
eventTypes = {"Regular" : 0 , "Express" : 1, "Premium":2, "Mart" : 3}

# Formula to calculate distance & price
def totalPrice (value):
    total = 0
    if value < 5:
        total = total + value*0.1 
    if value >= 5:
        total = total + 5*0.1
    if value < 12 and value>=5:
        total = total + (value-5)*0.2  
    if value >= 12:
        total = total + (12-5)*0.2
    if value < 22 and value>= 12:
        total = total + (value-12)*0.3
    if value >= 22:
        total = total + (22-12)*0.3
    if value >= 22:
        total = total + (value-22)*0.4
    return(total)


# Earnings per Delivery Job
for i in range (len(deliveryRecords)):
    if(deliveryRecords[i][3] in eventTypes):
        totalEarnings= eventTypes.get(deliveryRecords[i][3]) + totalPrice(float(deliveryRecords[i][2])) + 2.5
        # append earnings to delivery to delivery records
        deliveryRecords[i].append(totalEarnings)
# Total Earnings
totalEarnings = [0]*(len(drivers))
totalSales = [0]*(len(drivers))
SalestoEarningRatio = [0]*(len(drivers))
sales = 0 
for i in range (len(drivers)):
    for j in range (len(deliveryRecords)):
        if(deliveryRecords[j][0] == drivers[i]):
            totalEarnings[i] = totalEarnings[i]+ round(float(deliveryRecords[j][4]),2)
            totalSales[i] = round(round(totalSales[i],2) + round(float(deliveryRecords[j][1].strip('$')),2),2)  
print(totalSales)      

# 2. Calculate the sales to earning ratio

for i in range (len(drivers)):
    SalestoEarningRatio[i] = round(totalSales[i]/totalEarnings[i],2)

#print(SalestoEarningRatio)


# Format Output
out= []
for i in range (len(drivers)):
    out.append([drivers[i],str(totalSales[i]),str(totalEarnings[i]),str(SalestoEarningRatio[i])])




#---------------------------- PART 3: Insert your own code ---------------------------#
# 1. Write the calculated info to a txt file. Name it as paymentSummary.txt.
with open('paymentSummary.txt', 'w') as f:
    outp =""
# print (out) & reformat out
    for i in out:
        outp= outp + ','.join(i) + "\n"
    f.write('PowerLeopard Payment Summary\n================\nDriver ID,Total Sales, Total Earning, Sales to Earnings Ratio\n'+ ''  + outp ) 
