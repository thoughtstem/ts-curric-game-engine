#lang racket

(provide quest8)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")




;(with-award 2 add-follow-code-enemy)
(define add-follow-code-enemy
  (activity-instructions "Make the Dragon Follow You"
                         '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Disable (do-every ...) by typing a ';' just before it.")
                          (instruction-basic "Make a new line and type:")
                          (instruction-image (p:scale (codify "(follow \"hero\")") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon following you."))
                        (p:scale-to-fit (local-bitmap "tsgd_dragon_follow.png") 250 250 #:mode 'preserve)))
             

           

;(with-award 1 change-rotation-style)
(define change-rotation-style
  (activity-instructions "Make the Dragon Face You"
                          '()
                         (list                        
                          (instruction-basic "Find (define (enemy-entity) ...)")
                          (instruction-basic "Change (rotation-style 'left-right) to: ")
                          (instruction-image (p:scale (codify "(rotation-style 'face-direction)") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the dragon facing you."))
                        (p:scale-to-fit (local-bitmap "tsgd_face_direction.png") 250 250 #:mode 'preserve)))




;(with-award 1 add-follow-code-collectible)
(define collectible-follow-code-img (p:scale (p:code (direction 0)
                                                 (speed 2)
                                                 (every-tick (move))
                                                 (follow "hero")) 4 ))

(define add-follow-code-collectible
  (activity-instructions "Make the Collectible Follow"
                         '()
                         (list                        
                          (instruction-basic "Find the collectible definition.")
                          (instruction-basic "Add the following components BEFORE (on-collide ...):")
                          (instruction-image (text-with-image "   " collectible-follow-code-img) 640 140 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the collectible following you."))
                        (p:scale-to-fit (local-bitmap "tsgd_collectible_follow.png") 250 250 #:mode 'preserve)))




;(with-award 1 replace-the-dragon)
(define replace-the-dragon
  (activity-instructions "Draw a New Enemy"
                         '()
                         (list (instruction-basic "Draw a new enemy sprite and replace the dragon.")
                               (instruction-basic "Change the ROWS and COLUMNS to match your new sprite.")
                               (instruction-goal "your new enemy sprite in game."))
                         (p:scale-to-fit (local-bitmap "tsgd_replace_dragon.png") 250 250 #:mode 'preserve)))




;(with-award 3 (google-form "https://bit.ly/2rFTOkv"))
(define (review-your-game url)
  (activity-instructions "Open the Game Review"
                         '()
                         (list (instruction-basic "Scan the card to open the Game Review.")
                               (instruction-basic "Answer the questions about your game.")
                               (instruction-goal "your Google Form submitted."))
                         (code-qr url)))


;(choose "any"
; (list
; (with-award 2 replace-the-fireball)
(define replace-the-fireball
  (activity-instructions "Draw a Fireball Sprite"
                         '()
                         (list (instruction-basic "Draw a new fireball sprite and export it to SAVE_MY_WORK.")
                               (instruction-basic "Find (define (rainbow-fireball)) and replace (circle 10 \"solid\" \"white\") with your image.")
                               (instruction-goal "your new fireball in game."))
                         (p:scale-to-fit (local-bitmap "tsgd_fireball.png") 250 250 #:mode 'preserve)))

; (with-award 1 add-point-to-fireball)
(define add-point-to-fireball
  (activity-instructions "Make the Fireball Point To You"
                          '()
                         (list                        
                          (instruction-basic "Find (define (fireball-entity) ...)")
                          (instruction-basic "Inside (on-start),change (random-direction 0 360) to: ")
                          (instruction-image (p:scale (codify "(point-to \"hero\")") 2) 640 60 "")
                          (instruction-basic "Test the game.")
                          (instruction-goal "the fireballs shooting at you."))
                        (p:scale-to-fit (local-bitmap "tsgd_fireball.png") 250 250 #:mode 'preserve)))



;  (with-award 1 rotation-style-collectible)
(define more-rotation-style
  (activity-instructions "More Rotation Style"
                         '()
                         (list                        
                          (instruction-basic "Add (rotation-style ###) to the collectible and/or the fireball.")
                          (instruction-basic "Use either 'left-right mode or 'face-direction mode.")
                          (instruction-basic "Earn a 1$ for each rotation-style you add.")
                          (instruction-goal "more entities with rotation."))
                        (p:scale-to-fit (local-bitmap "tsgd_add_rotation_fireball.png") 250 250 #:mode 'preserve)))



;day 9 Follow Ai
(define day8-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 add-follow-code-enemy)     
   (with-award 1 change-rotation-style)
   (with-award 2 add-follow-code-collectible)
   (with-award 1 replace-the-dragon)
   (with-award 2 (review-your-game "https://bit.ly/2rFTOkv"))
   (choose "any"
          (list
           (with-award 2 replace-the-fireball)
           (with-award 1 add-point-to-fireball)
           (with-award 1 more-rotation-style)
           ))
   ))


(define (quest8)
  (map shrink (make-picts "red" "Q8-" day8-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))



