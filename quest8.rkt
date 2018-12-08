#lang racket

;High level goals:
#;(

   Title: Levels

   Main goal: Add level 2 and 3 to the game
      *  Add time-manager entity
      *  Update Start Game
      *  Update score-entity
      *  Add level entities

   Stretch goals:
      *  Change level messages?
      *  Change level times?
      *  Add additional level?

   ======

   Quest-complete goals:  Create additional levels
      * Make creative choices about future levels, add them and all relevant code to the game with less scaffolding.
      
   Mastery level 1:
    * Test your mastery:  Create an additional level in 5 minutes without hint cards.
    You may use an existing file with exisiting levels.


   Mastery level 2:  I understand the functions I'm using, and their documented meanings, well enough to be able
   to create levels in a game without levels.
       * Test your mastery:  Using only the documentation, add levels to a game that doesn't already have them.
      
   )


(provide quest8)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


;========== Code to load ==========


(define-racket-file game-manager-code
  starter-files
  "tsgd_game_manager.rkt")

(define-launcher-list game-manager
  paste-the-code-below-into-your-file
  game-manager-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)



(define-racket-file level2-code
  starter-files
  "tsgd_level2.rkt")

(define-launcher-list level2
  paste-the-code-below-into-your-file
  level2-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)

;========= Imgs to load =============

;old code+hints because not a way to add multiple instructions
;with new way at time of creation
(define (start-game-levels-code)
 
  (define add-me
    (p:frame #:color "red" (p:code (game-manager-entity))))

  (define delete-me
    (x-out (p:code (enemy-entity))))

  (define all-code
    (p:code (start-game (instructions-entity)
                        (item-entity item-sprite (posn 200 200))
                        (bad-item-entity (posn 5 5))
                        (score-entity)
                        (game-over-screen)
                        #,add-me
                        #,delete-me
                        (player-entity)
                        (ground-entity (posn (/ WIDTH 2) (- (/ HEIGHT 2) HEIGHT)))
                        (ground-entity (posn (/ WIDTH 2) (/ HEIGHT 2)))
                        bg-entity))) 

  (code+hints #:settings hints-on-left
              all-code
              (list add-me (hint "Add this call"))
              (list delete-me (hint "Delete this call"))))

(define-launcher-function start-game:levels
  start-game-levels-code)




(define (add-level2-code)
  
   (define prev-code
    (p:frame #:color "red" (p:code (spawn enemy-entity #:relative? #f))))
  
  (define target-full
    (p:frame #:color "red" (p:code (do-many #,prev-code
                                            (spawn level2-entity #:relative? #f)))))
  (define all-code
    (p:code (define (game-manager-entity)
              (time-manager-entity #:components
                                   (on-rule player-dead? (stop-game-counter))
                                   (on-rule (reached-game-count? 200) #,target-full)
                                   ))))

  
  (define almost-finished-code
    (code+hints all-code
                (list prev-code (hint "Wrap this existing"
                                      "code..."))))


  (code+hints #:settings hints-on-bottom
              almost-finished-code
              (list target-full (hint "...With this new code."
                                      "Mind the parentheses!!"))
              ))

(define-launcher-function add-level2
  add-level2-code)



(define (level-bonus-code)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest7_complete.rkt"
                      (add-to-score-entity-components
                       (p:code (on-rule (reached-game-count? 200) (do-many (change-counter-by 1000)
                                                                           (draw-counter "Score: " 32 "yellow")))))))
  (code+hints main
              (list (first hint-targets) (hint "New code"))))

(define-launcher-function level-bonus
  level-bonus-code)




(define (copy-level-entity-code)
  
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_level2.rkt"
                      (find-defined-constant  level-entity-definition)))

  (code+hints (p:frame #:color "red" main)
              (list main (hint "Copy this and paste"
                               "it right below."))))

(define-launcher-function copy-level-entity
  copy-level-entity-code)



(define (add-level3-code)
  
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_game_manager.rkt"
                      (add-to-game-manager-components
                       '(on-rule (reached-game-count? 400) (spawn #:relative? #f level3-entity)))))

  (code+hints main
              (list (first hint-targets) (hint "New Code"))))

(define-launcher-function add-level3
  add-level3-code)

;============ Cards =================

(define edit-start-game-levels
  (activity-instructions "Edit Start-Game"
                         '()
                         (list                        
                          (instruction-basic "Add a (game-manager-entity) function call to (start-game).")
                          (instruction-basic "Delete the (enemy-entity) function call.")
                          (instruction-basic "Test your game.")
                          (instruction-goal "enemy-entity only appearing after 200 ticks in your game"))
                        (launcher-img start-game:levels)))

(define edit-game-manager
  (activity-instructions "Add Level 2 to Game"
                         '()
                         (list                        
                          (instruction-basic "Edit the game-manager-entity so the level 2 dialog will appear with the enemy-entity.")
                          (instruction-basic "Use the launch code to see how.")
                          (instruction-basic "Test your game.")
                          (instruction-goal "the Level 2 message in game."))
                        (launcher-img add-level2)))

(define level-point-bonus
  (activity-instructions "Add a Level Bonus"
                         '()
                         (list                        
                          (instruction-basic "The player should get a point bonus when they reach a new level, right?")
                          (instruction-basic "Use the launch code to see how to code this.")
                          (instruction-basic "Then test your game.")
                          (instruction-goal "The score increase in game!"))
                        (launcher-img level-bonus)))

(define add-additional-level
  (activity-instructions "Level 3!"
                         '()
                         (list                        
                          (instruction-basic "Copy and paste the (level2-entity) definition.")
                          (instruction-basic "Edit the pasted definition to be a (level3-entity)!")
                          (instruction-basic "HINT: you will have to edit at least 3 things.")
                          (instruction-goal "your new (level3-entity) code."))
                        (launcher-img copy-level-entity)))

(define edit-game-manager-level-3
  (activity-instructions "Add Level 3 to Game"
                         '()
                         (list                        
                          (instruction-basic "Edit the game-manager-entity so the level 3 dialog will appear after 400 ticks.")
                          (instruction-basic "Use the launch code to see how.")
                          (instruction-basic "What happens when you reach level 3??")
                          (instruction-goal "the level 3 message in game. "))
                        (launcher-img add-level3)))

(define customize-levels
  (activity-instructions "Customize your Levels"
                         '()
                         (list                        
                          (instruction-basic "Change the titles on your level entities.")
                          (instruction-basic "Alter the number of ticks for each level.")
                          (instruction-basic "Keep in mind that you may have to update the number in a few locations to keep things in sync!")
                          (instruction-goal "Your customizations in game."))
                        (p:scale (local-bitmap "level-message-change.png") .6)))




(define (day8-2dgame)
  (list
   (with-award 0 open-file)
   (with-award 0 (load-new-code game-manager))
   (with-award 1 edit-start-game-levels)
   (with-award 1 (load-new-code level2))
   (with-award 2 edit-game-manager)
   (choose "any"
          (list
           (with-award 2 level-point-bonus)
           (with-award 2 add-additional-level)
           (with-award 1 edit-game-manager-level-3)
           (with-award 1 customize-levels)
           ))
   ))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (PIKACHU) (PIKACHU-BONUS) (PIKACHU-BONUS)))

(define (quest8)
  (map shrink (make-picts "red" "Q8-" (day8-2dgame) s)))

(module+ test
  (analyze-activities (day8-2dgame) s))

