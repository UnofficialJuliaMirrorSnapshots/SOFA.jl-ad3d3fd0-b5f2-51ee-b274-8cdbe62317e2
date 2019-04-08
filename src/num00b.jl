export iauNum00b
"""
Form the matrix of nutation for a given date, IAU 2000B model.

This function is part of the International Astronomical Union's
SOFA (Standards Of Fundamental Astronomy) software collection.

Status:  support function.

Given:
   date1,date2  double         TT as a 2-part Julian Date (Note 1)

Returned:
   rmatn        double[3][3]   nutation matrix

Notes:

   1. The TT date date1+date2 is a Julian Date, apportioned in any
   convenient way between the two arguments.  For example,
   JD(TT)=2450123.7 could be expressed in any of these ways,
   among others:

         date1          date2

      2450123.7           0.0       (JD method)
      2451545.0       -1421.3       (J2000 method)
      2400000.5       50123.2       (MJD method)
      2450123.5           0.2       (date & time method)

   The JD method is the most natural and convenient to use in
   cases where the loss of several decimal digits of resolution
   is acceptable.  The J2000 method is best matched to the way
   the argument is handled internally and will deliver the
   optimum resolution.  The MJD method and the date & time methods
   are both good compromises between resolution and convenience.

   2. The matrix operates in the sense V(true) = rmatn * V(mean), where
   the p-vector V(true) is with respect to the true equatorial triad
   of date and the p-vector V(mean) is with respect to the mean
   equatorial triad of date.

   3. The present function is faster, but slightly less accurate (about
   1 mas), than the iauNum00a function.

Called:
   iauPn00b     bias/precession/nutation, IAU 2000B

Reference:

   Explanatory Supplement to the Astronomical Almanac,
   P. Kenneth Seidelmann (ed), University Science Books (1992),
   Section 3.222-3 (p114).

This revision:  2013 June 18

SOFA release 2018-01-30

Copyright (C) 2018 IAU SOFA Board.  See notes at end.
"""

# void iauNum00b(double date1, double date2, double rmatn[3][3])

function iauNum00b(date1::Real, date2::Real)
   # Allocate return values
   rmatn = zeros(Float64, 3, 3)

   ccall((:iauNum00b, libsofa_c), Cvoid, 
        (Cdouble, Cdouble, Ptr{Cdouble},), 
        convert(Float64, date1), convert(Float64, date2),
        rmatn)

   return convert(Array{Float64,2}, rmatn')
end