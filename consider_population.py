import numpy as np
import os
import pandas as pd


fil = open("/Users/mac/Desktop/IP/Datasets/Crime_Women_States_CSV_incorporated_population.csv", 'w')
fil.write("STATE/UT,CRIME HEAD,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012\n")

array = pd.read_csv("/Users/mac/Desktop/IP/Datasets/Crime_Women_States_CSV.csv")
info = np.array(array)

pop = pd.read_csv("/Users/mac/Desktop/IP/Datasets/Population.csv")
pop = np.array(pop)

pop_changes = pop[:,1]/10

d = {}
states = pop[:,0]
years = np.array([1,2,3,4,5,6,7,8,9,10,11])

for i in range(len(pop)):
	d[states[i]] = years * pop_changes[i]/100

for j in range(len(info)):
	row = info[j]
	first_val = row[2]
	updations = first_val * d[row[0]]
	current = row[3:]
	newvalues = current - updations
	newvalues[newvalues < 0] = 0
	towrite = list(map(int, newvalues))
	secondpart = ",".join([str(x) for x in towrite])  
	string = row[0] + "," + row[1] + "," + str(row[2]) + "," + secondpart + "\n"
	fil.write(string)

fil.close()
	

