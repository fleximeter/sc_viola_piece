// File: convolution_setup.scd
// This file sets up buffers for PartConv.
// You have to calculate the buffer size first, when allocating the buffer,
// then you have to prepare the buffer which runs the FFT and stores the data in the buffer.
// It's a 2-step process.

~convolution_buffers = Dictionary();

// Normal reverb
~convolution_buffers.put("chamber", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["nox_sound"]["chamber"]["buffer"]), 2));
~convolution_buffers["chamber"].preparePartConv(~samples["impulse_responses"]["nox_sound"]["chamber"]["buffer"], ~partconv_size);
~convolution_buffers.put("parking_garage", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["tim_verberne"]["parking_garage_02"]["buffer"]), 2));
~convolution_buffers["parking_garage"].preparePartConv(~samples["impulse_responses"]["tim_verberne"]["parking_garage_02"]["buffer"], ~partconv_size);
~convolution_buffers.put("spring_reverb", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["general"]["spring_reverb"]["buffer"]), 2));
~convolution_buffers["spring_reverb"].preparePartConv(~samples["impulse_responses"]["general"]["spring_reverb"]["buffer"], ~partconv_size);
~convolution_buffers.put("cathedral", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["korg"]["cathedral"]["buffer"]), 2));
~convolution_buffers["cathedral"].preparePartConv(~samples["impulse_responses"]["korg"]["cathedral"]["buffer"], ~partconv_size);
~convolution_buffers.put("studio", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["korg"]["studio"]["buffer"]), 2));
~convolution_buffers["studio"].preparePartConv(~samples["impulse_responses"]["korg"]["studio"]["buffer"], ~partconv_size);
~convolution_buffers.put("alesis_large1", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["alesis_microverb"]["large-1"]["buffer"]), 2));
~convolution_buffers["alesis_large1"].preparePartConv(~samples["impulse_responses"]["alesis_microverb"]["large-1"]["buffer"], ~partconv_size);
~convolution_buffers.put("alesis_small1", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["alesis_microverb"]["small-1"]["buffer"]), 2));
~convolution_buffers["alesis_small1"].preparePartConv(~samples["impulse_responses"]["alesis_microverb"]["small-1"]["buffer"], ~partconv_size);

// Crazy reverb
~convolution_buffers.put("wine_tank", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["general"]["wine_tank"]["buffer"]), 2));
~convolution_buffers["wine_tank"].preparePartConv(~samples["impulse_responses"]["general"]["wine_tank"]["buffer"], ~partconv_size);
~convolution_buffers.put("cave", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["tim_verberne"]["cave_01"]["buffer"]), 2));
~convolution_buffers["cave"].preparePartConv(~samples["impulse_responses"]["tim_verberne"]["cave_01"]["buffer"], ~partconv_size);
~convolution_buffers.put("toilet", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["nox_sound"]["toilet"]["buffer"]), 2));
~convolution_buffers["toilet"].preparePartConv(~samples["impulse_responses"]["nox_sound"]["toilet"]["buffer"], ~partconv_size);
~convolution_buffers.put("fishbowl", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["general"]["fishbowl"]["buffer"]), 2));
~convolution_buffers["fishbowl"].preparePartConv(~samples["impulse_responses"]["general"]["fishbowl"]["buffer"], ~partconv_size);
~convolution_buffers.put("tunnel", Buffer.alloc(s, PartConv.calcBufSize(~partconv_size, ~samples["impulse_responses"]["prodepha"]["tunnel-03"]["buffer"]), 2));
~convolution_buffers["tunnel"].preparePartConv(~samples["impulse_responses"]["prodepha"]["tunnel-03"]["buffer"], ~partconv_size);
