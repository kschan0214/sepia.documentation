.. _method-segmentation-musus100:
.. role::  raw-html(raw)
    :format: html

Multi-modal-fused magnetic Susceptibility (MuSus-100) atlas
===========================================================

`He, C., Guan, X., Zhang, W., Li, J., Liu, C., Wei, H., Xu, X., Zhang, Y., 2022. Quantitative susceptibility atlas construction in Montreal Neurological Institute space: towards histological-consistent iron-rich deep brain nucleus subregion identification. Brain Struct Funct 1–23. <https://doi.org/10.1007/s00429-022-02547-1>`_ 

.. image:: ../images/segmentation/musus100.png

For details regarding the atlas and labels, please refer to the reference above.

There are two possible approaches to bring the atlas labels to the GRE space, which approach will be used depending on the input of the user.

Approach 1: Proving NIFTI data input
------------------------------------

Data required:

- a 3D GRE magnitude NIFTI image (e.g. 1st echo)
- a 3D GRE NIFTI brain mask
- a T1w NIFTI images
- a T1w NIFTI brain mask 
- a Chimap NIFTI image

Procedures:

1. (optional) Bias field correction on both T1w and GRE image using N4BiasFieldCorrection.

2. Coregistration between GRE image and T1w image using rigid-body transformation.

3. Bringing Chimap to T1w space and create a hybrid image using the following equation:

    .. math::
        hybrid = T1w \times \mu Chi
        :label: hybrid

    where T1w is the T1w image normalised to range [0,255] (clipped at 0.5 and 99.5 percentile of masked voxels), mu = 400 and Chi is the magnetic susceptibility map in ppm.

4. Coregistration between the hybrid image and the template hybrid image provided with the atlas using nonlinear transformation (SyN).

5. Applying the derived transformation matrices to bring the atlas labels to the GRE space.

Approach 2: Proving the transformation information derived from ANTs
--------------------------------------------------------------------

Data required:

- a 3D GRE NIFTI image (to define the final space only)
- a GRE to T1w rigid-body transformation matrix file (usually with suffix *_0GenericAffine.mat*)
- a T1w to atlas T1w template affine transformation matrix file (usually with suffix *_0GenericAffine.mat*)
- a T1w to atlas T1w template inverse wrap field (usually with suffix *_1InverseWarp.nii.gz*)

Procedure:

1. The provided transformation information is used to bring the atlas labels to the GRE space.
