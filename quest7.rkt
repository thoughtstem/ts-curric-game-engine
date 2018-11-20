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

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))

(require "./common.rkt")

;=== Code to load ===

(define-racket-file enemy-code
  starter-files
  "tsgd_enemy.rkt")

(define-launcher-list enemy
  paste-the-code-below-into-your-file
  enemy-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)

(define-racket-file fireball-code
  starter-files
  "tsgd_fireball.rkt")

(define-launcher-list fireball
  paste-the-code-below-into-your-file
  fireball-code
  paste-the-code-above-into-your-file
  between-definitions-explanation)

;=== Code hints to load ===

(define (start-game-enemy-code)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-start-game
                       '(enemy-entity))))

  (code+hints main
              (list (first hint-targets) (hint "New code"))))

(define-launcher-function start-game:enemy
  start-game-enemy-code)



(define (die-by-dragon-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-player-entity-components
                       '(on-collide "dragon" die))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function die-by-dragon
  die-by-dragon-img)




(define (die-by-fireball-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-player-entity-components
                       '(on-collide "fireball" die))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function die-by-fireball
  die-by-fireball-img)



(define (dragon-rotate-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_enemy.rkt"
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
    (try-smw-and-then "tsgd_enemy.rkt"
                      (add-to-enemy-entity-components
                       '(after-time 200 (do-many (change-color-by 280)
                                                 (scale-sprite 1.25))))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function rage-mode
  rage-mode-img)



;error -- same as above
(define (fireball-spawner-img)
 
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest6_complete.rkt"
                      (add-to-enemy-entity-components
                       '(do-every 90 (spawn fireball-entity)))))

  (code+hints main
              (list (first hint-targets)
                    (hint (p:text "Put this code here.")))))


(define-launcher-function fireball-spawner
  fireball-spawner-img)



;=== Cards ===

(define add-enemy-entity
  (activity-instructions "Add the Enemy Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code and add (enemy-entity).")
                               (instruction-basic "Test the game.")
                               (instruction-goal "your enemy in game."))
                         (launcher-img start-game:enemy)))


(define death-by-dragon
  (activity-instructions "Deadly Dragon"
                         '()
                         (list
                          (instruction-basic "Add a component to your (player-entity) that will make your player die if touched by ''dragon''")
                          (instruction-basic "For a hint, look at the code that makes the ''bad item'' deadly or use the launch code.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "your player dying by dragon!"))
                        (launcher-img die-by-dragon)))


;error-- no enemy in quest 6_complete so it grabs player??
(define add-rotation-style
  (activity-instructions "Add Rotation Style"
                         '()
                         (list
                          (instruction-basic "Find the (enemy-entity) definition")
                          (instruction-basic "Use the launch code to see the new code to add.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the new rotation style, and explain how it's different than before"))
                        (launcher-img dragon-rotate)))



(define death-by-fireball
  (activity-instructions "Add Death by Fireball"
                         '()
                         (list                        
                          (instruction-basic "Can you add the code to make your player die by fireball without looking at the launch code for hints?")
                          (instruction-basic "Once you got it, test the game.")
                          (instruction-goal "your player dying by fireball"))
                        (launcher-img die-by-fireball)))


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

;same error as with add-rotation-style
(define add-fireball-spawner
  (activity-instructions "Make the Fireball Appear!"
                         '()
                         (list                        
                          (instruction-basic "Add a component to the enemy-entity so it will spawn a fireball-entity every 90 ticks.")
                          (instruction-basic "Use the launch code to see what this code looks like.")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon shooting fireballs!!"))
                        (launcher-img fireball-spawner)))


(define (day7-2dgame)
  (list
   (with-award 0 open-file)
   (with-award 1 (load-new-code enemy))  
   (with-award 1 add-enemy-entity)
   (with-award 1 death-by-dragon)
   (choose "any"
          (list
           (with-award 1 add-rotation-style)
           (with-award 3 after-time-rage)
           (with-award 1 (load-new-code fireball))
           (with-award 1 add-fireball-spawner)
           (with-award 1 death-by-fireball)
           ))
   ))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (SAMUS) (SAMUS-BONUS) (SAMUS-BONUS)))

(define (quest7)
  (map shrink (make-picts "red" "Q7-" day7-2dgame s)))

(module+ test
  #;(analyze-activities (day7-2dgame) s)

  (dragon-rotate-img))


