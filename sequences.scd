// basic event in super collider is ().play
().play
('freq': 440).play;

// event pattern: PBind to sequence events, comes with default values, repeat the 200hz sound on the default synth with duration of 0.5
Pbind(\freq, 200, \dur, 0.5).play

//to livecode a Pbind use a Pdef, first is a name, second is a pattern. This is a single pattern, named so if I play it more and more will not run the same synth on top of itself. but "reload" itself
Pdef(\jhonny, Pbind(\freq, 200, \dur, 0.5)).play

//valued patterns: generate datas and not input them. using Pseq with inf cycles all the list infinite times:

(
"this is a code block, you need ; to separate statements".warn;
Pdef(\jhonny,
	Pbind(
		\freq, Pseq([100, 300, 250], repeats: inf),
		\dur, Pseq([0.25, 0.5], repeats: inf)
	)
).play
)

// a seuence repeated ifinite time
a = Pseq([1, 2, 10000], repeats: inf);
b = a.asStream
b.next

// using notes aka scales deegre; Rest(time) is pause
(
Pdef(\jhonny2,
	Pbind(
		\instrument, \default,
		\degree, Pseq([0, 2, 4, 6, 9, -1], repeats: inf),
		\dur, Pseq([0.25, 0.5, Rest(0.25)], repeats: inf)
	)
).play
)


// random values: Pwhite, white noise in the interval; Pbrown similar, with a step parameter; Prand, Pxrand cicles randomly on a sequence, the second one assures you it wont repeat itself
(
Pdef(\jhonny2,
	Pbind(
		\degree, Prand([0, 4, 5], repeats: inf),
		\dur, Pwhite(0.2, 1)
	)
).play
)

//share data between sequences
(
Pdef(\jhonny2,
	Pbind(
		\instrument, \default,
		\degree, Pseq([12, 2, 4, 6, 9, 1], repeats: inf),
		\dur, 1 / Pkey(\degree)
	)
).play
)
//ptterns inside patterns:
(
Pdef(\jhonny2,
	Pbind(
		\instrument, \default,
		\degree, Pseq([12, 2, 4, 6, 9, 1], repeats: inf),
		\dur, Pseq([0.25, 0.5,  Pwhite(1, 2, 2)], repeats: inf)
	)
).play
)