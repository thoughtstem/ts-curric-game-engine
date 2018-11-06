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

(define add-edges
  (activity-instructions "Add More Edges"
                         '()
                         (list                        
                          (instruction-basic "Find (start-game ...)")
                          (instruction-basic "AFTER (left-edge), type:")
                          (instruction-image (text-with-image "             " add-edges-code-img) 640 140 "")
                          (instruction-goal "your new code."))
                        (video-qr "https://bit.ly/2JCHI38")))



(define stop-on-left-code-img (p:scale (p:code (on-collide "left edge" (go-to-pos-inside 'left)))
                                       4 ))

(define stop-on-left-edge
  (activity-instructions "Stop On Left Edge"
                         '()
                         (list                        
                          (instruction-basic "Find (define (hero-entity) ...)")
                          (instruction-basic "AFTER (key-movement ...), type:")
                          (instruction-image (text-with-image "      " stop-on-left-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player stopping on the left edge"))
                        (video-qr "https://bit.ly/2KoUseY")))


(define more-stop-on-edge-code-img (p:scale (p:code (on-collide "right edge"  (go-to-pos-inside 'right))
                                                    (on-collide "top edge"    (go-to-pos-inside 'top))
                                                    (on-collide "bottom edge" (go-to-pos-inside 'bottom))
                                                    )
                                            4 ))

(define more-stop-on-edge
  (activity-instructions "More Stop On Edges"
                         '()
                         (list                        
                          (instruction-basic "Add more edge stoppers for right, top, and bottom.")
                          (instruction-basic "It should look like this:")
                          (instruction-image (text-with-image "      " more-stop-on-edge-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player stopping on all edges"))
                         (video-qr "https://bit.ly/2rajRkC")))

(define wrap-around-code-img (p:scale (p:code (on-collide "top edge"    (go-to-pos-inside 'bottom))
                                              (on-collide "bottom edge" (go-to-pos-inside 'top))
                                              )
                                      4 ))

(define wrap-around-top-bottom
  (activity-instructions "Wrap Around"
                         '()
                         (list                        
                          (instruction-basic "Modify the code to make the top edge send you to the bottom and the bottom edge to the top.")
                          (instruction-basic "It should look like this:")
                          (instruction-image (text-with-image "      " wrap-around-code-img) 640 140 "")
                          (instruction-basic "Run the game.")
                          (instruction-goal "your player wrapping around."))
                        (video-qr "https://bit.ly/2KstkMa")))



(define stop-on-edge-v2-code-img (p:scale (p:code (stop-on-edge 'left 'right)) 4 ))

(define stop-on-edge-improved
  (activity-instructions "Stop On Edge Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the left and right edge stoppers and replace it with this improved code:")
                          (instruction-image (text-with-image "      " stop-on-edge-v2-code-img) 640 140 "")
                          (instruction-basic "Options are (blank), 'left, 'right, 'top, and 'bottom.")
                          (instruction-goal "your player stopping on left and right edges."))
                        (video-qr "https://bit.ly/2ra1U5y")))

(define wrap-around-v2-code-img (p:scale (p:code (wrap-around 'top-bottom)) 4 ))

(define wrap-around-improved
  (activity-instructions "Wrap Around Improved"
                         '()
                         (list                        
                          (instruction-basic "Erase the top and bottom wrap around and replace it with this improved code:")
                          (instruction-image (text-with-image "      " wrap-around-v2-code-img) 640 140 "")
                          (instruction-basic "Remove right, top, and bottom edges from (start-game).")
                          (instruction-goal "your player wrapping around."))
                        (video-qr "https://bit.ly/2r9nfvh")))


(define random-hue-code-img (p:scale (p:code (change-img-hue (random 360) [IMAGE] )) 4 ))

(define random-hue-background
  (activity-instructions "Random Hue Background"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the background image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your bg image.")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color background"))
                        (video-qr "https://bit.ly/2I6q7nf")))

(define random-hue-player
  (activity-instructions "Random Hue Player"
                         '()
                         (list                        
                          (instruction-basic "Add this code around the player image: ")
                          (instruction-image (text-with-image "   " random-hue-code-img) 640 140 "")
                          (instruction-basic "[IMAGE] = your sheet/image")
                          (instruction-basic "Works best with bright colors.")
                          (instruction-goal "a random color sprite."))
                        (video-qr "https://bit.ly/2HElPE3")))


;day 7 Stop on Edge and Wrap Around
(define day6-2dgame
  (list
   (with-award 0 open-file)
   (with-award 1 add-edges)
   (with-award 1 stop-on-left-edge)       
   (with-award 2 more-stop-on-edge)                
   (with-award 1 wrap-around-top-bottom)
   (choose "any"
          (list
           (with-award 2 stop-on-edge-improved)
           (with-award 2 wrap-around-improved)
           (with-award 1 random-hue-background)
           (with-award 1 random-hue-player) 
           ))
   ))

(define (quest6)
  (map shrink (make-picts "red" "Q6-" day6-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))



