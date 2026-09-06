
clear

pha = niftiread('/autofs/space/symphony_002/users/kwokshing/external_data/QSM_Consensus_Paper_Example_Data_Result_Code_v0.2.1/derivatives/SEPIA/SIEMENS/Monopolar/GRE/sub-001_ses-SIEMENS_acq-Monopolar_part-phase_GRE.nii.gz');
unwrap_phase = niftiread('/autofs/space/symphony_002/users/kwokshing/external_data/QSM_Consensus_Paper_Example_Data_Result_Code_v0.2.1/converted/SIEMENS/Monopolar/GRE/output_unwrap/Sepia_part-phase_desc-unwrapped.nii.gz');

%%
z = 65;
lw = 2;
ms = 10;

% ROI coordinates (in mag's own [x,y] indexing, i.e. mag(x,y,z,:) - based
% on the UNCROPPED image, same convention as export_Q1.m/export_A1.m)
roiA = struct('y',129,'x',66, 'label','Globus Pallidus');
roiB = struct('y',138,'x',56, 'label','Putamen');
roiC = struct('y',147,'x',68, 'label','Caudate nucleus');
roiD = struct('y',120,'x',63, 'label','Corticospinal tract');

% crop window, in the same [x,y] convention as the ROIs above
ycrop = 109:160;
xcrop = 47:121;
nyc = numel(ycrop); % needed to map [x,y] into the cropped+rot90'd image's [col,row]

figure('Position',[476         344        1445         375]);
tiledlayout(1,3,'TileSpacing','tight');
img = rot90(pha(xcrop,ycrop,z,1));
nexttile;   ax1 = gca; imshow(img,[-4096 4095]); title('Echo #1'); hold(ax1,'on');
% img = rot90(pha(xcrop,ycrop,z,end));
% nexttile;   ax2 = gca; imshow(img,[-4096 4095]);cb2 = colorbar; title('Echo #5'); hold(ax2,'on');

% the phase data is stored in the DICOM integer range [-4096,4095], which
% is linearly mapped to [-pi,pi] radians. Add the min/max (-4096/4095)
% as explicit ticks, labelled with their radian equivalent, in addition
% to the existing (auto) numeric ticks.
% for cb = [cb1, cb2]
%     cb.Ticks      = sort(unique([cb.Ticks(2:end-1), -4096, 4095]));
%     cb.TickLabels = arrayfun(@(t) sprintf('%g',t), cb.Ticks, 'UniformOutput', false);
%     cb.TickLabels{cb.Ticks == -4096} = '-4096 (-\pi)';
%     cb.TickLabels{cb.Ticks == 4095}  = '4095 (\pi)';
% end

nexttile;   axM = gca;
% A (Globus Pallidus)
x = roiA.x; y = roiA.y;
hA = plot(squeeze(pha(x,y,z,:)),'x-','LineWidth',lw,'MarkerSize',ms);hold on;
% B (Putamen)
x = roiB.x; y = roiB.y;
hB = plot(squeeze(pha(x,y,z,:)),'o-','LineWidth',lw,'MarkerSize',ms);
% C (Caudate nucleus)
x = roiC.x; y = roiC.y;
hC = plot(squeeze(pha(x,y,z,:)),'^-','LineWidth',lw,'MarkerSize',ms);
% D (Corticospinal tract)
x = roiD.x; y = roiD.y;
hD = plot(squeeze(pha(x,y,z,:)),'s-','LineWidth',lw,'MarkerSize',ms);
xlim([1,5]);
ylabel('Phase (radian)');
xlabel('Echo number');
title('Wrapped phase')
ylim([-4096 4095])
% the raw data here is stored in the DICOM integer range [-4096,4095],
% linearly mapped to [-pi,pi] radians - relabel the y-axis ticks with
% their radian equivalent so this plot reads on the same scale as the
% 'Unwrapped phase' plot to its right.
axM.YTick      = [-4096 -2048 0 2048 4095];
axM.YTickLabel = {'-\pi','-\pi/2','0','\pi/2','\pi'};
legend(roiA.label,roiB.label,roiC.label,roiD.label,'Location','southoutside')
grid on;

nexttile;
% A (Globus Pallidus)
x = roiA.x; y = roiA.y;
hA2 = plot(squeeze(unwrap_phase(x,y,z,:)),'x-','LineWidth',lw,'MarkerSize',ms);hold on;
% B (Putamen)
x = roiB.x; y = roiB.y;
hB2 = plot(squeeze(unwrap_phase(x,y,z,:)),'o-','LineWidth',lw,'MarkerSize',ms);
% C (Caudate nucleus)
x = roiC.x; y = roiC.y;
hC2 = plot(squeeze(unwrap_phase(x,y,z,:)),'^-','LineWidth',lw,'MarkerSize',ms);
% D (Corticospinal tract)
x = roiD.x; y = roiD.y;
hD2 = plot(squeeze(unwrap_phase(x,y,z,:)),'s-','LineWidth',lw,'MarkerSize',ms);
xlim([1,5]);
ylim([-pi 3*pi])
ylabel('Phase (radian)');
title('Unwrapped phase')
xlabel('Echo number');
grid on;
% Mark the 4 ROI locations on both (cropped) echo images with a '+' in
% the same colour as their corresponding curve above - note the
% [x,y] -> [col,row] mapping accounts for both the crop and the rot90()
% applied to the images before display.
labelOffset = 1; % pixels, moves the text label above the marker
rois = {roiA, roiB, roiC, roiD};
cols = {hA.Color, hB.Color, hC.Color, hD.Color};
for k = 1:numel(rois)
    plotCol = rois{k}.x - xcrop(1) + 1;
    plotRow = nyc - rois{k}.y + ycrop(1);
    for ax = [ax1]
        plot(ax, plotCol, plotRow, '+', 'Color', cols{k}, 'LineWidth', lw, 'MarkerSize', ms);
        text(ax, plotCol, plotRow-labelOffset, rois{k}.label, 'Color', cols{k}, 'FontSize',8, 'FontWeight','bold', ...
            'HorizontalAlignment','left', 'VerticalAlignment','bottom');
    end
end

exportgraphics(gcf,'exercise2_unwrapped_phase_plot3.png')
