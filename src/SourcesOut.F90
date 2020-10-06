OPEN(unit=100, file="..\RESULTS\Heat_X.txt", STATUS='REPLACE')
write (100, *) numx
        i2=y_c
        i3=z_c
        do i1=1,numx
            write (100, '(f12.5,2x,f12.5)') X(i1), Q(i1,i2,i3)
        end do

close(100)
print *, 'Intensity Writing X Completed'

OPEN(unit=100, file="..\RESULTS\Heat_Y.txt", STATUS='REPLACE')
write (100, *) numy
        i1=x_c
        i3=z_c
        do i2=1,numy
            write (100, '(f12.5,2x,f12.5)') Y(i2), Q(i1,i2,i3)
        end do

close(100)
print *, 'Intensity Writing Y Completed'
OPEN(unit=100, file="..\RESULTS\Heat_Z.txt", STATUS='REPLACE')
write (100, *) numz
        i1=x_c
        i2=y_c
        do i3=1,numz
            write (100, '(f12.5,2x,f12.5)') Z(i3), Q(i1,i2,i3)
        end do

close(100)
print *, 'Intensity Writing Z Completed'


!Plane OUT
OPEN(unit=100, file="..\RESULTS\Heat_YZ.txt", STATUS='REPLACE')
write (100, *) numy, numz
i1=x_c
do i2=1,numy
    do i3=1,numz      
            write (100, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), Q(i1,i2,i3)
    end do
end do
close(100)
print *, 'Intensity Writing YZ Completed'

OPEN(unit=100, file="..\RESULTS\Heat_XZ.txt", STATUS='REPLACE')
write (100, *) numx, numz
i2=y_c
do i1=1,numx
    do i3=1,numz      
            write (100, '(2(2x,f12.5),(2x,f14.2))') X(i1), Z(i3), Q(i1,i2,i3)
    end do
end do
close(100)
print *, 'Intensity Writing XZ Completed'

