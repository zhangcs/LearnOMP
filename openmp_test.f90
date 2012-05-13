!==========================================================
      program TestAccelerateRatio
!==========================================================
     use omp_lib
      implicit real*8(a-h,o-z)
      implicit integer*4(i-n)
      
!      write(*,*) 'Please enter dimension'
!      read(*,*)  ndim
      ndim = 2000
      
!c      compute(ndim)
      
      call Matvec(ndim)
      
      end
!c=====================================================================	
      subroutine compute(n)
!c=====================================================================
      implicit real*8(a-h,o-z)
      implicit integer*4(i-n)
      
      dimension a(n), b(n), c(n)
      do i=1, n
         a(i) = 2.0
         b(i) = 3.0
      enddo
      
      write(*,*) n
      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO NUM_THREADS(1)
      do i=1, n
         c(i)=a(i)*b(i)
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time 1', end_time-start_time,'second'

      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO NUM_THREADS(2)
      do i=1, n
         c(i)=a(i)*b(i)
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time Nothing', end_time-start_time,'second'
      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(STATIC) NUM_THREADS(2)
      do i=1, n
         c(i)=a(i)*b(i)
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time STATIC', end_time-start_time,'second'

      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(DYNAMIC, n/2) NUM_THREADS(2)
      do i=1, n
         c(i)=a(i)*b(i)
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time DYNAMIC', end_time-start_time,'second'
      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(GUIDED) NUM_THREADS(2)
      do i=1, n
         c(i)=a(i)*b(i)
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time GUIDED', end_time-start_time,'second'

      return
      end
!c=====================================================================	
      subroutine Matvec(n)
!c=====================================================================
      use omp_lib
      implicit real*8(a-h,o-z)
      implicit integer*4(i-n)
      
!      dimension A(n,n), x(n), c(n)
             allocatable A(:,:), x(:), c(:)

                    allocate(A(n,n))
                           allocate(x(n))
                                  allocate(c(n))

      
      do i=1, n
         x(i) = 1.5
      enddo
      
      do i=1, n
         do j=1, n
            A(i,j) = 1.0
         enddo
      enddo
      
      write(*,*) n
      call OMP_SET_NUM_THREADS(2)
      start_time = OMP_GET_WTIME()
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed timessssss 1', end_time-start_time,'second'
      do i=1,n
       if (dabs(c(i)- n*1.5d0 )>1.0e-12) then
               print*,i, c(i),'wrong!!!'
       endif
      enddo

      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO NUM_THREADS(2)
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time 1', end_time-start_time,'second'

      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO NUM_THREADS(2)
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time Nothing', end_time-start_time,'second'
      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(STATIC) NUM_THREADS(2)
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time STATIC', end_time-start_time,'second'

      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(DYNAMIC, n/2) NUM_THREADS(2)
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time DYNAMIC', end_time-start_time,'second'
      
      start_time = OMP_GET_WTIME()
!$OMP PARALLEL DO SCHEDULE(GUIDED) NUM_THREADS(2)
      do i=1, n
         t = 0.0
         do j=1, n
            t = t+A(i,j)*x(j)
         enddo
         c(i) = t
      enddo
!$OMP END PARALLEL DO
      end_time = OMP_GET_WTIME()
      write(*,*) 'Elapsed time GUIDED', end_time-start_time,'second'



      return
      end
