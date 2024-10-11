// This file loads samples.
~samples = Dictionary.new;
(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "guitar.scd").load;
(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "impulse_responses.scd").load;
(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "viola.arco.scd").load;
(PathName.new(thisProcess.nowExecutingPath).parentPath ++ "viola.pizz.scd").load;
