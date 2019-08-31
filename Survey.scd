//-------------------------------------------------------------------------------------------------------
//Initialize all data

(
 ~server = Server.local.options;
 ~server.numOutputBusChannels = 8;
 ~server.device = "Scarlett 18i20 USB";

~path = "/Users/mac/Desktop/IP/";

(
~data_state_crime = CSVFileReader.read(~path++"Datasets/Crime_Women_States_CSV_incorporated_population.csv",true);
~data_state_crime.removeAt(0);
);

(
~data = CSVFileReader.read(~path++"Datasets/Crime_Women_States_CSV_incorporated_population.csv",true);
~data1 = CSVFileReader.read(~path++"Datasets/Crime_Women_States_CSV_incorporated_population.csv",true);
~data2 = CSVFileReader.read(~path++"Datasets/Crime_Women_States_CSV_incorporated_population.csv",true);
~data.removeAt(0);
~data1.removeAt(0);
~data2.removeAt(0);

~states = ["Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar","Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh","Jammu & Kashmir", "Jharkhand", "Karnataka", "Kerala","Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram","Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim","Tamil Nadu", "Tripura", "Uttar Pradesh", "Uttarakhand","West Bengal", "A&N Islands", "Chandigarh", "D&N Haveli","Daman & Diu", "Delhi UT", "Lakshadweep", "Puducherry","All India"];
~crimes = ["RAPE","KIDNAPPING & ABDUCTION","DOWRY DEATH","ASSAULT","INSULT","CRUELTY BY HUSBAND/RELATIVES","IMMORAL TRAFFIC","INDECENT REPRESENTATION","TOTAL CRIMES"];
~years = ["2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012"];
~numstates = 36;

324.do{|n|
	~data[n].removeAt(0);
	~data[n].removeAt(0);
	~data1[n].removeAt(0);
	~data1[n].removeAt(0);
	if(~data1[n][0]==0,{~data1[n][0]=1};);
	~data2[n].removeAt(0);
	~data2[n].removeAt(0);
};
);

//Normalize by dividing by data[i][0]
(
324.do{|n|
	~data1[n]=~data1[n].asInteger/~data1[n][0].asInteger;
	~data1[n] = ~data1[n].normalize(200,1000);
};
);

//Normalize by subtracting by data[i][0]
(
324.do{|n|
	~data2[n]=(~data2[n].asInteger)-(~data2[n][0].asInteger);
	~data2[n] = ~data2[n].normalize(0,600);
};
);


~buffscream1 = Buffer.read(Server.local, ~path++"Buffers/Girlscream1.wav");
~buffscream2 = Buffer.read(Server.local, ~path++"Buffers/Girlscream2.wav");
~buffscream3 = Buffer.read(Server.local, ~path++"Buffers/Girlscream3.wav");
~buffscream4 = Buffer.read(Server.local, ~path++"Buffers/Girlscream4.wav");
~buffscream5 = Buffer.read(Server.local, ~path++"Buffers/Girlscream5.wav");
~buffscream6 = Buffer.read(Server.local, ~path++"Buffers/Girlscream6.wav");
~buffscream7 = Buffer.read(Server.local, ~path++"Buffers/Girlscream7.wav");
~buffscream8 = Buffer.read(Server.local, ~path++"Buffers/Girlscream8.wav");
~buffscream9 = Buffer.read(Server.local, ~path++"Buffers/Girlscream9.wav");
~buffscream10 = Buffer.read(Server.local, ~path++"Buffers/Girlscream10.wav");



(
SynthDef("Pdefhelp", { arg freq = 0, index = 5, amp = 1;
    var out, array;
	array = Select.ar(index,
		[PlayBuf.ar(2,~buffscream6.bufnum),
			PlayBuf.ar(2,~buffscream1.bufnum),
			PlayBuf.ar(2,~buffscream8.bufnum),
			PlayBuf.ar(2,~buffscream7.bufnum),
			PlayBuf.ar(2,~buffscream10.bufnum),
			PlayBuf.ar(2,~buffscream3.bufnum)]);

	amp.postln;

	out = FreqShift.ar(array, freq) * amp;
	Out.ar([0,1,2,3,4,5], out);
}).add;
)

)



