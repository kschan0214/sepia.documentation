Background Magnetic Field Removal Algorithms
============================================

Background field removal in QSM
-------------------------------

The phase we measured in a GRE acquisition is affected by not only the brain tissue but also sources like B0 inhomogeneity and air sinus. In order to compute the susceptibility sources only contributed by the brain tissue, it is important to remove all the non-local field effect. Fortunately, the characteristic of the local field is different from that of the non-local field, it is possible to separate the two fields from the unwrapped total field. This standalone application is designed to solve the field separation problem.

**Caution**: It is crucial that the background field contribution is removed accurately in this stage. Otherwise, the remaining field due to background sources will be treated as part of the local field, degrading the quality of QSM result.


.. toctree::
   :maxdepth: 1
   :caption: Supported algorithms in SEPIA
   :name: sec-method-bfr

   bfr/LBV
   bfr/PDF
   bfr/RESHARP
   bfr/SHARP
   bfr/VSHARP_STISuite
   bfr/VSHARP
   bfr/iHARPERELLA
