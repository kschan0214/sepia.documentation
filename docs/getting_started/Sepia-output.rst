SEPIA Output Files
==================

Since v1.3.0, most quantitative NIfTI outputs are accompanied by a BIDS-Derivatives-style
JSON sidecar (``<output>.json``, same basename as the NIfTI file) recording
``SoftwareName``, ``SoftwareVersion``, ``GeneratedDate`` and, where applicable,
``Description``, ``Units``, ``Sources`` and ``Parameters``. Sidecar coverage is noted per
file below; masks and some auxiliary/preprocessing outputs do not currently get one.
A single ``dataset_description.json`` is also written once at the root of the output
directory (see `Other output files`_).

Output files of preprocessing (denoising / upsampling)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>part-mag_desc-denoised.nii.gz          | Tensor-MPPCA denoised magnitude data (if denoising is selected).   | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-denoised.nii.gz        | Tensor-MPPCA denoised phase data (if denoising is selected).       | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>sigma.nii.gz                           | Estimated noise standard deviation map from denoising.             | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>SNRgain.nii.gz                         | Estimated SNR gain map from denoising.                             | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>P.nii.gz                               | Number of signal components retained by denoising.                 | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-mag_desc-upsampled.nii.gz         | Upsampled magnitude data (if upsampling is selected; desc- becomes | No       |
|                                                | denoisedUpsampled when denoising also ran).                        |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-upsampled.nii.gz       | Upsampled phase data (if upsampling is selected; same desc-        | No       |
|                                                | chaining as above).                                                |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_upsampled.nii.gz                  | Signal mask resampled onto the upsampled grid (if upsampling is    | No       |
|                                                | selected).                                                         |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>sepia_header.mat                       | SEPIA header (matrix size, voxel size, etc.) updated for the       | N/A      |
|                                                | upsampled grid (if upsampling is selected).                        |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+

Output files of Total field recovery and phase unwrapping
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>fieldmap.nii.gz                        | Unwrapped total frequency shift map in Hz.                         | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>weights.nii.gz                         | SNR-weighted image derived from standard deviation of noise in     | Yes*     |
|                                                | phase data.                                                        |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>noisesd.nii.gz                         | Estimated standard deviation of noise in the phase data.           | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-rad.nii.gz             | Wrapped phase data in radian (only if the input data contains      | No       |
|                                                | voxel exceeds the range of [-pi,pi]).                              |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-unwrapped.nii.gz       | Unwrapped phase data in radian, all echoes (if selected).          | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-reverse.nii.gz         | Inverted phase data, = -(phase).                                   | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-phase_desc-bipolarcorr.nii.gz     | Phase data corrected for bipolar readout gradient.                 | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>bipolar_phase.nii.gz                   | Estimated phase offset induced by bipolar gradient readout.        | No       |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>part-mag_desc-optimalcombined.nii.gz   | Optimally-combined multi-echo magnitude data (if selected).        | Yes*     |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>R2starmap.nii.gz                       | R2* map estimated from the magnitude data (if saved, or computed   | Yes*     |
|                                                | internally for voxel exclusion/mask refinement).                   |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_brain.nii.gz                      | Brain mask derived from brain extraction of FSL/SynthStrip (if     | No       |
|                                                | selected).                                                         |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_localfield.nii.gz                 | Signal mask for background field removal step (if voxel exclusion  | Yes*     |
|                                                | is selected with 'Brain mask' option).                             |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>relativeresidual.nii.gz                | Relative residual derived using mono-exponential model with a      | Yes*     |
|                                                | single frequency shift (if voxel exclusion is selected).           |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>relativeresidualweights.nii.gz         | Weighting maps [0,1] derived from thresholding relative-residual   | Yes*     |
|                                                | map using user-defined value.                                      |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_reliable.nii.gz                   | Derived from thresholding relative-residual map using user-defined | Yes*     |
|                                                | value, or from other mask refinement strategies.                   |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+

\* JSON sidecar is written when running the combined SEPIA one-stop pipeline; not currently
written when this step is run as a standalone module.

Output files of R2\*/T2\* mapping
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>R2starmap.nii.gz                       | R2* map estimated from multi-echo magnitude data.                  | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>T2starmap.nii.gz                       | T2* map (1/R2*).                                                   | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>S0map.nii.gz                           | Extrapolated signal at TE = 0.                                     | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+

Output files of Background field removal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>localfield.nii.gz                      | Local (tissue) field map in Hz.                                    | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_QSM.nii.gz                        | Signal mask for QSM step.                                          | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+

