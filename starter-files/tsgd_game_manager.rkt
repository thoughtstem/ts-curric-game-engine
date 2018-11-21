
(define (game-manager-entity)
  (time-manager-entity #:components
                       (on-rule player-dead? (stop-game-counter))
                       (on-rule (reached-game-count? 200) (spawn enemy-entity #:relative? #f))
                       ))