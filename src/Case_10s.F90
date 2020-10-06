if (jt==t_10) then
        print *, '-------------10s---------------'
        write (210) t56
        write (200) T
        
        !Dose OUT  
        write (211, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz
                if (t56(i1,i2,i3)>100.0) then
                    write (211, '(2x,f12.5,2x,f12.5,2x,I15)') Y(i2), Z(i3), 100
                else       
                    write (211, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), t56(i1,i2,i3)
                endif
            end do
        end do        
        
        !Temp OUT
        write (201, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz    
                    write (201, '(2(2x,f12.5),(2x,f6.2))') Y(i2), Z(i3), T(i1,i2,i3)
            end do
        end do
endif  