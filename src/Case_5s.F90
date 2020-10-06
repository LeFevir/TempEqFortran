if (jt==t_5) then
        print *, '-------------5s---------------'
        
        write (100) T
        write (110) t56
        
        !Dose OUT 
        write (111, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz
                if (t56(i1,i2,i3)>100.0) then
                    write (111, '(2x,f12.5,2x,f12.5,2x,I15)') Y(i2), Z(i3), 100
                else       
                    write (111, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), t56(i1,i2,i3)
                endif
            end do
           ! write (*, '(A, f6.2, A)') 'Filling Text: ', 100.0*real(i1)/real(numx), '% completed'
        end do
        
        !Temp OUT
        write (101, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz    
                    write (101, '(2(2x,f12.5),(2x,f6.2))') Y(i2), Z(i3), T(i1,i2,i3)
            end do
        end do
endif 