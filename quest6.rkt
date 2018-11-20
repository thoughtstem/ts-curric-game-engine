#lang racket

(provide quest6)
(require ts-curric-common)
(require (except-in ts-racket id))
(require "./common.rkt")

;DEFINE the high level goals of this quest

#;(define-quest-data quest6-data
  #:title "Edge Rules, Etc."
    
  #:at-minimum-student-can 
  "Add edge rules to the game"
  "Test different edge rules in game"
  "Choose between stop-on-edge and wrap-around combinations"
  "Articulate difference between stop-on-edge and wrap-around"

  #:at-minimum-student-can-also
  "Make a player's hue random"
  "Make the background's hue random"
  "Add a new background created in Piskel to their game"
  "Change the scale of an item"

  #:expert-level-students-can
  "Do any of the above in under 5 minutes without hint cards."
  "May use an existing file (tsgd_runner_quest5_complete.rkt) as long as it does not have the relevant code already written."

  #:master-level-students-can
  "Understand the functions and their documented meanings well enough to be able to do any of the above without hint cards."
  "Can do all of the above in a game file that does not have the relevant code already written."
  "May refer to documentation.")

;DEFINE THE RESOURCES, -- e.g. (launch ...) codes

(define-ABSORB-resource learn:wrap-or-stop
  #:learning-resource
  (wrap-around-or-stop-on-edge-list))

(define-CODE-resource code:wrap-or-stop
    #:in-file     "tsgd_runner_quest5_complete.rkt"
    #:code-change (add-to-player-entity-components '(stop-on-edge))
    #:description (hint "New Code"))

(define-CODE-resource code:player-hue
  #:in-file "tsgd_runner_quest5_complete.rkt"
  #:code-change
  (wrap-image-within player-sprite-definition
                     '(change-img-hue (random 360) REPLACE-HERE ))
  #:description
  (hint "Write the code before"
        "the image and add a new"
        "parenthesis after the image."))

(define-CODE-resource code:bg-hue
  #:in-file "tsgd_runner_quest5_complete.rkt"
  #:code-change
  (wrap-image-within ground-sprite-definition
                     '(change-img-hue (random 360) REPLACE-HERE ))
  #:description
  (hint "Write the code before"
        "the image and add a new"
        "parenthesis after the image."))
  
(define-CODE-resource scale-the-item
  #:in-file "tsgd_runner_quest5_complete.rkt"
  #:code-change
  (wrap-image-within item-sprite-definition
                     '(scale 2 REPLACE-HERE ))
  #:description
  (hint "Write the code before the image and add a new"
        "parenthesis after the image."
        ""
        "A number between 0 and 1 will shrink."
        "A number between 1 and 5 will grow."
        "Numbers greater than 5 will probably be too big,"
        "possibly crashing your game."))


;Class flow cards

(define-classroom-flow quest6
  (settings (bg (local-bitmap "bg-arcade.png")) (LINK) (LINK-BONUS) (LINK-BONUS))
    
  (with-award 0 open-file)

  (activity #:award 0
            #:title "Different Edge Rules"
            #:show-teacher "which option you chose"
            #:resource     learn:wrap-or-stop
            #:instructions
            "Use the launch code to see different Wrap Around and Stop on Edge options for your player."
            "Choose one to try first.")
 
  (activity #:award 2
            #:title "Test the Options"
            #:show-teacher "the difference between wrap-around and stop-on-edge."
            #:resource     code:wrap-or-stop
            #:instructions
            "Add the code to the player-entity."
            "Test the game and see how the player interacts with the edges of the screen."
            "Replace that option with another option and test that.")


  (activity #:award 1
            #:title  "Make the Call"
            #:show-teacher "your chosen edge rules in your game."
            #:instructions
            "Now that you have play-tested different options, pick which code you want for your game."
            "Correct the play-entity code to match your choice.")


  (choose-any
   (activity #:award 0
             #:title  "What Next?"
             #:instructions
             "Now that you have play-tested different options, pick which code you want for your game."
             "Correct the play-entity code to match your choice."
             "Finshed one card? Keep exploring with another!")

   (activity #:award 1
             #:title  "Random Hue Background"
             #:show-teacher "a random colored background in your game"
             #:resource code:bg-hue
             #:instructions
             "Surround your background image with a call to change-img-hue "
             "Use the launch code to see how."
             "(NOTE: This works best with a brightly colored background)")

   (activity #:award 1
             #:title  "Random Hue Player"
             #:show-teacher "a random colored player in your game"
             #:resource code:player-hue
             #:instructions
             "Surround your player image with a call to change-img-hue "
             "Use the launch code to see how."
             "(NOTE: This works best with a brightly colored player)")

   (activity #:award 1
             #:title   "Custom Background"
             #:show-teacher "your new custom background"
             #:resource piskel:resize-canvas
             #:instructions
             "Open Piskel.  Resize the canvas to 640x480."
             "Use the launch code if you don't know how."
             "Draw your background."
             "Export and replace the old background in your code.")

   (activity #:award 1
             #:title   "Scale An Item"
             #:show-teacher "the scaled item in game"
             #:resource scale-the-item
             #:instructions
             "Surround your player image with a call to scale"
             "Use the launch code to see how.")))





;===== Supporting Functions ====

(require (prefix-in p: pict))
(require (prefix-in p: pict/code))


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


(define-launcher-function piskel:resize-canvas
  (thunk
   (p:bitmap (build-path images "resize-canvas.png"))))





