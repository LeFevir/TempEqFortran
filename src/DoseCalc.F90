!DOSE CALCULATION
if (T(x_c,y_c,z_c)<43.0) then
        t56=t56+tau*R02**(56.0-T)
else
        t56=t56+tau*R0**(56.0-T)
endif