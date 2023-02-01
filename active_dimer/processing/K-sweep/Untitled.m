close all
y1=sin(1:100),
y2=cos(1:100)

plot(y1)
ax1=gca

figure
plot(y2)

ax2=gca
set(ax2,'YTickLabel',[])
pos=get(ax1,'position')
set(ax2,'position',pos)