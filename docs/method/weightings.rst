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
   :label: rescale

Step 3
^^^^^^
Clipping extreme values (possibly outliers). To further aviod outliers causing any issues, the values at the ends of the histogram are clipped by a boundary. The boundary is defined as:  
Lower bound (lb) - 0; upper bound (ub) - 3IQR

.. math::
   weights(weights<lb) = 0
   :label: clippinglb

.. math::
   weights(weights>ub) = 3 \times IQR(weights(mask))
   :label: clippingub

And this is the final output of the weights.

How does SEPIA compute the weights before v1?
---------------------------------------------

Before v1, SEPIA utilises also the inverse of the field map standard deviation map as the weights, but the normalisation is different and more primitive. 

Step 1
^^^^^^
Invert the fieldmap standard deviation and remove non-value entries (i.e., NaN & inf become 0)

.. math::
   weights = \frac{1}{fieldmapSD}
   :label: invertsd2

Step 2
^^^^^^
Normalisation of the weights. Normalisation is performed by simply using the maximum value in the data so that the range of the weights is between 0 and 1

.. math::
   weights(mask) = \frac{weights(mask)}{max(weights(mask))}
   :label: max

The issue with this approach is the maximum value of the weights before normalisation might not be in the similar range across subjects and acquisition protocols, and it is prone to the outliers in the data. As a results, there could be a global differences in terms of the magnitude of the weights between subjects and between protocols. If a dipole field inversion algorithm takes the weights for the processing, the differences of the overall weights magnitude could impose intrinsic regularisation differences between datasets (e.g. among subjects of the same study) even the same regularisation parameter is used. 

.. warning::
    The medians of the weights of these two versions are in different range (before v1: less than 1 and around 0.3-0.4; v1: close to 1), meaning it may require adjusting the regularisation parameter to match regularisation effect between the two versions. Therefore, it is not recommended to mix software versions in a single study.

