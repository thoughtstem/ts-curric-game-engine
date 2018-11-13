#lang racket

(provide quest6)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")




(define add-edges-code-img (p:scale (p:code (right-edge)
                                            (top-edge)
                                            (bottom-edge))
                                    4 ))
(define-webpage more-edges-video
  this-curriculum
  "https://bit.ly/2JCHI38")

(define-webpage stop-left-video
  this-curriculum
  "https://bit.ly/2KoUseY")

(define-webpage stop-edges-video
  this-curriculum
  "https://bit.ly/2rajRkC")

(define-webpage wrap-around-video
  this-curriculum
  "https://bit.ly/2KstkMa")

(define-webpage stop-improved-video
  this-curriculum
  "https://bit.ly/2ra1U5y")

(define-webpage wrap-improved-video
  this-curriculum
  "https://bit.ly/2r9nfvh")

(define-webpage random-bg-video
  this-curriculum
  "https://bit.ly/2I6q7nf")

(define-webpage random-player-video
  this-curriculum
  "https://bit.ly/2HElPE3")

(define (wrap-around-or-stop-on-edge-list)

  (define BREAK (p:ghost (p:rectangle 10 10)))

  (p:vl-append
   (inset-frame
    (p:vl-append
     (p:text "Option 1")
     (p:code (stop-on-edge 'top 'bottom 'left 'right))))
   BREAK
   (inset-frame
    (p:vl-append
     (p:text "Option 2")
     (p:code (wrap-around 'top-bottom 'left-right))))
   BREAK
   (inset-frame
    (p:vl-append
     (p:text "Option 3")
     (p:code (stop-on-edge 'top 'bottom)
             (wrap-around 'left-right))))
   BREAK
   (inset-frame
    (p:vl-append
     (p:text "There's one more option;")
     (p:text "can you figure it out??")))))

(define-image-file wrap-or-stop
  images
  (wrap-around-or-stop-on-edge-list))


(define (add-wrap-or-stop-code)
  (define target
    (p:frame #:color "red"
             (p:code (wrap-around 'top-bottom 'left-right))))

  (define all-code
    (p:code (define (player-entity)
              (sprite->entity player-sprite
                              #:name       "player"
                              #:position   (posn 100 100)
                              #:components (physical-collider)
                                           (key-movement 10)
                                           #,target
                                           (on-start (go-to-pos-inside 'bottom-center))
                              ))))

  (code+hints all-code
              (list target (hint "New code"))))

(define-image-file add-wrap-or-stop
  images
  (add-wrap-or-stop-code))


#;(define stop-on-edge-v2-code-img (p:scale (p:code (stop-on-edge 'left 'right)) 4 ))

#;(define stop-on-edge-improved
  (activity-instructions "Stop On Edge Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the left and right edge stoppers and replace it with this improved code:")
                          (instruction-image (text-with-image "      " stop-on-edge-v2-code-img) 640 140 "")
                          (instruction-basic "Options are (blank), 'left, 'right, 'top, and 'bottom.")
                          (instruction-goal "your player stopping on left and right edges."))
                        (launcher-img stop-improved-video)))

#;(define wrap-around-v2-code-img (p:scale (p:code (wrap-around 'top-bottom)) 4 ))

#;(define wrap-around-improved
  (activity-instructions "Wrap Around Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the top and bottom wrap around and replace it with this improved code:")
                          (instruction-image (text-with-image "      " wrap-around-v2-code-img) 640 140 "")
                          (instruction-basic "Remove right, top, and bottom edges from (start-game).")
                          (instruction-goal "your player wrapping around."))
                        (launcher-img wrap-improved-video)))





(define edge-options
  (activity-instructions "Different Edge Rules"
                         '()
                         (list                        
                          (instruction-basic "Use the launch code to see different Wrap Around and Stop on Edge options for your player.")
                          (instruction-basic "Choose one to try first.")
                          (instruction-goal "which option you chose."))
                        (launcher-img wrap-or-stop)))

(define test-edge-options
  (activity-instructions "Test the Options"
                         '()
                         (list 
                          (instruction-basic "Add the code to the player-entity.")
                          (instruction-basic "Test the game and see how the player interacts with the edges of the screen.")
                          (instruction-basic "Replace that option with another option and test that.")
                          (instruction-goal "the difference between wrap-around and stop-on-edge."))
                        (launcher-img add-wrap-or-stop)))

(define choose-edge-option
  (activity-instructions "Make the Call"
                         '()
                         (list                        
                          (instruction-basic "Now that you have play-tested different options, pick which code you want for your game.")
                          (instruction-basic "Correct the play-entity code to match your choice.")
                          (instruction-goal "your chosen edge rules in your game."))
                        (launcher-img wrap-or-stop)))

(define choose-your-own-adventure
  (activity-instructions "What Next?"
                         '()
                         (list                        
                          (instruction-basic "Look at the next 4 cards.")
                          (instruction-basic "Pick something you would like to try in your game.")
                          (instruction-basic "Finshed one card? Keep exploring with another!"))
                        (p:ghost (p:circle 1))))

(define random-hue-code-img (p:scale (p:code (change-img-hue (random 360) [IMAGE] )) 4 ))

;refactor this video to launched code
(define random-hue-background
  (activity-instructions "Random Hue Background"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the background image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your bg image.")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color background"))
                        (launcher-img random-bg-video)))

;refactor this video to launched code
(define random-hue-player
  (activity-instructions "Random Hue Player"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the player image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your sheet/image")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color sprite."))
                        (launcher-img random-player-video)))


;day 7 Stop on Edge and Wrap Around
(define day6-2dgame
  (list
   (with-award 0 open-file)
   ;list of stop on edge
   (with-award 0 edge-options)
   ;test different combos on player
   (with-award 2 test-edge-options)
   ;make creative choice on what you want
   (with-award 1 choose-edge-option)
   (choose "any"
          (list
           ;choose any/all of the following cards
           (with-award 0 choose-your-own-adventure)
           ;scale an entity
           ;New bg
           (with-award 1 random-hue-background)
           (with-award 1 random-hue-player) 
           ))
   ))

(define (quest6)
  (map shrink (make-picts "red" "Q6-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) LINK LINK-BONUS LINK-BONUS ))))



