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


;=== Code to load ===


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

;==== Imgs to load ===

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

  (code+hints all-code
              (list delete-me (hint "Delete this call"))
              (list add-me (hint "Add this call"))
              ))

(define-launcher-function start-game:levels
  start-game-levels-code)




;=== Cards =====

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
  (activity-instructions "Edit Start-Game"
                         '()
                         (list                        
                          (instruction-basic "Add a (game-manager-entity) function call to (start-game).")
                          (instruction-basic "Delete the (enemy-entity) function call.")
                          (instruction-basic "Test your game.")
                          (instruction-goal "enemy-entity only appearing after 200 ticks in your game"))
                        (launcher-img start-game:levels)))



(define (day8-2dgame)
  (list
   (with-award 0 open-file)
   ;load game manager entity -- SHOW new code in file
   (with-award 1 (load-new-code game-manager))
   ;edit start game (add GME get rid of enemy-entity) -- SHOW dragon appearing after x ticks
   (with-award 1 edit-start-game-levels)
   ;load level 2 entity -- SHOW new code in file
   (with-award 1 (load-new-code level2))
   ;edit GME to spawn level 2 entity -- SHOW in game
   
   (choose "any"
          (list
           ;create level 3 entity -- SHOW code
           ;add to GME -- SHOW in game
           ;edit level messages -- SHOW in game
           ;edit level length -- SHOW in code
           ))
   ))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (PIKACHU) (PIKACHU-BONUS) (PIKACHU-BONUS)))

(define (quest8)
  (map shrink (make-picts "red" "Q8-" day8-2dgame s)))

(module+ test
  (analyze-activities (day8-2dgame) s))

