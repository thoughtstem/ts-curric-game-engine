

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