PROGRAM  TEMPNEWMETHOD
! Program for TEMPERATURE AND DOSE Calculations
IMPLICIT NONE

REAL :: pi = 4.0*atan(1.0), alphadB, alpha, cp, ro, hi,I0

REAL :: x0, y0, z0, zM, R0, R02, T0
REAL :: dx, dy, dz, tau, dt
REAL :: g1,g2,g3,A1,A2,A3,C1,C2,C3

INTEGER :: numx, numy, numz, numt, i1, i2, i3, jt, jPrint
INTEGER :: t_5, t_10, t_15, t_20, x_c, y_c, z_c, y_s, tst(3)

REAL, ALLOCATABLE :: X(:), Y(:), Z(:), Q(:,:,:), T(:,:,:), T1(:,:,:), T2(:,:,:), t56(:,:,:), Q2(:,:,:)
REAL, ALLOCATABLE :: xsi(:), eta(:)

!*****************************************************************

! All values in SI
!alphadB=0.42                     !Alpha in dB/cm/MHz
!alpha=alphadB*1.0*100/8.686     !Alpha in 1/m
!alpha=2.5e-2 !alpha in 1/m
!cp=4200.0                       !Heat capacity for water
!hi=1.42e-7                       !Thermal Diffusivity for water

ro=1000.0                       !Density
!kt=0.6
!hi=kt/(cp*ro)
hi=1.93e-7                        !Thermal Diffusivity for tissue
cp=3060.0                           !Heat capacity for tissue
alphadB=0.42                     !Alpha in dB/cm/MHz
alpha=alphadB*1.0*100/8.686      !Alpha in 1/m


R0=0.5                          !Constant for Dose Calc

!I0=2.7366        !Initial Intensity in W/сm2
!I0=2.52        !Initial Intensity in W/сm2
I0=40
I0=I0*10000  !Initial Intensity in W/m2

T0=35.0                         !Initial Temperature

!Step of time
tau=1.0e-3
!Number of Points of time
numt=20.0/tau

!Time points
t_5=5.0/tau
t_10=10.0/tau
t_15=15.0/tau
t_20=20.0/tau

!Start point of calculations
!x0=-3.0e-3
!y0=-10.0e-3
!z0=120.0e-3

x0=-10.0e-3
y0=-10.0e-3
z0=110.5e-3

!Coordinate of matter's begining
zM=110.5e-03

!number of points
!numx=241
!numy=401
!numz=201

numx=801
numy=801
numz=219

!Step
!dx = 0.025e-03
!dy = 0.05e-03
!dz = 0.1e-03

dx = 0.025e-03
dy = 0.025e-03
dz = 0.183e-03
!!!!!!!!!!!!!!!!!!
!Шаг для 30 Вт!!!!!!
!dz = 0.179e-03
!cz = 110

!Шаг для 40 Вт!!!!!!
!dz = 0.183e-03
!cz = 109

!Central point
!x_c=121
!y_c=201
!z_c=101

x_c=401
y_c=401
z_c=109

!Side point
!y_s=105
y_s=216

!Sets when it's time to print
jPrint=1
!-------------------------------------------------------------------

Allocate(Z(numz), Y(numy), X(numx), Q(numx,numy,numz))!, Q2(numx,numy,numz))

!Filling Coordinates' Matrix
do i3=1,numz
Z(i3)=z0+(i3-1)*dz
end do

do i2=1,numy
Y(i2)=y0+(i2-1)*dy
end do

do i1=1,numx
X(i1)=x0+(i1-1)*dx
end do
!----------------------------
!Reading from File with Intensity
OPEN(unit=100, file="f:\Educ\АКУСТИКА\Семестр 7\Решетка\Источники\OutDataHeatPg_rect_40", FORM='BINARY')
read(100) Q
close(100)

!OPEN(unit=100, file="..\DATA comp\AprxInt1.BIN", FORM='BINARY')
!read(100) Q2
!close(100)

print *, 'Intensity Reading Completed'
!-----------------------------

!Intensity out - Normalization
!Q2=Q*40/(2.0*alpha*1.5e-3)     !I/I0
!INCLUDE 'SourcesOut.f90'
INCLUDE 'SourcesOut.f90'



!Normalization
Q=Q*I0/(ro*cp*1.5e-3)

!Q2=Q

!----------------------
!IN TISSUE
!do i3=1,numz
!        Q2(:,:,i3)=Q2(:,:,i3)*exp(-2*alpha*(Z(i3)-zM))
!end do
!---------------------------
!Value of heat sources
!Q2=2.0*alpha*Q2/(ro*cp)
!-----------------------------------------


Allocate(T(numx,numy,numz), T1(numx,numy,numz), T2(numx,numy,numz), t56(numx,numy,numz))

!Initial conditions
T(:,:,:)=T0
T1(:,:,:)=T0
T2(:,:,:)=T0
t56=0.0
!-------------------

