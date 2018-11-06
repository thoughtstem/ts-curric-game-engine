#lang racket

(provide quest7)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


(define add-enemy-code
  (activity-instructions "Add the Enemy Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (p:scale (codify "tsgd_enemy") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (lost? g e)")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 250 250 #:mode 'preserve)))

(define add-enemy-entity
  (activity-instructions "Add the Enemy Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code and make a new line AFTER (score-entity).")
                               (instruction-basic (text-with-image "Type: " (p:scale (codify "(enemy-entity)") 1.5)))
                               (instruction-basic "Test the game.")
                               (instruction-goal "your enemy in game."))
                         (p:scale-to-fit (local-bitmap "tsgd_add_enemy_entity.png") 250 250 #:mode 'preserve)))


;   (with-award 2 death-by-dragon)
(define death-by-dragon
  (activity-instructions "Add Death by Dragon"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Make a new line after (on-collide \"###\" die).")
                          (instruction-basic (text-with-image "Type: " (codify "(on-collide \"dragon\" die)")))
                          (instruction-basic "Test the game.")
                          (instruction-goal "your hero dying by the dragon"))
                        (p:scale-to-fit (local-bitmap "tsgd_add_death.png") 250 250 #:mode 'preserve)))

;   (with-award 1 add-rotation-style)
(define add-rotation-style
  (activity-instructions "Add Rotation Style"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after (every-tick (move)) and type:")
                          (instruction-image (p:scale (codify "(rotation-style 'left-right)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon pointing left and right"))
                        (p:scale-to-fit (local-bitmap "tsgd_add_rotation_style.png") 250 250 #:mode 'preserve)))



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

(define after-time-rage
  (activity-instructions "Add a Rage Mode"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Make a new line after (rotation-style ...) and type:")
                          (instruction-image (text-with-image "   " rage-mode-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon changing size and color."))
                        (p:scale-to-fit (local-bitmap "tsgd_rage_mode.png") 250 250 #:mode 'preserve)))



;   (with-award 2 (load-copy "tsgd_fireball"))
(define add-fireball-code
  (activity-instructions "Add the Fireball Code"
                         '()
                         (list (instruction-basic "Open TS Magic Loader.")
                               (instruction-basic (text-with-image "Load: " (p:scale (codify "tsgd_fireball") 1.5)))
                               (instruction-basic "Copy/Paste the Code BEFORE (define (lost? g e)")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 250 250 #:mode 'preserve)))

;   (with-award 1 add-spawner)
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
(define day7-2dgame
  (list
   (with-award 0 open-file)
   (with-award 2 add-enemy-code)     
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

(define (quest7)
  (map shrink (make-picts "red" "Q7-" day7-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))



