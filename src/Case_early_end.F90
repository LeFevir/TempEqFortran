if (T(x_c,y_c,z_c)>100.0) then
        print *, 'The Temperature has reached 100 Celsius degrees'
        print *, 'All further calculations are pointless'
        write (510) t56
        write (500) T
        
        !Dose OUT  
        write (511, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz
                if (t56(i1,i2,i3)>100.0) then
                    write (511, '(2x,f12.5,2x,f12.5,2x,I15)') Y(i2), Z(i3), 100
                else       
                    write (511, '(2(2x,f12.5),(2x,f14.2))') Y(i2), Z(i3), t56(i1,i2,i3)
                endif
            end do
        end do        
        
        !Temp OUT
        write (501, *) numy, numz
        i1=x_c
        do i2=1,numy
            do i3=1,numz    
                    write (501, '(2(2x,f12.5),(2x,f6.2))') Y(i2), Z(i3), T(i1,i2,i3)
            end do
        end do
        
     exit !Exit from the Cycle
endif 