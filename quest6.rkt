#lang racket

;High level goals:
#;(

   Title: Edge Rules, Etc.

   Main goal: Add edge rules to the game
      * Test different edge rules
      * Choose between stop-on-edge and wrap-around combinations

   Stretch goals [A random assortment of things related to wrapping images in function calls]:
      * Randomly hue a player
      * Randomly hue the background
      * Add a new background
      * Scale an entity

   ======

   Quest-complete goals:  Add edge rules with less scaffolding
      * Suggestions (since it doesn't make sense to add MORE edge rules)
         * Ask student to: Remove the edge rules from the game without breaking anything else
         * Add them back in with fewer (no?) quest cards
      * Randomly hue other entities with less scaffolding
      * Add a new custom background with less scaffolding
      * Scale entities (players, enemies, items, etc) with less scaffolding

   Mastery level 1:
    * Test your mastery:  Do any of the above in under 5 minutes without hint cards.
    You may use an existing file as long as it does not have the relevant code already written.


   Mastery level 2:  I understand the functions I'm using, and their documented meanings,
   well enough to be able to do any of the above.
       * Test your mastery:  Using only the documentation, do all of the above in a
       game file that does not have the relevant code already written.
      
   )



(provide quest6)

(require (except-in ts-racket id))
(require ts-curric-common)

(require net/sendurl)


(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")


(define (wrap-around-or-stop-on-edge-list)

  (define BREAK (p:ghost (p:rectangle 10 10)))

  (p:vl-append
   (inset-frame
    (p:vl-append
     (p:text "Option 1")
     (p:code (stop-on-edge))))
   BREAK
   (inset-frame
    (p:vl-append
     (p:text "Option 2")
     (p:code (wrap-around))))
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

(define-launcher-function wrap-or-stop
  wrap-around-or-stop-on-edge-list)

(define (add-wrap-or-stop-code)

  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest5_complete.rkt"
                      (add-to-player-entity-components
                       '(stop-on-edge))))
  
  (code+hints main
              (list (first hint-targets) (hint "New code"))))


(define-launcher-function add-wrap-or-stop
  add-wrap-or-stop-code)



(define (edge-options)
  (activity-instructions "Different Edge Rules"
                         '()
                         (list                        
                          (instruction-basic "Use the launch code to see different Wrap Around and Stop on Edge options for your player.")
                          (instruction-basic "Choose one to try first.")
                          (instruction-goal "which option you chose."))
                        (launcher-img wrap-or-stop)))

(define (test-edge-options)
  (activity-instructions "Test the Options"
                         '()
                         (list 
                          (instruction-basic "Add the code to the player-entity.")
                          (instruction-basic "Test the game and see how the player interacts with the edges of the screen.")
                          (instruction-basic "Replace that option with another option and test that.")
                          (instruction-goal "the difference between wrap-around and stop-on-edge."))
                        (launcher-img add-wrap-or-stop)))

(define (choose-edge-option)
  (activity-instructions "Make the Call"
                         '()
                         (list                        
                          (instruction-basic "Now that you have play-tested different options, pick which code you want for your game.")
                          (instruction-basic "Correct the play-entity code to match your choice.")
                          (instruction-goal "your chosen edge rules in your game."))
                        (p:ghost (p:circle 1))
                        ))

(define (choose-your-own-adventure)
  (activity-instructions "What Next?"
                         '()
                         (list                        
                          (instruction-basic "Look at the next 4 cards.")
                          (instruction-basic "Pick something you would like to try in your game.")
                          (instruction-basic "Finshed one card? Keep exploring with another!"))
                        (p:ghost (p:circle 1))))


(define (random-bg-hue-code)
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_1.rkt"
                      (wrap-image-within ground-sprite-definition
                                         '(change-img-hue (random 360) REPLACE-HERE ))))



  (code+hints main
              (list (first hint-targets)
                    (hint "Write the code before"
                          "the image and add a new"
                          "parenthesis after the image."))))

(define-launcher-function random-bg-hue
  random-bg-hue-code)


(define (random-player-hue-code)
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_1.rkt"
                      (wrap-image-within player-sprite-definition
                                         '(change-img-hue (random 360) REPLACE-HERE ))))



  (code+hints main
              (list (first hint-targets)
                    (hint "Write the code before"
                          "the image and add a new"
                          "parenthesis after the image."))))



(define-launcher-function random-player-hue
  random-player-hue-code)

;refactor this video to launched code
(define (random-hue-background)
  (activity-instructions "Random Hue Background"
                         '()
                         (list                        
                          (instruction-basic "Surround your background image with a call to change-img-hue ")
                          (instruction-basic "Use the launch code to see how.")
                          (instruction-basic "(NOTE: This works best with a brightly colored background)")
                          (instruction-goal "a random colored background in your game"))
                        (launcher-img random-bg-hue)))


(define (random-hue-player)
  (activity-instructions "Random Hue Player"
                         '()
                         (list                        
                          (instruction-basic "Surround your player image with a call to change-img-hue ")
                          (instruction-basic "Use the launch code to see how.")
                          (instruction-basic "(NOTE: This works best with a brightly colored player)")
                          (instruction-goal "a random colored player in your game"))
                        (launcher-img random-player-hue)))

(define-launcher-function piskel:resize-canvas
  (thunk
   (p:bitmap (build-path images "resize-canvas.png"))))

(define (new-custom-background)
  (activity-instructions "Custom Background"
                         '()
                         (list                        
                          (instruction-basic "Open Piskel.  Resize the canvas to 640x480.")
                          (instruction-basic "Use the launch code if you don't know how.")
                          (instruction-basic "Draw your background.")
                          (instruction-basic "Export and replace the old background in your code.")
                          (instruction-goal "your new custom background"))
                        (launcher-img piskel:resize-canvas)))



(define (scale-an-item-code)
  (define-values (main hint-targets)
    (try-smw-and-then "tsgd_runner_quest5_complete.rkt"
                      (wrap-image-within item-sprite-definition
                                         '(scale 2 REPLACE-HERE ))))


  (code+hints main
              (list (first hint-targets)
                    (hint "Write the code before the image and add a new"
                          "parenthesis after the image."
                          ""
                          "A number between 0 and 1 will shrink."
                          "A number between 1 and 5 will grow."
                          "Numbers greater than 5 will probably be too big,"
                          "possibly crashing your game."))))

(define-launcher-function scale-an-item
  scale-an-item-code)

(define (scale-the-item)
  (activity-instructions "Scale An Item"
                         '()
                         (list                        
                          (instruction-basic "Surround your player image with a call to scale ")
                          (instruction-basic "Use the launch code to see how.")
                          (instruction-goal "the scaled item in game"))
                        (launcher-img scale-an-item)))


;day 7 Stop on Edge and Wrap Around
(define (day6-2dgame)
  (list
   (with-award 0 open-file)
   ;list of stop on edge
   (with-award 0 (edge-options))
   ;test different combos on player
   (with-award 2 (test-edge-options))
   ;make creative choice on what you want
   (with-award 1 (choose-edge-option))
   (choose "any"
          (list
           ;choose any/all of the following cards
           (with-award 0 (choose-your-own-adventure))
           (with-award 1 (random-hue-background))
           (with-award 1 (random-hue-player))
           (with-award 1 (new-custom-background))
           (with-award 1 (scale-the-item))
           ))
   ))

(define s (settings (bg (local-bitmap "bg-arcade.png")) (LINK) (LINK-BONUS) (LINK-BONUS )))

(define (quest6)
  (map shrink (make-picts "red" "Q6-" (day6-2dgame) s)))


(module+ test
  (analyze-activities (day6-2dgame) s))


  
