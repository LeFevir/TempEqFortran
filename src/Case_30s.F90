if (jt==t_30) then
        print *, '-------------30s---------------'
        write (610) t56
        write (600) T

        !Dose OUT 
        write (611, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz
                if (t56(i1,i2,i3)>100.0) then
                    write (611, '(2x,f12.5,2x,f12.5,2x,I15)') Y(i2), Z(i3), 100
                else       
                    write (611, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), t56(i1,i2,i3)
                endif
            end do
           ! write (*, '(A, f6.2, A)') 'Filling Text: ', 100.0*real(i1)/real(numx), '% completed'
        end do

        !Temp OUT
        write (601, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz    
                    write (601, '(2(2x,f12.5),(2x,f6.2))') Y(i2), Z(i3), T(i1,i2,i3)
            end do
        end do
        
        OPEN(unit=701, file="..\RESULTS\BrunoPhilips\AprxTempXZ_30s.txt", STATUS='REPLACE')
        
        write (701, *) numx, numz
        i2=y_c
        do i1=1,numx
            do i3=1,numz    
                    write (701, '(2(2x,f12.5),(2x,f6.2))') X(i1), Z(i3), T(i1,i2,i3)
            end do
        end do
        
endif