!Opening files for writing
OPEN(unit=10, file="..\RESULTS\20\TempRiseMPeak.txt", STATUS='REPLACE')
write (10, '(2x,f6.4,5x,f5.2)') 0.0, T(x_c,y_c,z_c)
OPEN(unit=11, file="..\RESULTS\20\TempRiseSPeak.txt", STATUS='REPLACE')
write (11, '(2x,f6.4,5x,f5.2)') 0.0, T(x_c,y_s,z_c)
!OPEN(unit=12, file="..\RESULTS\TempRiseLin.txt", STATUS='REPLACE')
!write (12, '(2x,f6.4,5x,f5.2)') 0.0, T(x_c,y_c,z_c)
OPEN(unit=100, file="..\RESULTS\20\AprxTemp_05s.bin", FORM='BINARY')
OPEN(unit=101, file="..\RESULTS\20\AprxTempYZ_05s.txt", STATUS='REPLACE')
OPEN(unit=110, file="..\RESULTS\20\AprxDose_05s.bin", FORM='BINARY')
OPEN(unit=111, file="..\RESULTS\20\AprxDoseYZ_05s.txt", STATUS='REPLACE')
OPEN(unit=200, file="..\RESULTS\20\AprxTemp_10s.bin", FORM='BINARY')
OPEN(unit=201, file="..\RESULTS\20\AprxTempYZ_10s.txt", STATUS='REPLACE')
OPEN(unit=210, file="..\RESULTS\20\AprxDose_10s.bin", FORM='BINARY')
OPEN(unit=211, file="..\RESULTS\20\AprxDoseYZ_10s.txt", STATUS='REPLACE')
OPEN(unit=300, file="..\RESULTS\20\AprxTemp_15s.bin", FORM='BINARY')
OPEN(unit=301, file="..\RESULTS\20\AprxTempYZ_15s.txt", STATUS='REPLACE')
OPEN(unit=310, file="..\RESULTS\20\AprxDose_15s.bin", FORM='BINARY')
OPEN(unit=311, file="..\RESULTS\20\AprxDoseYZ_15s.txt", STATUS='REPLACE')
!OPEN(unit=400, file="..\RESULTS\AprxTemp_20s.bin", FORM='BINARY')
!OPEN(unit=401, file="..\RESULTS\AprxTempYZ_20s.txt", STATUS='REPLACE')
!OPEN(unit=410, file="..\RESULTS\AprxDose_20s.bin", FORM='BINARY')
!OPEN(unit=411, file="..\RESULTS\AprxDoseYZ_20s.txt", STATUS='REPLACE')

OPEN(unit=500, file="..\RESULTS\20\AprxTemp_end.bin", FORM='BINARY')
OPEN(unit=501, file="..\RESULTS\20\AprxTempYZ_end.txt", STATUS='REPLACE')
OPEN(unit=510, file="..\RESULTS\20\AprxDose_end.bin", FORM='BINARY')
OPEN(unit=511, file="..\RESULTS\20\AprxDoseYZ_end.txt", STATUS='REPLACE')
!----------------------------------------------------------------

!OPEN(unit=100, file="f:\TPro\MS Visual Studio\Projects\TempNewMethod\RESULTS\AprxDose_15s.bin", FORM='BINARY')
!read(100) t56
!close(100)
!
!OPEN(unit=100, file="f:\TPro\MS Visual Studio\Projects\TempNewMethod\RESULTS\AprxTemp_15s.bin", FORM='BINARY')
!read(100) T
!close(100)


!Constants for calculations (FOR PERFOMANCE)
!--------------------------------------
g1=0.5*hi*tau/(dx*dx)
g2=0.5*hi*tau/(dy*dy)
g3=0.5*hi*tau/(dz*dz)
A1=g1
A2=g2
A3=g3
C1=1+2*g1
C2=1+2*g2
C3=1+2*g3
R02=R0/2.0
Q=Q*tau
!---------------------------------------

!CALCULATIONS
!*********************************************
!Cycle on Time
do jt=1, numt
    !TEMPERATURE CALCULATION
    !INCLUDE 'OldScheme.F90'
    INCLUDE 'Krank-Nicolson.F90'

    !DOSE CALCULATION
    INCLUDE 'DoseCalc.f90'

    if (mod(jt,jPrint)==0) then
        !Printing on Display Main and Side Temperature
        write (*, '(f6.2, A, f7.4, A)') T(x_c,y_c,z_c),' in Center Max. Time: ', jt*tau, 's'
       !write (*, '(A, f6.2)') 'Without Diffusion: ', T0+jt*Q(x_c,y_c,z_c)
        write (*, '(f6.2, A)') T(x_c,y_s,z_c),' in Side Max.'

        !write (*, '(A, f7.3)') '-------------Time left (min): ', (numt-jt)*(c_time)/60

        !Printing of TempRise in File
        write (10, '(2x,f7.4,5x,f6.2)') jt*tau, T(x_c,y_c,z_c) !Main Peak
        write (11, '(2x,f7.4,5x,f6.2)') jt*tau, T(x_c,y_s,z_c) !Side Peak
    endif

     INCLUDE 'Case_5s.F90'
     INCLUDE 'Case_10s.F90'
     INCLUDE 'Case_15s.F90'
     INCLUDE 'Case_early_end.F90'
end do
!End of Cycle on Time

print *, 'Calculations have been FINISHED!!!'

close(10)
close(11)
!close(12)
close(100)
close(101)
close(110)
close(111)
close(200)
close(201)
close(210)
close(211)
close(300)
close(301)
close(310)
close(311)
!close(400)
!close(401)
!close(410)
!close(411)
close(500)
close(501)
close(510)
close(511)

Deallocate(Z,X,Y,Q,T,T1,T2,t56)

pause 'Press Enter to Exit'

END program