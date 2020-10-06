!Calculating on Half Step of Time
    dt=tau/2.0
    do i1=2, numx-1       
        do i2=2, numy-1
            do i3=2, numz-1
            T1(i1,i2,i3)=T(i1,i2,i3)+0.5*Q(i1,i2,i3)+dt*hi*(T((i1-1),i2,i3)+T((i1+1),i2,i3)-2*T(i1,i2,i3))/(dx*dx)+dt*hi*(T(i1,(i2+1),i3)-2*T(i1,i2,i3)+T(i1,(i2-1),i3))/(dy*dy)+dt*hi*(T(i1,i2,(i3+1))-2*T(i1,i2,i3)+T(i1,i2,(i3-1)))/(dz*dz)
            end do
        end do
    end do

    !Calculating on Full Step of Time
    dt=tau
    do i1=2, numx-1       
        do i2=2, numy-1
            do i3=2, numz-1
            T(i1,i2,i3)=T(i1,i2,i3)+Q(i1,i2,i3)+dt*hi*(T1((i1-1),i2,i3)+T1((i1+1),i2,i3)-2*T1(i1,i2,i3))/(dx*dx)+dt*hi*(T1(i1,(i2+1),i3)-2*T1(i1,i2,i3)+T1(i1,(i2-1),i3))/(dy*dy)+dt*hi*(T1(i1,i2,(i3+1))-2*T1(i1,i2,i3)+T1(i1,i2,(i3-1)))/(dz*dz)
            end do
        end do
    end do
