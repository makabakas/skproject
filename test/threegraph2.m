time=ui(:,1);
ui1=(ui(:,2)+395)/6553.5*20;ui11=ui1-mean(ui1(1:80,1));
ui2=(ui(:,3)+162)/6553.5*20;ui22=ui2-mean(ui2(1:80,1));
uioto=(ui(:,4)-220)/6553.5*10000;%

figure;
plot(time,uioto/3000,'Color',[0.5 0.5 0.5]);hold on;
plot(time,ui11,'b','LineWidth',2);hold on;
grid on;set(gca,'YDir','reverse');
ylim([-10 10]);xlim([0 1100]);
title('Left');xlabel('(ms)');ylabel('(microV)');

figure;
plot(time,uioto/3000,'Color',[0.5 0.5 0.5]);hold on;
plot(time,ui22,'b','LineWidth',2);hold on;
grid on;set(gca,'YDir','reverse');
ylim([-10 10]);xlim([0 1100]);
title('Right');xlabel('(ms)');ylabel('(microV)');

figure;
plot(time,uioto,'k');
grid on;
xlim([0 1100]);
title('uĻi');xlabel('(ms)');ylabel('(a.u.)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% time=aa(:,1);
% aa1=(aa(:,2)-81)/6553.5*200;aa11=aa1-mean(aa1(1:80,1));
% aa2=(aa(:,3)-23)/6553.5*200;aa22=aa2-mean(aa2(1:80,1));
% aaoto=(aa(:,4)-219)/6553.5*200;
% 
% subplot(3,1,1)
% plot(time,aa11,'b');hold on;
% grid on;
% ylim([-10 10]);xlim([0 1100]);
% title('ķûË');xlabel('(ms)');ylabel('(microV)');
% 
% subplot(3,1,2)
% plot(time,aa22,'r');hold on;
% grid on;
% ylim([-10 10]);xlim([0 1100]);
% title('EûË');xlabel('(ms)');ylabel('(microV)');
% 
% subplot(3,1,3)
% plot(time,aaoto,'k');
% grid on;
% xlim([0 1100]);
% title('aĻa');ylim([-300 300]);xlabel('(ms)');ylabel('(a.u.)');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% time=ao(:,1);
% ao1=(ao(:,2)+126)/6553.5*200;ao11=ao1-mean(ao1(1:80,1));
% ao2=(ao(:,3)+108)/6553.5*200;ao22=ao2-mean(ao2(1:80,1));
% aooto=(ao(:,4)-219)/6553.5*200;
% 
% subplot(3,1,1)
% plot(time,ao11,'b');hold on;
% grid on;
% ylim([-10 10]);xlim([0 1100]);
% title('ķûË');xlabel('(ms)');ylabel('(microV)');
% 
% subplot(3,1,2)
% plot(time,ao22,'r');hold on;
% grid on;
% ylim([-10 10]);xlim([0 1100]);
% title('EûË');xlabel('(ms)');ylabel('(microV)');
% 
% subplot(3,1,3)
% plot(time,aooto,'k');
% grid on;
% xlim([0 1100]);
% title('aĻo');ylim([-300 300]);xlabel('(ms)');ylabel('(a.u.)');




