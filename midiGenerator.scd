s.boot;

(
//ENVIRONMENT SETUP
~midi_out_ch = 1;
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
m.noteOn(~minilogue_midi_channel, 60, 60);
m.noteOn(~nocoast_midi_channel, 70, 60);

m.allNotesOff(~minilogue_midi_channel);
m.allNotesOff(~nocoast_midi_channel);

// PREPARING PATTERNS OF NOTES \degree OR FREQUENCIES \freq
a = Pbind(\degree, Prand([1, 2, 3, [0, 5]], inf), \dur, Pwhite(7, 17, inf));
b = Pbind(\degree, Prand([13, 14, 15, [12, 17]], inf), \dur, Pwhite(6, 13, inf));

c = Pbind(\freq, Pseq([60, 72, 71, 67, 69, 71, 72, 60, 69, 67], 1), \dur, Pwhite(6, 13, inf));

// CHAIN PATTERN TO MIDI
(a <> (type: \midi, midiout: m, channel: 16)).play;
(b <> (type: \midi, midiout: m, channel: 16)).play;
(c <> (type: \midi, midiout: m, channel: 16)).play;

a.stop;
b.stop;
c.stop;
