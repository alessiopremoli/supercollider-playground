s.boot;


(
//ENVIRONMENT SETUP
~midi_out_ch = 2;
~minilogue_midi_channel = 16;
~nocoast_midi_channel = 17;

currentEnvironment;
)



(
//MIDI_SETUP
MIDIClient.init;
MIDIClient.destinations;

m = MIDIOut(~midi_out_ch);
)


//SENDING MIDIS
m.noteOn(~minilogue_midi_channel, 53);
m.noteOn(~nocoast_midi_channel, 70, 60);

m.allNotesOff(~minilogue_midi_channel);
m.allNotesOff(~nocoast_midi_channel);

// PREPARING PATTERNS OF NOTES \degree OR FREQUENCIES \freq
a = Pbind(\degree, Prand([1, 2, 3, [0, 5]], inf), \dur, Pwhite(7, 17, inf));
b = Pbind(\degree, Prand([13, 14, 15, [12, 17]], inf), \dur, Pwhite(6, 13, inf));

x = [41, 46, 51, 55, 56, 58, 61];

y = x + 12
z = x + 24

c = Pbind(\freq, Pseq(x, inf), \dur, Pwhite(6, 13, inf));
d = Pbind(\freq, Pseq([ 53, 58, 63, 67, 68, 70, 73 ], inf), \dur, Pwhite(6, 13, inf));

// CHAIN PATTERN TO MIDI
(a <> (type: \midi, midiout: m, channel: 16)).play;
(d <> (type: \midi, midiout: m, channel: 16)).play;
(c <> (type: \midi, midiout: m, channel: 16)).play;

a.stop;
b.stop;
c.stop;
d.stop;



m.allNotesOff(~minilogue_midi_channel);
m.noteOn(~minilogue_midi_channel, 41);

