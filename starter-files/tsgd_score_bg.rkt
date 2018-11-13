(define (score-bg)
  (define score-box (rectangle 200 40 "solid" (color 255 255 255 128)))
  (sprite->entity score-box
                  #:name "score bg"
                  #:position (posn 120 30)
                  #:components (static)))