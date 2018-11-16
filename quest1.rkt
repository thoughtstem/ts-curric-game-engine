#lang racket

;High level goals:
#;(

   Title: Game Starters 

   Main goal: Open and run starter games, think critically about differences
      * Load and play starters
      * Fill out game review
      * Draw player

   Stretch goals:
      * Rename favorite starter 
      * Replace player with own

      
   ======

   Quest-complete goals:  
      * Suggestions (since today's concepts are not easily repeated)
         * Investigate starter code, find x many things you can change to alter gameplay
         * Look at documentation, learn more about functions being used
         * Discuss with other students a more in-depth perspective on games, what liked/disliked
         * If suspected/known that the student didn't go into much detail with
         Game Review or player design, do again.

   Mastery level 1:  TBD
    * Test your mastery: 


   Mastery level 2:  TBD
       * Test your mastery:  
      
   )

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
  (activity-instructions "Dr Racket Basics"
                         '()
                         (list (instruction-open "DrRacket")
                               (instruction-goal "the blank file in DrRacket."))

                         (launcher-img open-racket-video)))


(define (load-code demo-name)
  (activity-instructions "Load the Starter Code"
                         '()
                         (list (instruction-basic "Use the launch code to open the game.")
                               (instruction-basic "Run the game.")
                               (instruction-goal  "The demo game running in DrRacket"))
                         (launcher-img runner1-starter)))


(define (load-code-more endGame imgStr)
  (activity-instructions (++ "Test Games 2 Through " endGame)
                         '()
                         (list (instruction-basic "Use the launch code to open the next game.")
                               (instruction-basic "Run the game.")
                               (instruction-basic (~a "Launch all demos through " endGame "."))
                               (instruction-goal  (~a "demo " endGame " running.")))
                         (p:scale-to-fit (local-bitmap imgStr) 250 250 #:mode 'preserve)))




(define (google-form url)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Use the launch code to open the Game Review.")
                               (instruction-basic "Review the demo games!")
                               (instruction-goal "your Google Form submitted."))
                         (launcher-img runner-game-review)))

(define (draw-sprite-style image sprite)
  (activity-instructions (++ "Draw Your " (string-titlecase sprite))
                         '()
                         (list (instruction-open "Piskel")
                               (instruction-basic (++ "Paint a " (string-downcase sprite) " to go into your favorite game."))
                               (instruction-goal "your completed sprite."))
                         (p:scale (local-bitmap image) 2.0)))





(define-webpage save-as-video
  this-curriculum
  "http://bit.ly/2ImsLCl")


(define save-as
  (activity-instructions "Save the File"
                         '()
                         (list (instruction-basic "Return to the code with your favorite game style.")
                               (instruction-basic "Click 'File' and  'Save Definitions As'")
                               (instruction-basic "Rename the file, make sure to keep the '.rkt' at the end!")
                               (instruction-goal  "your renamed and saved file."))
                         (launcher-img save-as-video)))


(define fix-animation
  (activity-instructions "Fix your animation"
                         '()
                         (list (instruction-basic "If you run your code now, it will look weird (Try it!)")
                               (instruction-basic "Go back to your code and change the number of columns.")
                               (instruction-basic "Run your game again.")
                               (instruction-goal  "your player sprite in your game."))
                         (launcher-img change-columns)))



(define day1-2dgame
  (list
   (with-award 1 (how-to-use-launcher-card))
   ;(with-award 0 open-racket-only)
   (with-award 2 (load-code "tsgd_runner_1"))
   (with-award 1 (load-code-more "4" "load_runner.png"))
   (with-award 3 (google-form "http://bit.ly/2Hkkuxr"))
   (with-award 2 (draw-sprite-style "betty_single.png" "Character"))
   (with-award 0 export-from-piskel)
   (choose "any"
           (list
            (with-award 1 save-as)
            (with-award 1 (replace-sheet "Player" replace-player-sprite))
            (with-award 1 fix-animation)
            ))))

(define s (settings (bg (local-bitmap "bg-arcade.png")) PACMAN PACMAN-BONUS PACMAN-BONUS))

(define (quest1)
  (map shrink (make-picts "red" "Q1-" day1-2dgame s)))


(module+ test
  (analyze-activities day1-2dgame s))
