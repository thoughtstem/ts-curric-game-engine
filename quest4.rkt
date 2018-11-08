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

(define-webpage copy-paste-video
  this-curriculum
  "https://bit.ly/2HetpC0")

(define-webpage sprites-and-edge-video
  this-curriculum
  "https://bit.ly/2EmMmiK")

(define-webpage collide-video
  this-curriculum
  "https://bit.ly/2HbA3sx")

(define-webpage random-directions-video
  this-curriculum
  "https://bit.ly/2EknCrb")

(define-racket-file moving-sprite-code
  starter-files
  "tsgd_moving_sprite.rkt")


(define-launcher-list moving-sprite
  moving-sprite-code
  paste-the-code-above-into-your-file)


(define add-sprites-and-edge
  (activity-instructions "Add Sprites and Left-Edge"
                         '()
                         (list                        
                          (instruction-basic "Find the (start-game) code at the bottom.")
                          (instruction-basic "Make a new line after (hero-entity) and type:")
                          (instruction-basic (codify "(bad-chest-entity)"))
                          (instruction-basic (codify "(left-edge)"))
                          (instruction-goal "your moving sprite in game"))
                        (launcher-img sprites-and-edge-video)))


(define copy-paste-bad-sprite
  (activity-instructions "Copy and Paste the Code"
                         '()
                         (list (instruction-basic "Highlight the new code.")
                               (instruction-basic "Press CTRL+C to COPY.")
                               (instruction-basic "Go back to your project and make a new line BEFORE")
                               (instruction-basic (codify "(define (lost? g e))"))
                               (instruction-basic "Press CTRL+V to PASTE.")
                               (instruction-goal "your new code in your project"))
                         (launcher-img copy-paste-video)))



;(with-award 2 add-death-to-hero)
(define add-death-on-collide
  (activity-instructions "Add Death on Collide"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after (key-movement 3) and type: ")
                          (instruction-basic (codify "(on-collide \"bad chest\" die)"))
                          (instruction-goal "your hero dying on collision"))
                        (launcher-img collide-video)))




;(with-award 1 test-game) ;Add adjust speed values?
(define test-and-modify-game
  (activity-instructions "Modify and Test Game"
                         '()
                         (list
                          (instruction-basic "Adjust any random speed values.")
                          (instruction-basic "Add more bad sprites.")
                          (instruction-basic "Save your code.")
                          (instruction-basic "Run and test your game again.")
                          (instruction-goal "your new changes running in game."))
                        (p:scale-to-fit (local-bitmap "click_run.png") 250 250 #:mode 'preserve)))



                                                 


(define add-random-direction
  (activity-instructions "Add Random Directions"
                        '()
                         (list                        
                          (instruction-basic "Find (define (bad-chest-entity) ...)")
                          (instruction-basic "Make a new line after (respawn 'right) and type: ")
                          (instruction-basic (codify "(random-direction 170 190)"))
                          (instruction-goal "your sprites moving at random angles"))
                        (launcher-img random-directions-video)))

;Add a Moving Bad Sprite
(define day4-2dgame
  (list
   
   (with-award 0 open-file)
   (with-award 0 (load-new-code moving-sprite))
   (with-award 1 copy-paste-bad-sprite)
   (with-award 2 add-sprites-and-edge)
   (with-award 2 add-death-on-collide)
   (with-award 1 test-and-modify-game)
   (choose "any"
          (list
           (with-award 2 (draw-sprite "bad_sprite.png" "Bad Sprite"))
           (with-award 1 (replace-sheet "http://bit.ly/2FTnKD7"))
           (with-award 2 add-random-direction)))))



(define (quest4)
  (map shrink (make-picts "red" "Q4-" day4-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))


