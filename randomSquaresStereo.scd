s.boot;

SynthDef("lp_squared", { | freq = 98.00, out = 0,  amp = 1.2, release = 3, effectBus, direct = 0.6 |
	var env = Env.adsr(attackTime: 0.01, releaseTime: release, sustainLevel: amp);
	var gen = EnvGen.kr(env, Impulse.kr(0), doneAction: 2);
	var source = gen * BLowPass4.ar(Pulse.ar(freq,0.5,amp), 100);
	Out.ar(out, source);
	Out.ar(effectBus, source * (1 - direct));
}).add;

SynthDef("tutorial-Reverb", { arg outBus = 0, inBus;
    var input;
    input = In.ar(inBus, 1);
	16.do({ input = AllpassC.ar(input, 0.04, { Rand(0.001,0.04) }.dup, 3)});
    Out.ar(outBus, input);
}).add;

b = Bus.audio(s,1);
x = Synth.new("tutorial-Reverb", [\inBus, b]);

Pbind(
	\instrument, \lp_squared,
	\freq, Prand([98, Rest(6), 98, 110, 110, 116.54], inf),
	\dur, Prand([1.2, 3, 2, 1.5, 2.4] * 3, inf),
	\out, 0,
	\effectBus, b,
	\release, Pkey(\dur) / 2,
	\amp, 0.5
).play;

Pbind(
	\instrument, \lp_squared,
	\freq, Pxrand([98, 98, Rest(4), 98, 110, 116.54, 116.54], inf),
	\dur, Prand([1.1, 3.3,  2.4, 1.5, 2.4] * 5, inf),
	\out, 1,
	\effectBus, b,
	\release, Pkey(\dur) / 2,
	\amp, 0.5
).play;


Pbind(
	\instrument, \lp_squared,
	\freq, Prand([98, 98, Rest(9), 110, 110, 116.54], inf) / 2,
	\dur, Prand([1, 3, 2, 1.5, 2.4] * 10, inf),
	\out, [0, 1],
	\effectBus, b,
	\release, Pkey(\dur) / 2.3,
).play;
