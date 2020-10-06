if (jt==t_20) then
        print *, '-------------20s---------------'
        write (410) t56
        write (400) T

        !Dose OUT 
        write (411, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz
                if (t56(i1,i2,i3)>100.0) then
                    write (411, '(2x,f12.5,2x,f12.5,2x,I15)') Y(i2), Z(i3), 100
                else       
                    write (411, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), t56(i1,i2,i3)
                endif
            end do
           ! write (*, '(A, f6.2, A)') 'Filling Text: ', 100.0*real(i1)/real(numx), '% completed'
        end do

        !Temp OUT
        write (401, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz    
                    write (401, '(2(2x,f12.5),(2x,f6.2))') Y(i2), Z(i3), T(i1,i2,i3)
            end do
        end do
endif