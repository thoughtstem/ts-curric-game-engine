#lang racket

(provide quest10)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


;(with-award 1 load-copy-laser)
(define load-copy-laser
  (activity-instructions "Load/Copy Laser Code"
                         '()
                         (list (instruction-basic "TS Magic Load:")
                               (instruction-image (p:scale (codify "   tsgd_laser") 2) 640 60 "")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))



;(with-award 2 modify-laser)
(define modify-laser
  (activity-instructions "Modify the Laser Code"
                         '()
                         (list
                          (instruction-basic "Change \"airplane\" and \"dragon\" to match your game.")
                          (instruction-basic "Modify the position to adjust where the laser will spawn on the hero.")
                          (instruction-goal "your modified laser code."))
                        (p:scale-to-fit (local-bitmap "tsgd_laser_position.png") 300 320 #:mode 'preserve)))

;(with-award 1 add-shoot-button)
(define add-shoot-button
  (activity-instructions "Add a Shoot Button"
                          '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (p:scale (codify "(on-key 'space (spawn laser-entity))") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "The hero shooting lasers."))
                        (p:scale-to-fit (local-bitmap "tsgd_shoot_laser.png") 250 320 #:mode 'preserve)))

;(with-award 1 add-laser-collisions)

(define laser-collisions-code-img (p:scale (p:code (on-collide "laser" (respawn 'right))) 4 ))

(define add-laser-collisions
  (activity-instructions "Add Laser Collisions"
                          '()
                         (list                        
                          (instruction-basic "Find your moving sprite definition (bad-chest-entity, if you didn't rename it).")
                          (instruction-basic "Make a new line AFTER (on-start ...) and type:")
                          (instruction-image (text-with-image "" laser-collisions-code-img) 640 140 "")
                          (instruction-goal "the hero shooting down enemies."))
                        (p:scale-to-fit (local-bitmap "tsgd_laser_collision.png") 250 320 #:mode 'preserve)))

;(with-award 2 death-by-laser)
(define death-by-laser-code-img (p:scale (p:code (on-collide "laser" die)) 4 ))

(define death-by-laser
  (activity-instructions "Add Death by Laser"
                         '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (text-with-image "   " death-by-laser-code-img) 640 140 "")
                          (instruction-goal "your hero shooting down fireballs."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_death_laser.png") 250 320 #:mode 'preserve)))

;(with-award 1 load-copy-boss-health)
(define load-copy-boss-health
  (activity-instructions "Load/Copy Boss Health Code"
                         '()
                         (list (instruction-basic "TS Magic Load:")
                               (instruction-image (p:scale (codify "   tsgd_boss_health") 2) 640 60 "")
                               (instruction-basic "Copy/Paste the code BEFORE (define lost?).")
                               (instruction-goal "your new code in your project"))
                         (p:scale-to-fit (local-bitmap "tsgd_paste_code_here.png") 320 320 #:mode 'preserve)))

;(with-award 1 add-boss-health-entity)
(define add-boss-health-entity
  (activity-instructions "Add the Boss Health Entity"
                         '()
                         (list (instruction-basic "Find the (start-game) code, make a new line AFTER (score-entity) and type:")
                               (instruction-image (p:scale (codify "(boss-health-entity)") 2) 640 60 "")
                               (instruction-basic "Test the game.")
                               (instruction-goal "the boss health going down."))
                         (p:scale-to-fit (local-bitmap "tsgd_add_boss_health.png") 250 250 #:mode 'preserve)))

;(with-award 2 add-boss-death)
(define boss-death-code-img (p:scale (p:code (on-rule boss-health-is-zero? die)) 4 ))

(define add-boss-death
  (activity-instructions "Make the Boss Die"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Add the following component:")
                          (instruction-image (p:scale (codify "(on-rule boss-health-is-zero? die)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the boss dying after multiple laser hits."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_boss_death.png") 250 320 #:mode 'preserve)))


(define day10-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 load-copy-laser)     
   (with-award 2 modify-laser)
   (with-award 2 add-shoot-button)
   (with-award 2 add-laser-collisions)
   (with-award 1 death-by-laser)
   (choose "any"
          (list
           (with-award 1 load-copy-boss-health)
           (with-award 1 add-boss-health-entity)
           (with-award 2 add-boss-death)
           ))
   ))

(define (quest10)
  (map shrink (make-picts "red" "Q10-" day10-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))



