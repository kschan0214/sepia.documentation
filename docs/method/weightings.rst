.. _weightings-in-sepia:

Weightings in SEPIA
===================

How does SEPIA compute the weights for dipole field inversion algorithms?
-------------------------------------------------------------------------

SEPIA utilises the inverse of the fieldmap standard deviation map (noisesd.nii.gz) as the weights for potential dipole field inversion algorithms usage. Specifically, The following steps are applied:

Step 1
^^^^^^
Invert the fieldmap standard deviation and remove non-value entries (i.e., NaN & inf become 0)

.. math::
   weights = \frac{1}{fieldmapSD}
   :label: invertsd

Step 2
^^^^^^
Normalisation of the weights. To establish more comparable weights between subjects and between protocols, the weights are then normalised to have the median close to 1 and interquartile range (IQR) around 0.33 inside the signal mask. This is performed using the method modified from the robust normalisation in machine learning:

2.1: Robust z-score normalisation
.. math::
   weights(mask) = \frac{weights(mask) - median(weights(mask))}{IQR(weights(mask))}
   :label: robust

2.2: Rescale and re-centre
.. math::
   weights(mask) = \frac{weights(mask)}{3} + 1
   :label: robust

Step 3
^^^^^^
Clipping extreme values (possibly outliers). To further aviod outliers causing any issues, the values at the ends of the histogram are clipped by a boundary. The boundary is defined as:
Lower bound (lb) - 0; upper bound (ub) - 3IQR

.. math::
   weights(weights<lb) = 0
   weights(weights>ub) = 3 \times IQR(weights(mask))
   :label: clipping

And this is the final output of the weights.
