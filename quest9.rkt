#lang racket

(provide quest9)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")



(define load-copy-wall-and-lava
  (activity-instructions "Load/Copy Wall & Lava Code"
                         '()
                         (list (instruction-basic "TS Magic Load: 'tsgd_wall_and_lava'.")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))


(define wall-lava-code-img (p:scale (p:code (wall-entity (posn 450 250))
                                            (wall-entity (posn 150 300))
                                            (lava-entity (posn 300 150))) 4 ))

(define add-wall-and-lava
  (activity-instructions "Add Walls & Lava"
                         '()
                         (list (instruction-basic "Find the (start-game) code, make a new line AFTER (enemy-entity), and type:")
                               (instruction-image (text-with-image "   " wall-lava-code-img) 640 140 "")
                               (instruction-basic "Test the game.")
                               (instruction-goal "your walls and lava in game."))
                         (p:scale-to-fit (local-bitmap "tsgd_add_walls_and_lava.png") 300 320 #:mode 'preserve)))




;(with-award 2 add-physical-colliders)
(define add-physical-colliders
  (activity-instructions "Add Physical Colliders"
                         '()
                         (list (instruction-basic "Add a (physical-collider) component to BOTH the hero-entity and the enemy-entity.")
                               (instruction-basic "Type it anywhere BEFORE (on-collide) or (on-edge).")
                               (instruction-goal "the hero and the enemy colliding with walls."))
                         (p:scale-to-fit (local-bitmap "tsgd_add_colliders.png") 320 320 #:mode 'preserve)))


(define death-by-lava-code-img (p:scale (p:code (on-collide "lava" die)) 4 ))

(define death-by-lava
  (activity-instructions "Add Death by Lava"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (text-with-image "   " death-by-fireball-code-img) 640 140 "")
                          (instruction-basic "You can comment out other lines with ';' to make testing easier. If you have rage mode on the enemy, disable that too.")
                          (instruction-goal "your hero dying by the lava."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_death_lava.png") 250 320 #:mode 'preserve)))

;(with-award 2 draw-walls-and-lava)
(define replace-the-walls-and-lava
  (activity-instructions "Draw Your Own Walls & Lava"
                         '()
                         (list (instruction-basic "Draw new \"wall\" and \"lava\" sprites and save it.")
                               (instruction-basic "Find (define (wall-entity)) and replace (rectangle 80 40 \"solid\" \"white\") with your image.")
                               (instruction-basic "Repeat for the lava-entity.")
                               (instruction-goal "your new walls and lava in game."))
                         (p:scale-to-fit (local-bitmap "tsgd_wall_and_lava.png") 320 320 #:mode 'preserve)))



;        (with-award 2 add-bounce-to-fireball)
(define add-bounce-to-fireball
  (activity-instructions "Make the Fireball Bounce"
                          '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Make a new line AFTER (rotation-style ...) and type:")
                          (instruction-image (p:scale (codify "(on-collide \"wall\" (bounce))") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the fireballs bouncing off walls."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_bounce.png") 300 320 #:mode 'preserve)))
  
;        (with-award 1 add-after-time-die)
(define add-after-time-die
  (activity-instructions "After Time - Remove Bad Guys"
                          '()
                         (list                        
                          (instruction-basic "Find your moving sprite definition (bad-chest-entity, if you didn't rename it).")
                          (instruction-basic "Make a new line AFTER (every-tick ...) and type:")
                          (instruction-image (p:scale (codify "(after-time 500 die)") 2) 640 60 "")
                          (instruction-goal "the wave of bad guys ending."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_after_time_die.png") 300 320 #:mode 'preserve)))



;        (with-award 1 add-after-time-spawn)
(define add-after-time-spawn
  (activity-instructions "After Time - Spawn Boss"
                          '()
                         (list                        
                          (instruction-basic "Remove (enemy-entity) from (start-game ...).")
                          (instruction-basic "Change the enemy-entity's position to (posn 0 0).")
                          (instruction-basic "Add the following component to lava-entity.")
                          (instruction-image (p:scale (codify "(after-time 600 (spawn (enemy-entity)))") 2) 640 60 "")
                          (instruction-goal "the boss spawning after 600."))
                        (p:scale-to-fit (local-bitmap "tsgd_spawn_boss.png") 250 320 #:mode 'preserve)))


;day 10 Walls and Lava
(define day9-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 load-copy-wall-and-lava)     
   (with-award 2 add-wall-and-lava)
   (with-award 1 add-physical-colliders)
   (with-award 1 death-by-lava)
   (with-award 2 replace-the-walls-and-lava)
   (choose "any"
          (list
           (with-award 1 add-bounce-to-fireball)
           (with-award 1 add-after-time-die)
           (with-award 2 add-after-time-spawn)
           ))
   ))


(define (quest9)
  (map shrink (make-picts "red" "Q9-" day9-2dgame (settings (bg (local-bitmap "bg-arcade.png")) (MARIO) (MARIO-BONUS) (MARIO-BONUS)))))



