#lang racket

;High level goals:
#;(

   Title: Score-related GUIs

   Main goal: Add a score GUI
      * Add a score keeping entity GUI

   Stretch goals:
      * Add game over screen GUI
      * Customize game over screen GUI

      
   ======

   Quest-complete goals:  Create a score keeping entity and game over screen, using less scaffolding.
      * Suggestions (since it doesn't make sense to add MORE score-related GUIs)
         * Ask student to: Remove the score-related GUIs from the game without breaking anything else
         * Add them back in with fewer (no?) quest cards

   Mastery level 1:  I have added a score keeping and game over GUIs to a game enough times that I can
       do it without the quest cards.
    * Test your mastery:  Do it in under 5 minutes without hint cards.
    You may use an existing file as long as it does not have a score keeping entity already.


   Mastery level 2:  I understand the functions I'm using, and their documented meanings,
   well enough to be able to add and customize a new score keeping entity.
       * Test your mastery:  Using only the documentation, add score-related GUIs
       to a game that doesn't have them.
      
   )



(provide quest5)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")

(define-racket-file keep-score-code
  starter-files
  "tsgd_keep_score.rkt")

(define-launcher-list keep-score
  paste-the-code-below-into-your-file
  keep-score-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)

(define-racket-file game-over-code
  starter-files
  "tsgd_game_over_gui.rkt")

(define-launcher-list game-over
  paste-the-code-below-into-your-file
  game-over-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)



(define (start-game-score-code)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest4_complete.rkt"
                      (add-to-start-game
                       '(score-entity))))

  (code+hints main
              (list (first hint-targets) (hint "New code"))))

(define-image-file start-game:score
  images
  (start-game-score-code))


(define (start-game:game-over-code)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest4_complete.rkt"
                      (add-to-start-game
                       '(game-over-screen))))

  (code+hints main
              (list (first hint-targets) (hint "New code"))))

(define-image-file start-game:game-over
  images
  (start-game:game-over-code))

                                                 

(define modify-score
  (activity-instructions "Add Score to start-game"
                         '()
                         (list
                          (instruction-basic "Find the (start-game) code and add (score-entity).")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your score changing in game."))
                        (launcher-img start-game:score)))



(define game-over-screen-start-game
  (activity-instructions "Add to start-game"
                         '()
                         (list
                          (instruction-basic "Add (game-over-screen) to (start-game ...)")
                          (instruction-basic "Use the launch code to see how")
                          (instruction-basic "Test your game.")
                          (instruction-goal "your game over screen in your game"))
                         (launcher-img start-game:game-over)))


(define customize-game-over-message
  (activity-instructions "Edit the game over message"
                         '()
                         (list
                          (instruction-basic "Change the game over message.")
                          (instruction-basic "HINT: Look inside the (game-over-screen) definition.")
                          (instruction-goal "your customized message in your game"))
                         (p:scale
                          (p:bitmap (build-path images "game-over-screen-example.png"))
                          0.25)))




(define customize-game-over-message-more
  (activity-instructions "Edit the game over message"
                         '()
                         (list
                          (instruction-basic "Design your own game over image in Piskel and export")
                          (instruction-basic "Replace the game over image in your code.")
                          (instruction-goal "your updated game over screen in your game"))
                         (p:scale (logo-for "piskel") 4)
                         ))

;Add a Score Entity
(define day5-2dgame
  (list
   (with-award 0 open-file)
   (with-award 0 (load-new-code keep-score))      
   (with-award 2 modify-score)

   (choose "any"
           (list
            (with-award 1 (load-new-code game-over))
            (with-award 1 game-over-screen-start-game)
            (with-award 1 customize-game-over-message)
            
            (with-award 1 customize-game-over-message-more)))))

(define s (settings (bg (local-bitmap "bg-arcade.png")) R-MUSH R-MUSH-BONUS R-MUSH-BONUS))

(define (quest5)
  (map shrink (make-picts "red" "Q5-" day5-2dgame s)))


(module+ test
  (analyze-activities day5-2dgame s))
