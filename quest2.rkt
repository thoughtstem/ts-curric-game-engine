#lang racket

(provide quest2)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")

;High level goals:
#;(

   Title: Customizing collectables

   Main goal: Design a new collectable
      * Draw non-animated sprite in Piskel
      * Export image
      * Integrate into file

   Stretch goal: Duplicate number of collectables in the game.  

   Quest-complete goals:  Animate something of your choice, using less scaffolding.
      * Remove starter code scaffold: Create an entire new animated thing (same file)
      * Remove hint card scaffold:    Do it without quests cards


   Mastery goal:  I have animated enough things such that I can now do it without
   any scaffolding.
       * Test your mastery:  Do it in under 5 minutes (not including animation time),
       without hint cards.  You may use an existing file with existing entities.
      
   )



(define-webpage redesign-sprite-video
  this-curriculum
  "http://bit.ly/2It8CdW")


  
(define (redesign-sprite url)
  (activity-instructions "Re-design Your Sprite"
                         '()
                         (list
                          (instruction-basic "Add more detail to your sprite.")                          
                          (instruction-basic "Insert it in your code.")
                          (instruction-basic "Scale down the image if it is too big.")
                          (instruction-goal "your new changes running in game."))
                        (launcher-img redesign-sprite-video)))


(define (change-position url)
  (activity-instructions "Change the Start Position"
                         '()
                         (list                        
                          (instruction-basic "Find your collectible's posn values at the bottom.")
                          (instruction-basic "Make your collectible start far away.")
                          (instruction-basic "TIP: (posn 0 0) is the top left corner.")
                          (instruction-goal "your collectible starting far away in game."))
                        (p:scale-to-fit (local-bitmap "posn_helper_640.png") 300 300 #:mode 'preserve)))


(define-webpage more-items-video
  this-curriculum
  "https://bit.ly/2G9sIwr")

(define (add-more-collectibles url)
  (activity-instructions "Add More Items"
                         '()
                         (list                        
                          (instruction-basic "Find the item-entity code inside start-game")
                          (instruction-basic "Select and copy it with CTRL+C.")
                          (instruction-basic "Make a new line and paste it with CTRL+V.")
                          (instruction-basic "Modify the position values.")
                          (instruction-goal "your game with multiple items."))
                        (launcher-img more-items-video)))


;Design your own Collectible
(define day2-2dgame
  (list
   (with-award 2 (draw-sprite "collectibles.png" "Collectible"))
   (with-award 0 export-from-piskel)
   (with-award 0 open-file)
   (with-award 3 (replace-sheet "Collectable"))
   (with-award 1  test-game)
   (choose "any"
           (list
            (with-award 0 (import-to-piskel "Collectible"))
            (with-award 3 (redesign-sprite "http://bit.ly/2It8CdW"))
            (with-award 1 (change-position "http://bit.ly/2tTaFoi"))
            (with-award 1 (add-more-collectibles "https://bit.ly/2G9sIwr"))))))

(define (quest2)
  (map shrink (make-picts "red" "Q2-" day2-2dgame (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))))


