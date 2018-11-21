

(define fireball-entity
  (sprite->entity (rainbow-sprite (circle 10 'solid 'white))
                  #:name "fireball"
                  #:position (posn 60 10)
                  #:components (direction 0)
                               (speed 8)
                               (every-tick (move))
                               (physical-collider)
                               (after-time 50 die)
                               (on-start (random-direction 0 360))
                               ))