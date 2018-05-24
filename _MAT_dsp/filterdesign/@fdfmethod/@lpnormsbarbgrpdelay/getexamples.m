function examples = getexamples(~)
%GETEXAMPLES Get the examples.

%   Copyright 2010 The MathWorks, Inc.

examples = {{ ...
    'Design an allpass filter with an arbitrary group delay.', ...
    'f = [0 0.02 0.04 0.06 0.08 0.1 0.25 0.5 0.75 1];',...
    'g = [5 5 5 5 5 5 4 3 2 1];',... 
    'w = [2 2 2 2 2 2 1 1 1 1];',...
    'hgd = fdesign.arbgrpdelay(''N,F,Gd'',10,f,g);',...
    'Hgd = design(hgd,''iirlpnorm'',''Weights'',w,''MaxPoleRadius'',0.95);',...
    'fvtool(Hgd,''Analysis'',''grpdelay'')'
    }};


% [EOF]