
clear

mag = niftiread('/autofs/space/symphony_002/users/kwokshing/external_data/QSM_Consensus_Paper_Example_Data_Result_Code_v0.2.1/derivatives/SEPIA/SIEMENS/Monopolar/GRE/sub-001_ses-SIEMENS_acq-Monopolar_part-mag_GRE.nii.gz');

%%
z = 65;
lw = 2;
ms = 8;

% ROI coordinates (in mag's own [x,y] indexing, i.e. mag(x,y,z,:))
roiWM  = struct('x',104,'y',168,'label','WM');          % plotted as curve A (x-marker)
roiDGM = struct('x',65, 'y',129,'label','Deep GM');     % plotted as curve B (o-marker)
roiCGM = struct('x',93, 'y',167,'label','Cortical GM'); % plotted as curve C (^-marker)

ny = size(mag,2); % needed to map [x,y] into the rot90'd image's [col,row]

figure('Position',[476         406        1043         313]);
tiledlayout(1,3,'TileSpacing','tight');
img = rot90(mag(:,:,z,1));
nexttile;   ax1 = gca; imshow(img,[0 1000]);colorbar ;title('Echo #1'); hold(ax1,'on');
img = rot90(mag(:,:,z,end));
nexttile;   ax2 = gca; imshow(img,[0 600]);colorbar  ;title('Echo #5'); hold(ax2,'on');

nexttile;
% WM
x = roiWM.x; y = roiWM.y;
hA = plot(squeeze(mag(x,y,z,:)),'x-','LineWidth',lw,'MarkerSize',ms);hold on;
% DGM
x = roiDGM.x; y = roiDGM.y;
hB = plot(squeeze(mag(x,y,z,:)),'o-','LineWidth',lw,'MarkerSize',ms);
%cGM
x = roiCGM.x; y = roiCGM.y;
hC = plot(squeeze(mag(x,y,z,:)),'^-','LineWidth',lw,'MarkerSize',ms);
xlim([1,5]);
ylabel('Signal Intensity (a.u.)');
xlabel('Echo number');
legend('A','B','C')
grid on;

% Mark the same 3 ROI locations on both echo images, with a marker and a
% tissue-name label in the same colour as their corresponding curve above
% (this is the answer figure - it's fine to reveal which curve is which
% tissue here) - note the [x,y] -> [col,row] mapping needed because the
% images were rotated with rot90() before display.
labelOffset = 15; % pixels, moves the text label above the marker
rois = {roiWM, roiDGM, roiCGM};
cols = {hA.Color, hB.Color, hC.Color};
for k = 1:numel(rois)
    plotCol = rois{k}.x;
    plotRow = ny - rois{k}.y + 1;
    for ax = [ax1, ax2]
        plot(ax, plotCol, plotRow, '+', 'Color', cols{k}, 'LineWidth', lw, 'MarkerSize', ms);
        if k <3
            text(ax, plotCol+20, plotRow-labelOffset, rois{k}.label, 'Color', cols{k}, 'FontSize',8, 'FontWeight','bold', ...
                'HorizontalAlignment','center', 'VerticalAlignment','bottom');
        else
            text(ax, plotCol-40, plotRow-labelOffset, rois{k}.label, 'Color', cols{k}, 'FontSize',8, 'FontWeight','bold', ...
                'HorizontalAlignment','center', 'VerticalAlignment','bottom');
        end
    end
end

exportgraphics(gcf,'exercise1_a1.png')
