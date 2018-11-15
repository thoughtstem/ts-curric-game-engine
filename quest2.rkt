#lang racket


;High level goals:
#;(

   Title: Customizing collectables

   Main goal: Design a new collectable
      * Draw non-animated sprite in Piskel
      * Export image
      * Integrate into file

   Stretch goals:
      * Duplicate number of collectables in the game.
      * Add additional collectable

  ================

   Quest-complete goals:  Create additional collectables, using less scaffolding.
      * Remove hint card scaffold:    Do it without quests cards


   Mastery level 1:  I have added enough collectables such that I can now do it without
   any scaffolding.
       * Test your mastery:  Do it in under 5 minutes (not including Piskel time),
       without hint cards.  You may use an existing file with existing entities.


   Mastery level 2:  I understand the functions I'm using, and their documented meanings,
   well enough to be able to add new collectables to a game that doesn't have them.
       * Test your mastery:  Using only the documentation, add collectables to a
       game that doesn't already have them.
      
   )


(provide quest2)

(require ts-racket)
(require ts-curric-common)

(require net/sendurl)

(require (prefix-in p: pict/code))
(require (prefix-in p: pict))
(require racket/runtime-path)
(define-runtime-path images "images")

(require "./common.rkt")

(define-webpage redesign-sprite-video
  this-curriculum
  "http://bit.ly/2It8CdW")


(define (more-items-code)

  (define new-code
    (p:frame #:color "red"
     (p:code
      (item-entity item-sprite (posn 300 300))
      (item-entity item-sprite (posn 250 100)))))

  (define c
    (p:code
     (start-game (instructions-entity)
                 ...
                 (item-entity item-sprite (posn 200 200))
                 #,new-code
                 (player-entity)
                 ...
                 bg-entity)))

  (code+hints c
              (list new-code (hint "New code"
                                   "Experiment with posn."))))


(define-image-file more-items
  images
  (more-items-code))


(define (multiple-items-code)

  (define new-code
    (p:frame #:color "red"
     (p:code
      (item-entity new-item-sprite (posn 250 100))
      (item-entity new-item-sprite (posn 250 100))
      )))

  (define c
    (p:code
     (start-game (instructions-entity)
                 ...
                 (item-entity item-sprite (posn 300 300))
                 (item-entity item-sprite (posn 250 100))
                 (item-entity item-sprite (posn 200 200))
                 #,new-code
                 (player-entity)
                 ...
                 bg-entity)))

  (code+hints c
              (list new-code (hint "New code"
                                   "Remember to use YOUR item identifier"
                                   "(Probably not new-item-entity)"))))


(define-image-file multiple-items
  images
  (multiple-items-code))


(define (copy-item-definition-code)

  (define r (p:code-align (p:scale (random-dude) 0.25)))

  (define new-def-id
    (p:frame #:color "red"
             (p:code new-item-sprite)))

  (define new-def
    (p:frame #:color "red"
             (p:code
              (define #,new-def-id
                (sheet->sprite #,r
                               #:columns    5
                               #:speed      2)))))

  (define c
    (p:code
     (define item-sprite
       (sheet->sprite #,r
                      #:columns    5
                      #:speed      2))

     #,new-def
     ))

  (code+hints c
              (list new-def (hint "Copy and paste your item definition."))
              (list new-def-id (hint "Make sure to change the identifier"
                                     "on the new definition."))))


(define-image-file copy-item-definition
  images
  (copy-item-definition-code)) 




(define add-more-collectibles
  (activity-instructions "Add More Items"
                         '()
                         (list                        
                          (instruction-basic "Find the item-entity code inside start-game.")
                          (instruction-basic "Select and copy it with CTRL+C.")
                          (instruction-basic "Make a new line and paste it with CTRL+V.")
                          (instruction-basic (text-with-image "Modify the " (codify "posn") " values."))
                          (instruction-goal "your game with multiple items."))

                         
                         (launcher-img more-items)

                        ))



(define copy-paste-item-code
  (activity-instructions "Copy an Existing item"
                         '()
                         (list                        
                          (instruction-basic "Find an existing item definition in your code")
                          (instruction-basic "Select and copy it with CTRL+C.")
                          (instruction-basic "Make a new line after that definition; paste with CTRL+V.")
                          (instruction-basic "Change the identifier for the new definition.")
                          (instruction-goal "the duplicated and edited code."))

                         ;TODO:FIX
                         (launcher-img copy-item-definition)))

(define draw/export/insert-sprite
  (activity-instructions "Create new item in Piskel"
                         '()
                         (list                        
                          (instruction-basic "Draw new item in Piskel")
                          (instruction-basic "Export to SAVE_MY_WORK")
                          (instruction-basic "Insert into your new item definition")
                          (instruction-goal "your new image in your item definition."))

                        (launcher-img replace-sprite)))

(define add-new-item-and-test
  (activity-instructions "Add to start-game and Test"
                         '()
                         (list                        
                          (instruction-basic "Add your new item to start-game")
                          (instruction-basic "Use the launch code for an example")
                          (instruction-goal "your game with at least two different items."))

                        ;TODO:Make a launcher for this.
                        (launcher-img multiple-items)
                        ))


;Design your own Collectible
(define day2-2dgame
  (list
   (with-award 0 open-file)
   (with-award 2 (draw-sprite "collectibles.png" "Item"))
   (with-award 0 export-from-piskel)

   (with-award 3 (replace-sheet "Item"))
   (with-award 1  test-game)
   (choose "any"
           (list
            
            (with-award 1 add-more-collectibles)

            (with-award 1 copy-paste-item-code)
            (with-award 1 draw/export/insert-sprite)
            (with-award 1 add-new-item-and-test)
            
            ))))

(define s (settings (bg (local-bitmap "bg-arcade.png")) MARIO MARIO-BONUS MARIO-BONUS))

(define (quest2)
  (map shrink (make-picts "red" "Q2-" day2-2dgame s)))

(module+ test
  (analyze-activities day2-2dgame s))