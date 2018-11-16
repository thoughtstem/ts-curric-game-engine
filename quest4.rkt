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
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_1.rkt"
                      (add-to-start-game
                       '(on-collide "bad item" die))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put your code here.")))))


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

  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_1.rkt"
                      (add-to-start-game
                       `(bad-item-entity (posn 0 0)))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:vl-append
                           (p:text "Put your code here.")
                           (p:hb-append
                            (p:text "Experiment with the numbers in ")
                            (p:code (posn 0 0))))))))

(define-image-file bad-item-start-game
  images
  (bad-item-start-game-image))


(define-launcher-list bad-item 
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


(define s (settings (bg (local-bitmap "bg-arcade.png")) STAR STAR-BONUS STAR-BONUS))

(define (quest4)
  (map shrink (make-picts "red" "Q4-" day4-2dgame s)))

(module+ test
  (analyze-activities day4-2dgame s))
