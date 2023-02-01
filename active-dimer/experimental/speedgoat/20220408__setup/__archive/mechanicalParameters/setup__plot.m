%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

clear
close
clf

OCData = open('OC.mat');
CCData = open('CC.mat');
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('../params.m');

%% PLOT  |Z_OC| & |Z_CC| vs F OCData = open('OC.mat');

ff = 1200;

fig_prop = {'Fontsize',45,'TickLabelInterpreter','latex','LineWidth',6,'ClippingStyle', 'rectangle', 'Layer', 'top'};
F = linspace(1,ff,100);
Zs_OC = interp1(OCData.F,OCData.Zs,F,'spline');
Zs_CC = interp1(CCData.F,CCData.Zs,F,'spline');

figure(1);
set(gca,fig_prop{:});
set(gcf,'position',[1000,100, 1200, 1000]);


cmap = copper(4); % Cell array of colors.
hold on
plot(F,abs(Zs_OC),'color',cmap(2,:),'LineWidth',5)
plot(F,abs(Zs_CC),'color',cmap(4,:),'LineWidth',5)
hold on %% must hold on AFTER initial axis is created


linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});



xlabel("Frequency (Hz)",'Interpreter','latex')
ylabel("$Z_{ms}$ ($N/(m\cdot s)$)",'Interpreter','latex')
xlim([1 ff]);
ylim([0 2500]);
%title("Mechanical impedance v",'Interpreter','latex')
box on
grid on
legend("Open Circuit","Closed Circuit",'Location','northeast','Interpreter','latex')
hold off
    


    