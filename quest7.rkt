#lang racket

;High level goals:
#;(

   Title: The Big Bad

   Main goal: Add the enemy to the game
      *  Add enemy definition and call
      *  Update player-definition to die by dragon
      *  Update rotation style of dragon

   Stretch goals:
      *  Add rage mode
      *  Spawn fireballs (TBD)

   ======

   Quest-complete goals:  Comment out dragon and create your own Big Bad
      * Since game probably cannot handle two 'flying' entities, commenting the first out before
      adding another? -- Do so with less scaffolding.

      
   Mastery level 1:
    * Test your mastery:  Create a Big Bad in 5 minutes without hint cards.
    You may use an existing file.


   Mastery level 2:  I understand the functions I'm using, and their documented meanings,
   well enough to be able to write my own Big Bad.
       * Test your mastery:  Using only the documentation, write a Big Bad in a game that doesn't already have one.
      
   )

(provide quest7)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")

(define-racket-file enemy-code
  starter-files
  "tsgd_enemy.rkt")

(define-launcher-list enemy
  paste-the-code-below-into-your-file
  enemy-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)

(define (start-game-enemy-code)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-start-game
                       '(enemy-entity))))

  (code+hints main
              (list (first hint-targets) (hint "New code"))))

(define-launcher-function start-game:enemy
  start-game-enemy-code)



(define (dragon-death-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-player-entity-components
                       '(on-collide "dragon" die))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function dragon-death
  dragon-death-img)



;Error -- no enemy in quest6_complete. gets player instead
(define (dragon-rotate-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-enemy-entity-components
                       '(rotation-style 'left-right))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function dragon-rotate
  dragon-rotate-img)




;error -- same as above
(define (rage-mode-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-enemy-entity-components
                       '(after-time 200 (do-many (change-color-by 280)
                                                 (scale-sprite 1.25))))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function rage-mode
  rage-mode-img)




(define add-enemy-entity
  (activity-instructions "Add the Enemy Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code and add (enemy-entity).")
                               (instruction-basic "Test the game.")
                               (instruction-goal "your enemy in game."))
                         (launcher-img start-game:enemy)))


(define death-by-dragon
  (activity-instructions "Add Death by Dragon"
                         '()
                         (list
                          (instruction-basic "Add a component to your (player-entity) that will make your player die if touched by ''dragon''")
                          (instruction-basic "For a hint, look at the code that makes the ''bad item'' deadly or use the launch code.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your hero dying by the dragon"))
                        (launcher-img dragon-death)))


;error-- no enemy in quest 6_complete so it grabs player??
(define add-rotation-style
  (activity-instructions "Add Rotation Style"
                         '()
                         (list
                          (instruction-basic "Find the (enemy-entity) definition")
                          (instruction-basic "Use the launch code to see the new code to add.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the new rotation style, and explain how it's different than before"))
                        (launcher-img dragon-rotate))) ; PLACEHOLDER CODE



(define death-by-fireball
  (activity-instructions "Add Death by Fireball"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after the last (on-collide \"###\" die) and type:")
                          (instruction-image (text-with-image "   " death-by-fireball-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your hero dying by the fireball"))
                        (p:scale-to-fit (local-bitmap "tsgd_add_death_fireball.png") 250 250 #:mode 'preserve)))




(define rage-mode-code-img (p:scale (p:code (after-time 200 (do-many (change-color-by 260)
                                                                     (scale-sprite 1.25)))
                                            ) 4 ))
;same error as with add-rotation-style
(define after-time-rage
  (activity-instructions "Add a Rage Mode"
                         '()
                         (list                        
                          (instruction-basic "Find the (enemy-entity) definition")
                          (instruction-basic "Use the launch code to see the new code to add.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon's rage mode! What does it do?"))
                        (launcher-img rage-mode)))



(define add-fireball-code
  (activity-instructions "Add the Fireball Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (p:scale (codify "tsgd_fireball") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (lost? g e)")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 250 250 #:mode 'preserve)))

(define spawner-code-img (p:scale (p:code (spawner fireball-entity 20)) 4 ))

(define add-fireball-spawner
  (activity-instructions "Add a Fireball Spawner"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after the last (on edge ...) and type:")
                          (instruction-image (text-with-image "   " spawner-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon shooting fireballs."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_spawner.png") 250 250 #:mode 'preserve)))

;day 8 Wandering Ai and Projectiles
(define (day7-2dgame)
  (list
   (with-award 0 open-file)
   (with-award 1 (load-new-code enemy))  
   (with-award 1 add-enemy-entity)
   (with-award 1 death-by-dragon)
   (with-award 1 add-rotation-style)
   (choose "any"
          (list
           (with-award 2 after-time-rage)
           (with-award 2 add-fireball-code)
           (with-award 1 add-fireball-spawner)
           (with-award 1 death-by-fireball)
           ))
   ))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (SAMUS) (SAMUS-BONUS) (SAMUS-BONUS)))

(define (quest7)
  (map shrink (make-picts "red" "Q7-" day7-2dgame s)))

(module+ test
  (analyze-activities (day7-2dgame) s))


