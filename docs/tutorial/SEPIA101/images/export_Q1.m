
clear

mag = niftiread('/autofs/space/symphony_002/users/kwokshing/external_data/QSM_Consensus_Paper_Example_Data_Result_Code_v0.2.1/derivatives/SEPIA/SIEMENS/Monopolar/GRE/sub-001_ses-SIEMENS_acq-Monopolar_part-mag_GRE.nii.gz');

%%
z = 65;
lw = 2;
ms = 10;

% ROI coordinates (in mag's own [x,y] indexing, i.e. mag(x,y,z,:))
% Tissue type is labelled on the image (it's visually obvious from
% location); which curve (A/B/C) belongs to which is the actual question.
roiA = struct('x',104,'y',168,'label','WM');
roiB = struct('x',65, 'y',129,'label','Deep GM');
roiC = struct('x',93, 'y',167,'label','Cortical GM');

ny = size(mag,2); % needed to map [x,y] into the rot90'd image's [col,row]

figure('Position',[476         406        1043         313]);
tiledlayout(1,3,'TileSpacing','tight');
img = rot90(mag(:,:,z,1));
nexttile;   ax1 = gca; imshow(img,[0 1000]);colorbar ;title('Echo #1'); hold(ax1,'on');
img = rot90(mag(:,:,z,end));
nexttile;   ax2 = gca; imshow(img,[0 600]);colorbar  ;title('Echo #5'); hold(ax2,'on');

nexttile;
% A (WM)
x = roiA.x; y = roiA.y;
plot(squeeze(mag(x,y,z,:)),'x-','LineWidth',lw,'MarkerSize',ms);hold on;
% B (DGM)
x = roiB.x; y = roiB.y;
plot(squeeze(mag(x,y,z,:)),'o-','LineWidth',lw,'MarkerSize',ms);
% C (cGM)
x = roiC.x; y = roiC.y;
plot(squeeze(mag(x,y,z,:)),'^-','LineWidth',lw,'MarkerSize',ms);
xlim([1,5]);
ylabel('Signal Intensity (a.u.)');
xlabel('Echo number');
legend('A','B','C')
grid on;

% Mark the same 3 ROI locations on both echo images with a plain green '?'
% and the tissue name (all green - unlike the answer figure, the point
% here is NOT to give away which curve/tissue is which) - note the
% [x,y] -> [col,row] mapping needed because the images were rotated with
% rot90() before display.
labelOffset = 15; % pixels, moves the text label above the marker
rois = {roiA, roiB, roiC};
for k = 1:numel(rois)
    plotCol = rois{k}.x;
    plotRow = ny - rois{k}.y + 1;
    for ax = [ax1, ax2]
        text(ax, plotCol, plotRow, '?', 'Color','g', 'FontSize',10, 'FontWeight','bold', ...
            'HorizontalAlignment','center', 'VerticalAlignment','middle');

        if k <3
            text(ax, plotCol+20, plotRow-labelOffset, rois{k}.label, 'Color','g', 'FontSize',8, 'FontWeight','bold', ...
            'HorizontalAlignment','center', 'VerticalAlignment','bottom');
        else
            text(ax, plotCol-40, plotRow-labelOffset, rois{k}.label, 'Color','g', 'FontSize',8, 'FontWeight','bold', ...
            'HorizontalAlignment','center', 'VerticalAlignment','bottom');
;
        end

    end
end

exportgraphics(gcf,'exercise1_q1.png')
