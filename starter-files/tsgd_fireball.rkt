
(define (rainbow-fireball)
  (sheet->sprite (sheet->rainbow-tint-sheet (circle 10 "solid" "white"))
                 #:rows 12
                 #:columns 1
                 #:row-number (add1 (random 12))
                 #:speed 1))

(define fireball-entity
  (sprite->entity (rainbow-fireball)
                  #:name "fireball"
                  #:position (posn 60 10)
                  #:components (direction 0)
                               (speed 8)
                               (every-tick (move))
                               (after-time 50 die)
                               (on-start (do-many (change-sprite rainbow-fireball)
                                                  (random-direction 0 360)
                                                  ))
                               ))