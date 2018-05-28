%Script for Y3 (1st control is "attend-ignore and ignore-ignore")

%Note that "X444no" function is for no peak channel case, but it can be
%used in normal case.
close all;E1to10over95ChNumberLCRnewX444no(Y3l240r24444attend_fft,Y3l240r248ignore_fft,Y2l240r240fft,channels202XY)
close all;E1to10over95ChNumberLCRnewX444no(Y3l240r24444ignore_fft,Y3l240r248ignore_fft,Y2l240r240fft,channels202XY)

%Note that 8HzBB is used as 1st control for 5.71HzBB
close all;E1to10over95ChNumberLCRnewX571(Y3l240r24571attend_fft,Y3l240r248ignore_fft,Y2l240r240fft,channels202XY)
close all;E1to10over95ChNumberLCRnewX571(Y3l240r24571ignore_fft,Y3l240r248ignore_fft,Y2l240r240fft,channels202XY)

close all;E1to10over95ChNumberLCRnewX8(Y3l240r248attend_fft,Y3l240r24444ignore_fft,Y2l240r240fft,channels202XY)
close all;E1to10over95ChNumberLCRnewX8(Y3l240r248ignore_fft,Y3l240r24444ignore_fft,Y2l240r240fft,channels202XY)