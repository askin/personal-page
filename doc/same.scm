;Aşkın Yollu - 2004510052
;NOT TURKCE KARAKTERLER DUZGUN GORUNMUYORSA BROWSERINIZIN DIL SECENEGINI UTF-8 YAPIN
;##1
(display "oyuna başlamak için (main) yazınız\nHer Yeni oyuna başlamadan önce Lütfen \"Run\" tuşuna basınız")
(define rowx 0) ;her bir satırda kaç nokta olacağını tutacağımız değer
(define coly 0) ;kaç satır olacağını tutan değişken
(define board '()) ;tablomuzu içinde tutacağımız değişken
(define do-temp " ");main fonksiyonu(6.3) içinde do döngüsünü durdurmak için yaratılan değişken
(define xx 0);main fonksiyonu içinde do döngüsünde kullanmak için yazılan değişken için yaratılan değişken
(define yy 0);main fonksiyonu içinde do döngüsünde kullanmak için yazılan değişken için yaratılan değişken

;##2 Tablo
;##2.1 bu satırlar tabloyu oluşturmak için yazıldı
(define (create-board)
  (define temp 0)
  (define row '()) ;tablo oluşturulurken satırların tutulacağı deişken
  (display "lütfen bir satırda kaç nokta olacağını giriniz ")
  (set! rowx (read))
  (display "\nLütfen kaç satır olacağını yazınız ")
  (set! coly (read))
  (do ((i 0 (+ i  1))) ((= i coly)) ;bu döngü coly kere dönecek ve alt alta gelecek satırları oluşturacak
    (set! row '())
    (do ((j 0 (+ j 1))) ((= j (+ rowx 1)))
      (set! temp (random 4))
      (set! row (append row
                        (case temp
                          [(0) '("K")]
                          [(1) '("M")]
                          [(2) '("Y")]
                          [else '("S")]))))
    (set! board (append board (list row)));her bir satırı tabloyu oluşturacak listeye eklemek için
    )
  (newline))
;##2.2 aşağıdaki satırlar tabloyu düzgün bir şekilde görüntülemek içindir.
(define (display-board)
  (display "   ")
  (do ((j 1 (+ j 1))) ((= j (+ rowx 1)))
    (if (< j 10)
        (display " ")
        (display ""))
    (display j))
  (newline)
  (do ((i 0 (+ i 1))) ((= i coly))
    (display (+ i 1))
    (if (> i 8)
        (display " ")
        (display "  "))
    (display (reverse (cdr (reverse (list-ref board i)))))
    (newline)))

;##3 Bazı işlevsel fonksiyonlar
;##3.1 aşağıdaki satırlar koordinatları verilmiş noktanın belirlemesi için
(define (find-dot x y)
  (list-ref (list-ref board (- x 1)) (- y 1)))

;##3.2aşağıdaki kısım verilen bir noktadaki elemanı değiltirmek için yazılmıştır
(define (change-point cp-x cp-y)
  (set-car! (list-tail (list-ref board (- cp-x 1)) (- cp-y 1)) " "))
;###last
(define (last)
  (do ((i 0 (+ i 1))) ((= i coly))
    (set-car! (list-tail (list-ref board i) rowx) " ")))
;##4 komşuluk bulma ve tabloyu yeniden düzenleme
;##4.1bu kısmı komşuları bulmak ve aynı olanlarını " " karakterine çevirmek için yazıyorum  için yazıyorum
(define temp-point 1)
(define point 0)
(define (find-neig x y)
  (define clr (find-dot x y))
  (let loop ((row x) (col y))
    (cond
      [(> row 1)
       (cond
         [(equal? clr (find-dot ( - row 1) col))
          (begin
            (change-point row col)
            (change-point (- row 1) col)
            (set! temp-point (+ temp-point 1))
            (loop (- row 1) col))])])
    (cond
      [(< row coly)
       (cond
         [(equal? clr (find-dot ( + row 1) col))
          (begin
            (change-point row col)
            (change-point (+ row 1) col)
            (set! temp-point (+ 1 temp-point))
            (loop (+ row 1) col))])])
    (cond
      [(< col rowx)
       (cond
         [(equal? clr (find-dot row (+ col 1)))
          (begin
            (change-point row col)
            (change-point row (+ col 1))
            (set! temp-point (+ 1 temp-point))
            (loop row (+ col 1)))])])
    (cond
      [(> col 1)
       (cond
         [(equal? clr (find-dot row (- col 1)))
          (begin
            (change-point row col)
            (change-point row (- col 1))
            (set! temp-point (+ 1 temp-point))
            (loop row (- col 1)))])])))


;##4.2 oluşan boşlukları doldurma
;##4.2.1 dikeyde oluşan boşlukları doldurma 
;aşağıdaki kodlar tablodaki boşlukları doldurmak amacıyla yazılmıştır
(define (drop2 i j n)
  (cond
    [(and (> i 0) (equal? " " (list-ref (list-ref board (- i 1)) j))) (drop2 (- i 1) j (+ 1 n))]
    [(> i 0) (begin
               (set-car! (list-tail (list-ref board (+ i n)) j) (list-ref (list-ref board (- i 1)) j))
               (set-car! (list-tail (list-ref board (- i 1)) j) " "))]))

(define (drop)
  (do ((i (- coly 1) (- i 1))) ((= i 0))
    (do ((j (- rowx 1) (- j 1))) ((< j 0))
      (cond
        [(equal? " " (list-ref (list-ref board i) j)) (drop2 i j 0)]))))

;##4.2.2 yatayda oluşan boşlukları doldurma
;bu kodlar satırlar arasında oluşacak boşluğu engellemek içindir
(define stop-drop-col 0)
(define empty=? 0)
(define where-empty 0)
(define (drop-col)
  (set! stop-drop-col 0)
  (set! empty=? 0)
  (set! where-empty 0)
  (do ((i 0 (+ i 1))) ((= stop-drop-col 1))
    (cond
      [(not (equal? " " (list-ref (list-ref board (- coly 1)) i))) (set! where-empty (+ where-empty 1))]
      [else (set! stop-drop-col 1)]))
  (set! stop-drop-col 0)
  (do ((i 0 (+ i 1))) ((or (<= (- rowx 1) (+ where-empty empty=?)) (> (+ i where-empty) rowx) (= stop-drop-col 1)))
    (cond
      [(equal? " " (list-ref (list-ref board (- coly 1)) (+ i where-empty))) (set! empty=? (+ empty=? 1))]
      [else (set! stop-drop-col 1)])))

(define (drop-row)
  (do ((j (- coly 1) (- j 1))) ((= j -1))
    (do ((i 0 (+ i 1))) ((= (+ i where-empty empty=?) rowx))
      (set-car! (list-tail (list-ref board j) (+ i where-empty)) (list-ref (list-ref board j) (+ i where-empty empty=?)))
      (set-car! (list-tail (list-ref board j) (+ i where-empty empty=?)) " "))))

(define (check-drop)
  (define stop-do 0)
  (do ((k 0 (+ k 1))) ((or (= stop-do 1) (= k rowx)))
    (cond
      [(equal? (list-ref (list-ref board (- coly 1)) k) " ") (begin
                                                               (set! stop-do 1)
                                                               (drop-col)
                                                               (drop-row))])))


;##5 kontrol
;bu satırlar oyunun bitip bitmediğini kontrol etmek için yazılmıştır
(define gameover 1)
(define (game-over?)
  (define control-go1 0)
  (set! gameover 1)
  (do ((i 1 (+ i 1))) ((= i rowx)) ;bu döngüler satırların kontrolü için yapıldı
    (do ((j 1 (+ j 1))) ((or (= j (+ coly 1)) (= control-go1 1)))
      (cond 
        [(and 
          (not (equal? " " (find-dot j i)))
          (equal? (find-dot j i) (find-dot j (+ i 1))))
         (set! control-go1 1)])))
  (case control-go1
    [(1) (set! gameover  0)]
    [else   (do ((i 1 (+ i 1))) ((= i (+ coly 1))) ;bu döngüler sutunların kontrolü için yazıldı
              (do ((j 1 (+ j 1))) ((or (= j rowx) (= control-go1 1)))
                (cond 
                  [(and 
                    (not (equal? " " (find-dot j i)))
                    (equal? (find-dot j i) (find-dot (+ j 1) i)))
                   (set! control-go1 1)])))])
  (case control-go1
    [(1) (set! gameover  0)]))

;##6 oyunun akıcılaştırılması
;bu kısım oyunun akıcı bir şekilde ilerlemesi için yazılmıştır
;##6.1 Bu kısım hangi satırda işlem yapılacağını belirlemek, düzgün veri girilip girilmediğini kontro etmek ve oyundan çıkma isteğinin bildirilmesi için yapılmıştır.
(define (set-xx)
  (set! xx (read))
  (cond 
    [(equal? "stop" xx) 
     (begin
       (set! do-temp "stop")
       (display "Puanınız: ")
       (display point)
       (display "\nYeni oyuna başlamak için önce \"Run\" tuşuna basınız\nDaha sonra (main) yazınız"))]
    [(or (not (integer? xx)) (< xx 0) (> xx coly)) (begin
                                                     (display "Lütfen geçerli bir satır numarası giriniz")
                                                     (set-xx))]))
;##6.2 Bu kısım hangi sutunda işlem yapılacağını belirlemek ve doğru veriler girilip girilmediğini kontrol etmek için yazılmıştır
(define (set-yy)
  (set! yy (read))
  (if (or (> yy rowx) (< yy 1) (not (integer? yy)))
      (begin
        (display "Lütfen Geçerli bir satır numarası veriniz")
        (set-yy))))

;##6.3bu kısım oyunun oynandığı ana fonksiyondur.
;bu kısım sayesinde fonksiyolar arasındaki koordinasyon sağlanmıştır
(define (main)
  (create-board)
  (last)
  (display-board)
  (do ((do-i 0 (+ do-i 1))) ((equal? do-temp "stop"))
    (game-over?)
    (case gameover
      [(1)
       (begin
         (set! do-temp "stop")
         (display "oyun bitti\n")
         (display "Puanınız: ")
         (display point)
         (display "\nYeni oyuna başlamak için önce \"Run\" tuşuna basınız\nDaha sonra (main) yazınız"))]
      [else
       (display "oyunu durdurmak istiyorsanız yada oyunun bittiğini düşünüyorsanız \"stop\" yazınız\n")
       (display "ya da seçeceiniz noktanın satır numarasını giriniz\n")
       (set-xx)
       (cond
         [(equal? xx "stop") (begin
                               (set! do-temp "stop")
                               (display "Puanınız: ")
                               (display point)
                               (display "\nYeni oyuna başlamak için önce \"Run\" tuşuna basınız\nDaha sonra (main) yazınız"))]
         [else 
          (begin
            (display "Seçeceginiz noktanın sütün numarasını giriniz")
            (set-yy)
            (if (equal? (find-dot xx yy) " ")
                (begin
                  (display "Seçtiğiniz Nokta mevcut Değildir\nLütfen yeni nokta giriniz")
                  (set-xx)
                  (set-yy))
                (begin
                  (find-neig xx yy)
                  (drop)
                  (check-drop)
                  (set! point (+ point (* (sqrt temp-point) temp-point)))
                  (newline)
                  (display-board))))])])))