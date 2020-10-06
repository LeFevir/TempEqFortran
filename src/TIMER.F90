function timer( ) ! Returns Proc Time
real(8) :: timer ! in seconds
integer(4) :: ival(8)
call date_and_time(values = ival)
timer = dble(ival(8)) * 0.001_8 + dble(ival(7)) + dble(ival(6)) * 60.0 + dble(ival(5)) * 3600.0
end function timer