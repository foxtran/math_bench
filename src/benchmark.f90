module bench
  implicit none
  private
  interface
    subroutine routine(repeats)
      integer, intent(in) :: repeats
    end subroutine routine
  end interface
  type :: benchmark_t
    integer(8)                              :: benchmark_id = -1
    logical(8)                              :: initialized = .false.
    character(len=16)                       :: benchmark_type
    character(len=16)                       :: benchmark_name
    procedure(routine), nopass, pointer     :: routine
    integer(8),                 allocatable :: statistics(:)
  contains
    procedure, pass(this) :: register
    procedure, pass(this) :: run
    procedure, pass(this) :: print_statistics
  end type
  public :: benchmark_t
contains
  subroutine register(this, ID, type, name, routine, max_steps)
    class(benchmark_t), intent(inout) :: this
    integer(8),       intent(in) :: ID
    character(len=*), intent(in) :: type
    character(len=*), intent(in) :: name
    interface
      subroutine routine(repeats)
        integer, intent(in) :: repeats
      end subroutine routine
    end interface
    integer, optional, intent(in) :: max_steps
    ! internal variables
    integer :: max_steps_
    max_steps_ = 1
    if (present(max_steps)) max_steps_ = max_steps
    if (this%initialized)   error stop ""
    if (max_steps_ < 1)     error stop ""
    this%benchmark_id = ID
    this%benchmark_type = trim(adjustl(type))
    this%benchmark_name = trim(adjustl(name))
    this%routine => routine
    allocate(this%statistics(max_steps_), source = -1_8)
    this%initialized = .true.
  end subroutine register
  subroutine run(this, repeats, step)
    class(benchmark_t), intent(inout) :: this
    integer,           intent(in) :: repeats
    integer, optional, intent(in) :: step
    ! internal variables
    integer(8) :: st, ed
    integer :: step_
    step_ = 1
    if (present(step)) step_ = step
    if (step_ < 1)                       error stop ""
    if (.not.allocated(this%statistics)) error stop ""
    if (step_ > size(this%statistics))   error stop ""
    call system_clock(st)
    call this%routine(repeats)
    call system_clock(ed)
    this%statistics(step_) = ed - st
  end subroutine run
  subroutine print_statistics(this)
    class(benchmark_t), intent(in) :: this
    ! internal variables
    integer :: i, imax
    real(8) :: mean_vr, sd_vr, min_vr, max_vr
    real(8), allocatable :: stats(:)
    if (.not.this%initialized) error stop ""
    imax = 0
    do i = 1, size(this%statistics)
      if (this%statistics(i) < 0) exit
      imax = i
    end do
    if (imax == 0) return ! nothing to show
    allocate(stats(imax), source=0.0_8)
    stats = real(this%statistics(1:imax), 8) * 1e-6
    min_vr = minval(stats)
    max_vr = maxval(stats)
    mean_vr = sum(stats) / size(stats)
    sd_vr = sqrt(sum((stats - mean_vr)*(stats - mean_vr)) / size(stats))
    print "(A2,A16,A3,A16,A3,I5,A3,F15.3,A3,F15.3,A3,F15.3,A3,F15.3,A2)", "| ", this%benchmark_type, " | ", this%benchmark_name, " | ", imax, " | ", mean_vr, " | ", sd_vr, " | ", min_vr, " | ", max_vr, " |"
  end subroutine print_statistics
end module bench
