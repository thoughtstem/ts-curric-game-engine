
(define (level2-entity)
  (sprite->entity (draw-title (~a "Level 2!!"))
                  #:position   (posn (/ WIDTH 2) (/ HEIGHT 2))
                  #:name       "level 2"
                  #:components (after-time 100 die)
                               (on-key 'enter die)
                               (on-key 'space die)))