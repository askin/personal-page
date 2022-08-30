(define (sezar str lst)
  (let ((str (string-downcase str)) (str2 "") (tmp 0))
  (do ((i 0 (+ i 1)) (j 0 (+ j 1))) ((= j (string-length str)))
    (if (= i (length lst))
        (set! i 0))
    (set! str2 
          (string-append
           str2 
           (string (integer->char
                    (begin
                      (set! tmp (+ (list-ref lst i )
                       (char->integer (string-ref str j))))
                      (cond
                        [(> tmp 122) (- tmp 26)]
                        [else tmp])))))))
    (values str2)))