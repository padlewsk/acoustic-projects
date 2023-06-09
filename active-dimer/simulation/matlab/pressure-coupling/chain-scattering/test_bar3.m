Z = randi(100, 16, 10);

figure();
barObj = bar3(Z);
colorbar

for k = 1:length(barObj)
    zdata = barObj(k).ZData;
    barObj(k).CData = zdata;
    barObj(k).FaceColor = 'interp';
end
