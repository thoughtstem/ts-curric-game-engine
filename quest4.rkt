#lang racket


(provide quest4)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


(define (collide-death-img)
  (define target (p:frame #:color "red"
                          (p:code (on-collide "bad item" die))))
  
  (define code-img
    (p:code (define (player-entity)
              (sprite->entity player-sprite
                              #:name       "player"
                              #:position   (posn 100 100)
                              #:components
                              #,target
                              (physical-collider)
                              (key-movement 10)
                              (on-start (go-to-pos-inside 'bottom-center))))))

  (code+hints code-img
              (list target (hint (p:text "Put your code here.")))))


(define-image-file collide-death
  images
  (collide-death-img))

(define-webpage random-directions-video
  this-curriculum
  "https://bit.ly/2EknCrb")

(define-racket-file moving-sprite-code
  starter-files
  "tsgd_moving_sprite.rkt")


(define (bad-item-start-game-image)
  (define location (p:code (posn 0 0)))
  
  (define target (p:frame #:color "red"
                          (p:code (bad-item-entity #,location))))
  
  (define code-img
    (p:code (start-game (instructions-entity)
                        #,target
                        (item-entity item-sprite (posn 200 200))
                        (player-entity)
                        (ground-entity (posn (/ WIDTH 2) (- (/ HEIGHT 2) HEIGHT)))
                        (ground-entity (posn (/ WIDTH 2) (/ HEIGHT 2)))
                        bg-entity)))

  (code+hints code-img
              (list target (hint (p:vl-append
                                  (p:text "Put your code here.")
                                  (p:hb-append
                                   (p:text "Experiment with the numbers in")
                                   (p:code (posn 0 0))))))))

(define-image-file bad-item-start-game
  images
  (bad-item-start-game-image))


(define-launcher-list bad-item #;moving-sprite
  paste-the-code-below-into-your-file
  moving-sprite-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)


(define add-sprites-and-edge
  (activity-instructions "Add Bad Item"
                         '()
                         (list
                          (instruction-basic "Add (bad-item-entity) to start-game")
                          (instruction-basic "Use the launch code to see where.")
                          (instruction-basic "Run your game!")
                          (instruction-goal "your bad item in game."))
                        (launcher-img bad-item-start-game)))



;(with-award 2 add-death-to-hero)
(define add-death-on-collide
  (activity-instructions "Make the Bad Item Bad"
                         '()
                         (list
                          (instruction-basic "Make your player die when it touches the bad item.")
                          (instruction-basic "Use the launcher to see how.")
                          (instruction-goal "your hero dying on collision."))
                        (launcher-img collide-death)))




;(with-award 1 test-game) ;Add adjust speed values?
(define test-and-modify-game
  (activity-instructions "Modify and Test Game"
                         '()
                         (list
                          (instruction-basic "Add more bad sprites at different locations.")
                          (instruction-basic "Run and test your game again.")
                          (instruction-goal "your new changes running in game."))
                        (p:scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))



;Add a Moving Bad Sprite
(define day4-2dgame
  (list
   
   (with-award 0 open-file)
   (with-award 0 (load-new-code bad-item))
   (with-award 2 add-sprites-and-edge)
   (with-award 2 add-death-on-collide)
   (with-award 1 test-and-modify-game)
   (choose "any"
          (list
           (with-award 2 (draw-sprite "bad_sprite.png" "Bad Sprite"))
           (with-award 1 (replace-sheet "Bad Sprite"))))))



(define (quest4)
  (map shrink (make-picts "red" "Q4-" day4-2dgame (settings (bg (local-bitmap "bg-arcade.png")) STAR STAR-BONUS STAR-BONUS))))


