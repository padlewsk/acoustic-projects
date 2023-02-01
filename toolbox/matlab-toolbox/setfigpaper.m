function setfigpaper(fwidth,fsize,fname)
%
% 	setfigpaper(fwidth,fsize,fname)
%
%	set image dimensions for paper printing:
% 		fwidth=8;        figure width in centimeters
% 		fsize=10;          font size in points
% 		fname='arial';    font name
%
%       optional!!!
%       if size(fwidth)==[1,2], second element is aspect relation
%
%	example: setfigpaper(10,8,'arial')
%	example: setfigpaper([10,1.5],8,'arial')
% =========================================================================


% get figure handles
set(gcf,'WindowStyle','normal');

set(gcf,'paperunits','centimeters');
set(gcf,'units','centimeters');
% get figure postion and aspect
pos=get(gcf,'position');
if length(fwidth)==1;
    honw=0.8500;
else
	honw=fwidth(2);%pos(4)/pos(3);
end%pos(4)/pos(3);

fheight=fwidth(1)*honw;
haxis=findobj(gcf,'type','axes');
naxis=length(haxis);
% set figure position
set(gcf,'PaperSize',[fwidth(1) fheight]);
set(gcf,'Position',[pos(1) pos(2) fwidth(1) fheight]);
% set(gcf,'PaperPosition',[0 0 fwidth fheight]);
set(gcf,'color',[1 1 1]);

set(0,'ShowHiddenHandles','on');
for iaxis=1:naxis
    htext=findobj(gcf,'type','text');
    htext2=findobj(haxis(iaxis),'tag','legend');
    ht=findobj(haxis(iaxis),'type','text');
    hxlab=get(haxis(iaxis),'xlabel');
    hylab=get(haxis(iaxis),'ylabel');

    % set text propieties
    set(haxis(iaxis),'box','on');
    set(ht,'fontname',fname,'fontsize',fsize);
    set([hxlab hylab],'fontname',fname,'fontsize',fsize);
    set(haxis(iaxis),'fontname',fname,'fontsize',fsize)
    set(haxis(iaxis),'XMinorTick','on','YMinorTick','on')
    set(gca,'linewidth',0.5)
    set(htext,'fontname',fname,'fontsize',fsize);
    set(htext2,'fontname',fname,'fontsize',fsize);
end
set(gcf, 'PaperPosition', [0 0 fwidth(1) fheight]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [fwidth(1) fheight]); %Keep the same paper size

drawnow
set(0,'ShowHiddenHandles','off');