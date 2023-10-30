(
s.quit;
Server.default.options.inDevice_("Microfono MacBook Pro");
Server.default.options.outDevice_("Soundflower (64ch)");
s.boot;
s.options.numOutputBusChannels = 6;
)

(
SynthDef("lp_squared", { | freq = 98, out = 0,  amp = 1.2, release = 3, effectBus, direct = 0.6 |
	var env = Env.adsr(attackTime: 0.01, releaseTime: release, sustainLevel: amp);
	var gen = EnvGen.kr(env, Impulse.kr(0), doneAction: 2);
	var source = gen * BLowPass4.ar(Pulse.ar(freq,0.5,amp), 100);
	Out.ar(out, source);
	Out.ar(effectBus, source * (1 - direct));
}).add;

SynthDef("tutorial-reverb", { arg outBus = 0, inBus;
    var input;
    input = In.ar(inBus, 1);
	16.do({ input = AllpassC.ar(input, 0.04, { Rand(0.001,0.04) }.dup, 3)});
    Out.ar(outBus, input);
}).add;

	SynthDef("bitcrush", { arg out = 0, inBus;
		var audio, efx, f;
        audio = In.ar(inBus,1);
	    efx=Decimator.ar(audio, SinOsc.kr(0.002, 0, 8000, 15000).abs, SinOsc.kr(0.002, 1, 39, 15).abs);
		Out.ar(out, efx);
}).add;


/*b = Bus.audio(s,1);
a = Group.basicNew(s,1);
x = Synth.head(a, "bitcrush", [\inBus, b]);
y = Synth.tail(a, "tutorial-Reverb");*/


b = Bus.audio(s,1);
c = Bus.audio(s, 2);
// y = Synth.new("tutorial-reverb", [\inBus, b]);
// x = Synth.new("bitcrush", [\inBus, b]);

x = Synth.new("bitcrush", [\inBus, b, \out, 2]);
y = Synth.new("bitcrush", [\inBus, c, \out, 3]);
)

{	SinOsc.ar(2000, 0, 31, 31)}.plot

{SinOsc.ar(2000, 0, 50, 20).abs}.plot

(
Pbind(
	\instrument, \lp_squared,
	\freq, Prand([43.midicps, Rest(6), 43.midicps, 46.midicps, 46.midicps, 48.midicps, 51.midicps, 39.midicps], inf),
	\dur, Prand([1.2, 3, 2, 1.5, 2.4] * 8, inf),
	\out, 0,
	\effectBus, b,
	\release, Pkey(\dur) / 2,
	\amp, 0.5
).play;

Pbind(
	\instrument, \lp_squared,
	\freq, Pxrand([43.midicps, 43.midicps, Rest(4), 43.midicps, 46.midicps, 48.midicps, 48.midicps, 51.midicps], inf),
	\dur, Prand([1.1, 3.3,  2.4, 1.5, 2.4] * 10, inf),
	\out, 1,
	\effectBus, c,
	\release, Pkey(\dur) / 2,
	\amp, 0.5
).play;


Pbind(
	\instrument, \lp_squared,
	\freq, Prand([43.midicps, 43.midicps, Rest(9), 46.midicps, 46.midicps, 48.midicps, 51.midicps, 36.midicps], inf) / 2,
	\dur, Prand([1, 3, 2, 1.5, 2.4] * 15, inf),
	\out, [0, 1],
	\effectBus, b,
	\release, Pkey(\dur) / 2.3,
).play;
)