#lang racket

(provide quest1)

(require ts-racket)
(require ts-curric-common)


(require (prefix-in p: pict/code))
(require (prefix-in p: pict))

(require "./common.rkt")

(define-webpage open-racket-video
  this-curriculum
  "http://bit.ly/2HV5yHn")



(define-webpage runner-game-review
  this-curriculum
  "http://bit.ly/2OoFkiq")


(define-webpage reload-video
  this-curriculum
  "http://bit.ly/2Q2yKAh")


(define open-racket-only
  (activity-instructions "DrRacket Basics"
                         '()
                         (list (instruction-open "DrRacket")
                               (instruction-goal "the blank file in DrRacket."))

                         (launcher-img open-racket-video)))


(define (load-code demo-name)
  (activity-instructions "Load the Starter Code"
                         '()
                         (list (instruction-basic "Click on TS Magic Loader. In the text field, type:")
                               (instruction-basic (codify demo-name))
                               (instruction-basic "Click the Load button")
                               (instruction-basic "Run the code.")
                               (instruction-goal  "The demo code running in DrRacket"))
                         (launcher-img quest1-starter)))


(define (load-code-more endGame imgStr)
  (activity-instructions (++ "Test Games 2 Through " endGame)
                         '()
                         (list (instruction-basic "Click the TS Magic Loader again. In the text field, type: ")
                               (instruction-basic (codify "tsgd_runner_2"))
                               (instruction-basic "Run the code.")
                               (instruction-basic (++ "Continue until demo " endGame "."))
                               (instruction-goal  "your game window running."))
                         (p:scale-to-fit (local-bitmap imgStr) 250 250 #:mode 'preserve)))




(define (google-form url)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Scan the card to open the Game Review.")
                               (instruction-basic "Answer the questions about the demo games.")
                               (instruction-goal "your Google Form submitted."))
                         (launcher-img runner-game-review)))

(define (draw-sprite-style image sprite)
  (activity-instructions (++ "Draw Your " (string-titlecase sprite))
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic (++ "Paint a " (string-downcase sprite) " that matches your favorite style."))
                               (instruction-goal "your completed texture."))
                         (p:scale (local-bitmap image) 2.0)))







(define reload-fave
  (activity-instructions "Reload Your Favorite Style"
                         '()
                         (list (instruction-basic "Reload the game with your favorite style.")
                               (instruction-goal  "your favorite game."))
                         (launcher-img reload-video)))




#;(define (save-as-video)
  (send-url "http://bit.ly/2ImsLCl"))

(define save-as
  (activity-instructions "Save the File"
                         '()
                         (list (instruction-basic "Click 'File' and  'Save Definitions As'")
                               (instruction-basic "Rename the file, make sure to keep the '.rkt' at the end!")
                               (instruction-goal  "your renamed and saved file."))
                         (launcher-img runner-game-review)))




(define day1-2dgame
  (list
   (with-award 0 open-racket-only)
   (with-award 2 (load-code "tsgd_runner_1"))
   (with-award 1 (load-code-more "4" "load_runner.png"))
   (with-award 3 (google-form "http://bit.ly/2Hkkuxr"))
   (with-award 2 (draw-sprite-style "betty_single.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list
            (with-award 0 reload-fave)
            (with-award 1 save-as)
            (with-award 1 (replace-sheet "http://bit.ly/2FTnKD7"))))))

(define (quest1)
  (map shrink (make-picts "red" "Q1-" day1-2dgame (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS))))
