.. _weightings-in-sepia:

Weightings in SEPIA
===================

How does SEPIA compute the weights for dipole field inversion algorithms?
-------------------------------------------------------------------------

SEPIA utilises the inverse of the fieldmap standard deviation map (noisesd.nii.gz) as the weights for potential dipole field inversion algorithms usage. Specifically, The following steps are applied:

Step 1: Invert the fieldmap standard deviation and remove non-value entries (i.e., NaN & inf become 0)

:math:`weights = \dfrac{1}{fieldmapSD}`




