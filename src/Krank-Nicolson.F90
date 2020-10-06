!Krank-Nicolson Scheme------------------

!--T1------------------
Allocate(xsi(numx),eta(numx))
!Cycle on Y,Z
do i3=2,(numz-1)
do i2=2,(numy-1)
    !boundary conditions for i1
    xsi(numx)=0.0
    eta(numx)=T0
    !Calculating for X
    do i1=(numx-1),2,-1
        xsi(i1)=A1/(C1-A1*xsi(i1+1))
        eta(i1)=(A1*eta(i1+1)+(T(i1,i2,i3)+g1*(T(i1-1,i2,i3)+T(i1+1,i2,i3)-2*T(i1,i2,i3))))/(C1-A1*xsi(i1+1))
    end do
    !Calculating T1
    do i1=1, (numx-1)
        T1(i1+1,i2,i3)=xsi(i1+1)*T1(i1,i2,i3)+eta(i1+1)
    end do
end do
end do
!End of Cycle on Y,Z
deallocate(xsi,eta)

!---T1---------------------

!---T2---------------------
Allocate(xsi(numy),eta(numy))
!Cycle on X,Z
do i3=2,(numz-1)
do i1=2,(numx-1)
    !boundary conditions for i2
    xsi(numy)=0.0
    eta(numy)=T0
    !Calculating for Y
    do i2=(numy-1),2,-1
        xsi(i2)=A2/(C2-A2*xsi(i2+1))
        eta(i2)=(A2*eta(i2+1)+(T1(i1,i2,i3)+g2*(T1(i1,i2-1,i3)+T1(i1,i2+1,i3)-2*T1(i1,i2,i3))))/(C2-A2*xsi(i2+1))
    end do
    !Calculating T2
    do i2=1, (numy-1)
        T2(i1,i2+1,i3)=xsi(i2+1)*T2(i1,i2,i3)+eta(i2+1)
    end do
end do
end do
!End of Cycle on X,Z
deallocate(xsi,eta)
!---T2---------------------

!---T3---------------------
Allocate(xsi(numz),eta(numz))
!Cycle on X,Y
do i2=2, (numy-1)
do i1=2, (numx-1)
    !boundary conditions for i3
    xsi(numz)=0.0
    eta(numz)=T0
    !Calculating for Z
    do i3=(numz-1),2,-1
        xsi(i3)=A3/(C3-A3*xsi(i3+1))
        eta(i3)=(A3*eta(i3+1)+(T2(i1,i2,i3)+g3*(T2(i1,i2,i3-1)+T2(i1,i2,i3+1)-2*T2(i1,i2,i3))+Q(i1,i2,i3)))/(C3-A3*xsi(i3+1))
    end do
    !Calculating T(j+1)
    do i3=1, (numz-1)
        T(i1,i2,i3+1)=xsi(i3+1)*T(i1,i2,i3)+eta(i3+1)
    end do
end do
end do
!End of Cycle on X,Y
deallocate(xsi,eta)
!---T3---------------------

!WE HAVE T(j+1)!!!!!!