//-------------------------------------------------------------------------------------------------------
//GUI
(

w = Window.new("Main Page",Rect.new(175, 125, 1000, 500));
w.front;
w.background_(Color.white);
~label0 = StaticText.new(w,Rect.new(200,50,600,30))
.string_("DATA SONIFICATION")
.font_(Font("Monaco",25))
.align_(\center);
~description = StaticText.new(w,Rect.new(200,120,650,170))
.string_("Sonification is a process and field of study wherein data is represented through sound. Visual graphs, charts are a common way for expressing data, similarly, sound can also be an affective mode of data representation. Large, detailed data can often not be represents through visual strategies and sonification comes in very useful here. Our aim is to represent chronological data of crimes against women in Indian states.")
.font_(Font("Monaco",14));
~label1 = StaticText.new(w,Rect.new(200,280,600,30))
.string_("Choose category of Sonification to perform")
.font_(Font("Monaco",14));
~choosecateg = PopUpMenu(w,Rect.new(200,310,600,30))
.items_(["","Crimes Rates Against Women in Indian States"])
.allowsReselection_(true)
.action = {
	//------------------------------------------------------------------------------------------------
	if(~choosecateg.value == 1,{//CRIME AGAINST WOMEN
		w.visible_(false);
		~w1 = Window.new(~choosecateg.items[~choosecateg.value],Rect.new(175, 125, 1000, 500));
		~w1.front;
		//~w1.alwaysOnTop_(true);
		~w1.background_(Color.white);
		//Add code for Crime Data
		~label0 = StaticText.new(~w1,Rect.new(200,50,600,30))
		.string_("CRIME RATES AGAINST WOMEN IN INDIAN STATES")
		.font_(Font("Monaco",25))
		.align_(\center);
		~description1 = StaticText.new(~w1,Rect.new(180,80,700,200))
		.string_("Crime against women in India is a growing concern today. Recent years have witnessed significant increase in the number of cases reported. Kindly note, the sounds here indicate the change (increase or decrease) over the years and do not directly imply the magnitude of crime")
		.font_(Font("Monaco",14));
		~label2 = StaticText.new(~w1,Rect.new(200,250,600,30))
		.string_("Choose type of Sonification to perform")
		.font_(Font("Monaco",14));
		~choosetype = PopUpMenu(~w1,Rect.new(200,280,600,30))
		.items_(["", "Change through years for a particular state and crime", "Compare 2 crimes for a particular year and state", "Compare 2 states for a particular year and crime", "Compare 2 years for a particular state and crime"])
		.allowsReselection_(true)
		.action = {
			~choosetype.value.postln;
			//----------------------------------------------------------
			if(~choosetype.value == 1,{//Sequence through years for a particular crime in a particular state - DISCRETE
				"hi1".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				//~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(140,5,800,100))
				.string_("Select any state and crime. Sequence over the data for 12 years discretely and map it to \neither frequency or amplitude.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime = 0;
				~dur = 1;
				~flag = 0;
				~type = 0;

				f = [0].plot(bounds: Rect(0,0,0,0));
				//
				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states)
				.allowsReselection_(true);
				~choosestate.action = {~state = ~choosestate.value;}; //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes)
				.allowsReselection_(true);
				~choosecrime.action = {~crime = ~choosecrime.value;}; //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				/*~label5 = StaticText.new(~w2,Rect.new(200,200,275,30))
				.string_("Select speed")
				.font_(Font("Monaco",14));*/
				/*~choosedur = EZSlider.new(~w2,Rect.new(200,230,275,30),controlSpec:ControlSpec(0.25,10));
				~choosedur.action = {~dur = 1/~choosedur.value;};*/ //if(~flag == 1,{~sig.stop; ~sig = Pbindef(\final, \freq, Pseq(~data2[~crime*~numstates+~state]), \dur, ~dur);[~sig.play,~sig.play];})};

				~label6 = StaticText.new(~w2,Rect.new(375,200,275,30))
				.string_("Select parameter to control")
				.font_(Font("Monaco",14));
				~choosetyp = PopUpMenu(~w2,Rect.new(375,230,275,30))
				.items_(["Frequency","Amplitude"])
				.allowsReselection_(true);
				~choosetyp.action = {~type = ~choosetyp.value;};

				~play = Button(~w2,Rect.new(450,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play.action = {
					s.freeAll;
					s.record("/Users/mac/Desktop/IP/Recordings/sample4.wav");
					~sig.free;

					if(f.parent != nil,
						{
							f.parent.close;
						}
					);

					f = ~data2[~crime*~numstates+~state].plot(bounds:Rect(175,125,350,200), discrete: true);

					~dataar = ~data2[~crime*~numstates+~state];

					~ar = Array.fill(12, 0);
					~arzeros = Array.fill(12, 1);

					for(0, 11, {arg j;	if((~dataar[j] > 100) && (~dataar[j] <= 200), {~ar[j] = 1}, {if((~dataar[j] > 200) && (~dataar[j] <= 300), {~ar[j] = 2}, {if((~dataar[j] > 300) && (~dataar[j] <= 400), {~ar[j] = 3}, {if((~dataar[j] > 400) && (~dataar[j] < 500), {~ar[j] = 4}, {if(~dataar[j] >= 500, {~ar[j] = 5})})})})})});


					if(~type == 0,
						{
							~flag = 1;
							~sig = Pbindef(\final, \instrument, \Pdefhelp, \freq, Pseq(~dataar), \index, Pseq(~ar), \dur, ~dur);
							[~sig.play, ~sig.play, ~sig.play, ~sig.play, ~sig.play, ~sig.play, ~sig.play, ~sig.play];

						}

					);

					if(~type == 1,
						{
							~takeampfrom = ~data[~crime*~numstates+~state].asInteger;
							~takeampfrom = ~takeampfrom.insert(0, ~takeampfrom[0].asInteger);
							~takeampfrom = ~takeampfrom.insert(0, ~takeampfrom[0].asInteger);
							~takeampfrom = ~takeampfrom.normalize(0.2, 100);
							~takeampfrom.postln;
							if(~flag == 1, {~flag = 0});
							~sig.stop;

							{
								(14.do{ |i|
									i.postln;

									if(~flag == 0, {~sig = Synth.new(\Pdefhelp, [\amp, ~takeampfrom[i]]);
									1.wait;
									~sig.free;})

								})
							}.fork(t);

							//~sig = Pbindef(\final, \instrument, \Pdefhelp, \freq, Pseq(0!12), \amp, Pseq(~data2[~crime*~numstates+~state].normalize(0.2,10)), \index, Pseq(~arzeros), \dur, ~dur)
						}
					);

					s.freeAll;
				};

				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					s.stopRecording;
					~sig.stop;
					~flag = 1;
					if(f.parent != nil,
						{
							f.parent.close;
						}
					);

					~w2.close;
					~w1.visible_(true);
				};
			});

			//----------------------------------------------------------
			if(~choosetype.value == 2,{//Compare 2 crimes for a particular year and state

				"hi2".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				//~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(80,5,950,100))
				.string_("Choose any year and state. Pick 2 crimes and compare the level of crime, for the 2 years.")
				.font_(Font("Monaco",14));

				~state = 0;
				~year = 0;
				~crime1 = 0;
				~crime2 = 0;
				~f1 = [0].plot(bounds: Rect(0,0,0,0));
				~f2 = [0].plot(bounds: Rect(0,0,0,0));
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states)
				.allowsReselection_(true);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose year")
				.font_(Font("Monaco",14));
				~chooseyear = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~years)
				.allowsReselection_(true);
				~chooseyear.action = {~year = ~chooseyear.value;};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,35))
				.string_("Choose crime 1")
				.font_(Font("Monaco",14));
				~choosecrime1 = PopUpMenu(~w2,Rect.new(200,238,275,30))
				.items_(~crimes)
				.allowsReselection_(true);
				~choosecrime1.action = {~crime1 = ~choosecrime1.value;};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,35))
				.string_("Choose crime 2")
				.font_(Font("Monaco",14));
				~choosecrime2 = PopUpMenu(~w2,Rect.new(525,238,275,30))
				.items_(~crimes)
				.allowsReselection_(true);
				~choosecrime2.action = {~crime2 = ~choosecrime2.value;};


				~play1 = Button(~w2,Rect.new(290,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play1.action = {

					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					~f1 = [~data[~crime1*~numstates+~state][~year].asInteger].plot(bounds:Rect(175,125,350,100), discrete:true);
					~f1.parent.alwaysOnTop_(true);

					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream2.bufnum),~data[~crime1*~numstates+~state][~year].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\p,~data2[~crime*~numstates+~state][~year1]]);
				};


				~play2 = Button(~w2,Rect.new(615,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play2.action = {

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~f2 = [~data[~crime2*~numstates+~state][~year].asInteger].plot(bounds:Rect(825,125,350,100), discrete:true);
					~f2.parent.alwaysOnTop_(true);
					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream2.bufnum),~data[~crime2*~numstates+~state][~year].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year2]]);
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~w2.close;
					~w1.visible_(true);
				};

			});
			//----------------------------------------------------------
			if(~choosetype.value == 3,{//Compare 2 states for a particular year and crime

				"hi3".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				//~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(120,5,950,100))
				.string_("Choose any crime and year. Pick 2 states and compare the level of crime, for the 2 states.")
				.font_(Font("Monaco",14));


				~crime = 0;
				~year = 0;
				~state1 = 0;
				~state2 = 0;
				~f1 = [0].plot(bounds: Rect(0,0,0,0));
				~f2 = [0].plot(bounds: Rect(0,0,0,0));
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~crimes)
				.allowsReselection_(true);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose year")
				.font_(Font("Monaco",14));
				~chooseyear = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~years)
				.allowsReselection_(true);
				~chooseyear.action = {~year = ~chooseyear.value;};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,35))
				.string_("Choose state 1")
				.font_(Font("Monaco",14));
				~choosestate1 = PopUpMenu(~w2,Rect.new(200,238,275,30))
				.items_(~states)
				.allowsReselection_(true);
				~choosestate1.action = {~state1 = ~choosestate1.value;};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,35))
				.string_("Choose state 2")
				.font_(Font("Monaco",14));
				~choosestate2 = PopUpMenu(~w2,Rect.new(525,238,275,30))
				.items_(~states)
				.allowsReselection_(true);
				~choosestate2.action = {~state2 = ~choosestate2.value;};

				~play1 = Button(~w2,Rect.new(290,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play1.action = {

					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					~f1 = [~data[~crime*~numstates+~state1][~year].asInteger].plot(bounds:Rect(175,125,350,100), discrete:true);
					~f1.parent.alwaysOnTop_(true);

					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream3.bufnum),~data[~crime*~numstates+~state1][~year].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\p,~data2[~crime*~numstates+~state][~year1]]);
				};


				~play2 = Button(~w2,Rect.new(615,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play2.action = {

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~f2 = [~data[~crime*~numstates+~state2][~year].asInteger].plot(bounds:Rect(825,125,350,100), discrete:true);
					~f2.parent.alwaysOnTop_(true);
					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream3.bufnum),~data[~crime*~numstates+~state2][~year].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year2]]);
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~w2.close;
					~w1.visible_(true);
				};

			});
			//----------------------------------------------------------
			if(~choosetype.value == 4,{//Compare 2 years for a particular crime and state
				"hi4".postln;
				~w1.visible_(false);
				~w2 = Window.new(~choosetype.items[~choosetype.value],Rect.new(175, 125, 1000, 500));
				~w2.front;
				//~w2.alwaysOnTop_(true);
				~w2.background_(Color.white);

				~text = StaticText.new(~w2,Rect.new(120,5,950,100))
				.string_("Choose any crime and state. Pick 2 years and compare the level of crime, for the 2 years.")
				.font_(Font("Monaco",14));

				~state = 0;
				~crime = 0;
				~year1 = 0;
				~year2 = 0;
				~f1 = [0].plot(bounds: Rect(0,0,0,0));
				~f2 = [0].plot(bounds: Rect(0,0,0,0));
				//

				~label3 = StaticText.new(~w2,Rect.new(200,100,275,30))
				.string_("Choose state")
				.font_(Font("Monaco",14));
				~choosestate = PopUpMenu(~w2,Rect.new(200,130,275,30))
				.items_(~states)
				.allowsReselection_(true);
				~choosestate.action = {~state = ~choosestate.value;};

				~label4 = StaticText.new(~w2,Rect.new(525,100,275,30))
				.string_("Choose crime")
				.font_(Font("Monaco",14));
				~choosecrime = PopUpMenu(~w2,Rect.new(525,130,275,30))
				.items_(~crimes)
				.allowsReselection_(true);
				~choosecrime.action = {~crime = ~choosecrime.value;};

				~label5 = StaticText.new(~w2,Rect.new(200,200,275,35))
				.string_("Choose year 1")
				.font_(Font("Monaco",14));
				~chooseyear1 = PopUpMenu(~w2,Rect.new(200,238,275,30))
				.items_(~years)
				.allowsReselection_(true);
				~chooseyear1.action = {~year1 = ~chooseyear1.value;};

				~label6 = StaticText.new(~w2,Rect.new(525,200,275,35))
				.string_("Choose year 2")
				.font_(Font("Monaco",14));
				~chooseyear2 = PopUpMenu(~w2,Rect.new(525,238,275,30))
				.items_(~years)
				.allowsReselection_(true);
				~chooseyear2.action = {~year2 = ~chooseyear2.value;};

				~play1 = Button(~w2,Rect.new(290,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play1.action = {

					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					~f1 = [~data[~crime*~numstates+~state][~year1].asInteger].plot(bounds:Rect(175,125,350,100), discrete:true);
					~f1.parent.alwaysOnTop_(true);

					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream2.bufnum),~data2[~crime*~numstates+~state][~year1].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\p,~data2[~crime*~numstates+~state][~year1]]);
				};


				~play2 = Button(~w2,Rect.new(615,300,100,40))
				.states = [["Play", Color.red],["Play", Color.red]];
				~play2.action = {

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~f2 = [~data[~crime*~numstates+~state][~year2].asInteger].plot(bounds:Rect(825,125,350,100), discrete:true);
					~f2.parent.alwaysOnTop_(true);
					/*Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year1],\o2,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year1],\q,~data2[~crime*~numstates+~state][~year2]]);*/
					{FreqShift.ar(PlayBuf.ar(2,~buffscream2.bufnum),~data2[~crime*~numstates+~state][~year2].asInteger)}.play;
					//Synth.new(\one,[\o1,~data2[~crime*~numstates+~state][~year2],\p,~data2[~crime*~numstates+~state][~year2]]);
				};

				//
				~back1 = Button(~w2,Rect.new(465,420,70,30));
				~back1.states = [["Back", Color.black],["Back", Color.black, Color.red]];
				~back1.action = {
					s.freeAll;
					if(~f1.parent != nil,
						{
							~f1.parent.close;
						}
					);

					if(~f2.parent != nil,
						{
							~f2.parent.close;
						}
					);

					~w2.close;
					~w1.visible_(true);
				};
			});
			//----------------------------------------------------------

		};
		~back = Button(~w1,Rect.new(465,420,70,30));
		~back.states = [["Back", Color.black],["Back", Color.black, Color.red]];
		~back.action = {
			~w1.close;
			w.visible_(true);
		};
	});
};
)