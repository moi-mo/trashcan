;; luogu P1216
;; input: ((7)(3 8)(8 1 0)(2 7 4 4)(4 5 2 6 5))
;; output: 30
;; operating 2d vector
(define (2dv-ref ve i j)
    (vector-ref (vector-ref ve i) j))
(define-syntax 2dv-set!
    (syntax-rules ()
        ((_ v i j n)
        (let ((ve (vector-ref v i)))
            (begin 
                (vector-set! ve j n)
                (vector-set! v i ve))))))
(define (2dl->2dv l)
    (let ((l (list->vector l)))
        (2dl->2dv-qwq l (vector-length l) 0)))
(define (2dl->2dv-qwq v l i)
    (if (= i l)
        v
        (let ((ve (list->vector (vector-ref v i))))
            (begin
                (vector-set! v i ve)
                (2dl->2dv-qwq v l (+ i 1))))))

(define (dp v i j)
    (if (= -1 i)
        (2dv-ref v 0 0)
        (begin
            (2dv-set! v i j 
                (+ (2dv-ref v i j)
                    (max (2dv-ref v (+ i 1) j) (2dv-ref v (+ i 1) (+ 1 j)))))
            (let ((flag (= j i)))
            (dp v (if flag (- i 1) i) (if flag 0 (+ j 1)))))))


(define v (2dl->2dv (read)))
(display (dp v (- (vector-length v) 2) 0))