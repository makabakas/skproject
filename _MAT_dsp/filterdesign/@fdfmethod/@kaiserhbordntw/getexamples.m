function examples = getexamples(this)
%GETEXAMPLES Get the examples.

%   Copyright 2007 The MathWorks, Inc.

examples = {{ ...
    'Design a 90th order halfband lowpass Kaiser windowed filter with a ', ...
    '% transition width of .05.',...
    'N = 90; % Filter Order', ...
    'TW = .05; % Transition Width', ...
    'h  = fdesign.halfband(''Type'',''Lowpass'',''N,TW'',N,TW);', ...
    'Hd = design(h,''kaiserwin'');', ...
    'fvtool(Hd)'}};

% [EOF]