Output files of two-pass masking
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note::
    Since v1.3.0. These files are only generated when a strategy other than 'None' is selected for
    the QSM panel's '2-pass masking' option (see :ref:`method-qsm-two-pass-masking`). The dipole
    inversion is run twice, once with the original mask and once with the refined mask, and the two
    results are then combined into the final susceptibility map.

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>mask_QSM-2pass.nii.gz                  | Refined signal mask used for the second dipole inversion pass,     | Yes      |
|                                                | excluding voxels deemed unreliable by the selected strategy.       |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>R2starmap.nii.gz                       | R2* map used by the 'Monoexponential decay model' strategy (reused | Yes      |
|                                                | if already computed by an earlier step).                          |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>relativeresidual.nii.gz                | Relative residual between measured and modelled magnitude decay,   | Yes      |
|                                                | used by the 'Monoexponential decay model' strategy.                |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>relativeresidualweights.nii.gz         | Weights [0,1] derived from the relative residual ('Monoexponential | Yes      |
|                                                | decay model' strategy only).                                       |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>desc-firstpass_Chimap.nii.gz           | Susceptibility map from the first dipole inversion pass, using the | Yes      |
|                                                | original (unrefined) mask.                                        |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>desc-secondpass_Chimap.nii.gz          | Susceptibility map from the second dipole inversion pass, using    | Yes      |
|                                                | the refined mask.                                                  |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+

Output files of QSM dipole inversion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+------------------------------------------------+--------------------------------------------------------------------+----------+
| Data                                           | Description                                                        | JSON     |
+================================================+====================================================================+==========+
| <Prefix>Chimap.nii.gz                          | Magnetic susceptibility map in ppm. When two-pass masking is       | Yes      |
|                                                | selected, this is the combination of the first- and second-pass    |          |
|                                                | maps above (second-pass values within the refined mask, first-pass |          |
|                                                | values elsewhere).                                                 |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>desc-paramagnetic_Chimap.nii.gz        | Paramagnetic susceptibility component map in ppm (Chi-separation   | Yes      |
|                                                | methods only).                                                     |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>desc-diamagnetic_Chimap.nii.gz         | Diamagnetic susceptibility component map in ppm (Chi-separation    | Yes      |
|                                                | methods only).                                                     |          |
+------------------------------------------------+--------------------------------------------------------------------+----------+
| <Prefix>mask_referenceregion.nii.gz            | Reference region used in QSM normalisation (if selected).          | Yes      |
+------------------------------------------------+--------------------------------------------------------------------+----------+

Other output files
^^^^^^^^^^^^^^^^^^

+--------------------------------+----------------------------------------------------------------------------------------------+
| Data                           | Description                                                                                  |
+================================+==============================================================================================+
| sepia_config.m                 | Automatic generated script by the GUI of SEPIA containing all user specified parameters.     |
+--------------------------------+----------------------------------------------------------------------------------------------+
| run_sepia.log                  | Event log file of the Matlab's command window output.                                        |
+--------------------------------+----------------------------------------------------------------------------------------------+
| run_sepia.error                | Error message of SEPIA (if any).                                                             |
+--------------------------------+----------------------------------------------------------------------------------------------+
| dataset_description.json       | Minimal BIDS-Derivatives dataset description written once at the root of the output          |
|                                | directory (not overwritten if it already exists).                                            |
+--------------------------------+----------------------------------------------------------------------------------------------+
| <output>.json                  | BIDS-Derivatives-style JSON sidecar written alongside (most) NIfTI outputs; see note above.  |
+--------------------------------+----------------------------------------------------------------------------------------------+

Output files of SWI/SMWI
^^^^^^^^^^^^^^^^^^^^^^^^

.. note::
   SWI/SMWI outputs do not currently have JSON sidecars.

+--------------------------------------------+----------------------------------------------------------------------------------------------+
| Data                                       | Description                                                                                  |
+============================================+==============================================================================================+
| <Prefix>swi-phase.nii.gz                   | High-pass filtered phase data.                                                               |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>swi-positive.nii.gz                | Positive susceptibility-weighted images (if selected).                                       |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>minIP-positive.nii.gz              | Positive susceptibility-weighted images with minimum intensity projection over user-defined  |
|                                            | field of view (if selected).                                                                 |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>swi-negative.nii.gz                | Negative susceptibility-weighted images (if selected).                                       |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>minIP-negative.nii.gz              | Negative susceptibility-weighted images with minimum intensity projection over user-defined  |
|                                            | field of view (if selected).                                                                 |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>smwi-paramagnetic.nii.gz           | Paramagnetic susceptibility map-weighted images (if selected).                               |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>smwi-mIP-paramagnetic.nii.gz       | Paramagnetic susceptibility map-weighted images with minimum intensity projection over       |
|                                            | user-defined field of view (if selected).                                                    |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>smwi-diamagnetic.nii.gz            | Diamagnetic susceptibility map-weighted images (if selected).                                |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
| <Prefix>smwi-mIP-diamagnetic.nii.gz        | Diamagnetic susceptibility map-weighted images with minimum intensity projection over        |
|                                            | user-defined field of view (if selected).                                                    |
+--------------------------------------------+----------------------------------------------------------------------------------------------+
