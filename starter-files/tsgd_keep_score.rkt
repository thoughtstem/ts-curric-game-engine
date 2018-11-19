(define (score-entity)
  (sprite->entity (text "Score: 0" 32 "yellow")
                  #:name "score"
                  #:position (posn 120 30)
                  #:components (counter 0)
                               (static)
                               (detect-collide "player" "item" (do-many (change-counter-by 100)
                                                                        (draw-counter "Score: " 32 "yellow")))))